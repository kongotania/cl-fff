(in-package meta-web)

(defmethod project ((obj project))
  obj)

(defmethod project (obj)
  (when (meta::parent obj)
    (project (meta::parent obj))))

(defmethod project ((obj class-info))
  (project (meta::parent obj)))

(defmethod project ((obj class-group))
  (project (meta::parent obj)))

(defmethod meta::short-description ((obj project))
    (if (plusp (length (name obj))) (name obj) "(pas de nom)"))

(interface::add-named-url "/asp/new-project.html"
  #'(lambda (request)
      (let* ((project (make-instance 'project :store *meta-store*)))
	(interface::redirect-to (interface::encode-object-url project) request))
      t))

(defun html-project-list()
  #-no-psql(clsql:with-database (nil nil :pool *database-pool*)
    (loop for (project-id) in (clsql:query "select id from project" :types :auto)
	  for project = (meta::load-object project-id *meta-store*)
	  do (html:html ((:a :href (interface::encode-object-url project))
			 (html:esc (meta::short-description project)) :br))))
  (html:html :br ((:a :href "/asp/new-project.html") "new projet")))

(defparameter *meta-web-classes*
  '(slot-info class-info project choice-value user-group translated-string sql-list
    view-info rule-info function-info object-help class-group
    ))

(defun create-table (class &optional (store *meta-store*))
  (meta::create-class-table store class)
#+ignore
(handler-case (meta::create-class-table store class)
    (condition (c)
      (princ c))))

(defun create-tables (&optional (store *meta-store*))
  (loop for class in *meta-web-classes*
	do (create-table class store)))

(defun drop-table (class &optional (store *meta-store*))
  (meta::drop-class-table store class))

(defun drop-tables (&optional (store *meta-store*))
  (loop for class in *meta-web-classes*
	do (drop-table class store)))

(defun map-class-objects (class function &key (store *meta-store*) (where-clause ""))
  (when (symbolp class)(setf class (find-class class)))
  #-no-psql
  (clsql:with-database (nil nil :pool (meta::db-pool store))
    (clsql:do-query ((object-id)
		     (format nil "SELECT id FROM ~a ~a" (meta::sql-name class) where-clause)
		     :types :auto)
      (let ((object (meta::load-object object-id store)))
	(when object
	  (funcall function object))))))

(defun create-project-classes (proj)
  (let ((*package* (ensure-package (project-package proj)))
	(*current-class* nil)
	(*current-slot* nil)
	(*current-slot-attribute* nil)
	(classes ())
	(result nil))
;    (handler-case
       (progn
         (dolist (group (class-groups proj))
	   (dolist (class (classes group))
	     (push (eval (make-defclass class)) classes)))
	 (setf result t))
#+ignore      (condition (c)
         (interface::send-message-to-interface
           (format nil "Error in class ~s, slot ~s, attribut ~s\\nError Text : ~a"
		   (if *current-class* (name *current-class*) "no class")
		   (if *current-slot* (name *current-slot*) "no slot")
		   (if *current-slot-attribute* *current-slot-attribute* "no attribute")
		   c)));)
    (when result classes)))

(defun gen-graph (project filename &key (class-list nil class-list-supplied))
  (with-open-file (s filename :direction :output :if-exists :supersede)
    (format s "digraph G {
size=\"8,11\";
node [shape=box,fontname=Helvetica,fontsize=12];
edge [shape=box,fontname=Helvetica,fontsize=12];
rankdir=LR;
")
    (let ((classes (get-project-classes project))
	  (old-classes ()))
      (loop for class in classes do
	    (unless (or (member class old-classes)
			(and class-list-supplied (not (member class class-list))))
	      (let ((members-by-value-class (make-hash-table)))
		(push class old-classes)
		(format s "~s [shape=box,URL=~s];~%" (name class)
			(interface::encode-object-url class :absolute t))
		(loop for super in (direct-superclasses class) do
		      (unless (and class-list-supplied (not (member super class-list)))
			(format s "~s -> ~s [color=blue,labelfontcolor=blue,label=\"subclass\"];~%"
				(name super) (name class))))
		(loop for slot in (direct-slots class) 
		      for object-type = (object-type slot) do
		      (when (and (eq (value-type slot) :object)
				 (not (and class-list-supplied (not (member object-type class-list)))))
			(push slot (gethash object-type members-by-value-class))))
		(maphash #'(lambda(val-class slots)
			     (format s "~s -> ~s [label=\"~{~a~^\\n~}\"];~%"
				     (name class)(name val-class)(mapcar 'name slots)))
			 members-by-value-class)))))
    (format s "}~%")))

(defun gen-sub-graph (project classes depth filename)
  (let ((all-classes (get-project-classes project))
	(new-classes classes)
	(next-new-classes ()))
    (loop while new-classes
          repeat depth do
	  (loop for class in all-classes
		unless (member class classes) do
		(loop for super in (direct-superclasses class) do
		      (when (member super new-classes)
			(push class next-new-classes)
			(push class classes)))
		(loop for slot in (direct-slots class)
		      for object-type = (object-type slot) do
		      (when (and (eq (value-type slot) :object)
				  (member object-type new-classes))
			(push class next-new-classes)
			(push class classes))))
	  (loop for class in new-classes do
		(loop for super in (direct-superclasses class) do
		      (unless (member super classes)
			(push super next-new-classes)
			(push super classes)))
		(loop for slot in (direct-slots class)
		      for object-type = (object-type slot) do
		      (when (and (eq (value-type slot) :object)
				 (not (member object-type classes)))
			(push object-type next-new-classes)
			(push object-type classes))))
	  (setf new-classes next-new-classes
		next-new-classes ())))
  (gen-graph project filename :class-list classes))

(defun class-group-graph (class-group)
  (display-class-graph (project class-group) (classes class-group) 1))

(defun project-class-graph (project)
  (display-class-graph project (get-project-classes project) 0))

(defun make-identifier ()
  (let ((id (make-string 9)))
    (loop for i from 0 below 9
	  do (setf (aref id i) (code-char (+ 48 (random 10)))))
    id))

(defun html-user-page()
  (unless (interface::user interface::*session*)
    (interface::decode-posted-content interface::*request*)
    (let* ((posted-content (interface::posted-content interface::*request*))
	   (name (cdr (assoc "name" posted-content :test 'string=)))
	   (password (cdr (assoc "password" posted-content :test 'string=))))
      (when (and name password)
	#-no-psql(clsql:with-database (nil nil :pool *database-pool*)
	  (let* ((id (caar (clsql:query (format nil "select id from meta_user where identifier='~a'" name)
					:types :auto)))
		 (user (and id (meta::load-object id *meta-store*))))
	    (when (and user (string= password (password user)))
	      (setf (interface::authentified interface::*session*) t)
	      (setf (interface::user interface::*session*) user)
	      ))))))
    (if (interface::user interface::*session*)
      (interface::redirect-to (interface::encode-object-url (interface::user interface::*session*))
			      interface::*request*)
       (html:html
	((:form :method "post" :action (interface::url interface::*request*))
	 (:h1 "Vous devez vous authentifier pour acc�der � cette page.")
	 (:p "Nom  " ((:input :type "text" :name "name")) :br
	     "code " ((:input :type "password" :name "password")))
	 ((:input :type "submit" :name "submit" :value "Envoyer"))))))

(defun ensure-package (package)
  (let* ((name (safe-read-from-string package))
	 (found-package (find-package name)))
    (if found-package
	found-package
	(let ((package (make-package name)))
	  (import '(interface::*object*) package)
	  package))))

(defun view-all-classes-source (proj)
  (let* ((*package* (ensure-package (project-package proj)))
	 (*print-right-margin* 2000)
	 (file-id (interface::make-session-id))
	 (src-file (concatenate 'string *graph-file-prefix* file-id ".lisp")))
    (with-open-file (s src-file :direction :output :if-exists :supersede)
      (format s "(in-package ~s)~%" (package-name *package*))
      (dolist (group (class-groups proj))
	(dolist (class (classes group))
	  (print-class-source s class)))
      (format s "~%" (package-name *package*)))
    (interface::send-open-new-win-to-interface (format nil "/~a.lisp" file-id))))

(defun view-group-classes-source (group)
  (let* ((*package* (ensure-package (project-package (project group))))
	 (*print-right-margin* 2000)
	 (file-id (interface::make-session-id))
	 (src-file (concatenate 'string *graph-file-prefix* file-id ".lisp")))
    (with-open-file (s src-file :direction :output :if-exists :supersede)
      (format s "(in-package ~s)~%" (package-name *package*))
      (format s "
(defun create-~a-classes (store)
  (dolist (class '~a)
     (meta::create-class-table store (find-class class))))

"
	      (name group)
	      (mapcar 'name (remove-if-not 'instanciable (classes group))))
      (dolist (class (classes group))
	(print-class-source s class))
      (format s "~%"))
    (interface::send-open-new-win-to-interface (format nil "/~a.lisp" file-id))))

(defun get-project-values-tables (obj)
  (values-tables (project obj)))

(defun open-database (proj)
  (setf (db-connection proj)
	(clsql:find-or-create-connection-pool
	 (list (database-ip proj) (database proj) "lisp" "") :postgresql))
  (setf (store proj) (make-instance 'meta::psql-store :db-pool (db-connection proj))))

(defun create-database (proj)
  (meta::create-psql-database *database-pool* (database proj))
  (open-database proj)
  (meta::initialize-store (store proj))
  (dolist (class (create-project-classes proj))
    (when (meta::instanciable class)
      (create-table class (store proj)))))

(defun drop-database (proj)
  (when (db-connection proj)
    (clsql:disconnect-pooled (db-connection proj))
    (setf (db-connection proj) nil))
  (meta::drop-psql-database *database-pool* (database proj)))

(defun map-all-classes (proj fn)
  (dolist (group (class-groups proj))
    (dolist (class (classes group))
      (funcall fn class))))