(in-package "META-WEB")

(defun create-util-classes (store)
  (dolist (class '(source-file other-document clipboard))
     (meta::create-class-table store (find-class class))))


(prog1 (defclass source-file
                 nil
                 ((name :value-type string :user-name (make-instance 'meta-level:translated-string :en "Name" :fr "Nom" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (in-asdf :value-type boolean :user-name (make-instance 'meta-level:translated-string :en "In ADSF file" :fr "Dans le fichier ADSF" :de "" :sp "" :it "") :initform t :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (generated :value-type boolean :user-name (make-instance 'meta-level:translated-string :en "Generated file" :fr "Fichier g�n�r�" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (print-in-doc :value-type boolean :user-name (make-instance 'meta-level:translated-string :en "Included in documentation" :fr "Inclus dans la documentation" :de "" :sp "" :it "") :initform t :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (description :value-type string :user-name (make-instance 'meta-level:translated-string :en "Description" :fr "Description" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes '(:rows "10") :dont-display-null-value nil :view-type :medit :slot-view-name 'nil)
                  (file-pathname :value-type string :user-name (make-instance 'meta-level:translated-string :en "Pathname" :fr "Pathname" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (dependances :value-type source-file :user-name (make-instance 'meta-level:translated-string :en "Depends on this files" :fr "D�pend de ces Fichiers" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values t :new-objects-first nil :linked-value t :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :get-object-func 'get-source-files :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil))
                 (:user-name (make-instance 'meta-level:translated-string :en "source file" :fr "fichier source" :de "" :sp "" :it "") :guid 13849674944659178753520734794 :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :functions (list) :visible t :visible-groups 'nil :instanciable t :short-description '(if (generated object) (concatenate 'string (name object) " (generated)") (name object)))))

(prog1 (defclass other-document
                 nil
                 ((title :value-type string :user-name (make-instance 'meta-level:translated-string :en "Title" :fr "Titre" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (page-number :value-type string :user-name (make-instance 'meta-level:translated-string :en "Page number" :fr "N� de page" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable t :modifiable-groups 'nil :stored t :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable t :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil))
                 (:user-name (make-instance 'meta-level:translated-string :en "other document" :fr "document annexe" :de "" :sp "" :it "") :guid 12148755115583526910572654057 :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :functions (list) :visible t :visible-groups 'nil :instanciable t :short-description 'title)))

(prog1 (defclass clipboard
                 nil
                 ((operation :value-type t :user-name (make-instance 'meta-level:translated-string :en "" :fr "operation" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible nil :visible-groups 'nil :modifiable nil :modifiable-groups 'nil :stored nil :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable nil :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (source-object :value-type clipboard :user-name (make-instance 'meta-level:translated-string :en "" :fr "source-object" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable nil :modifiable-groups 'nil :stored nil :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable nil :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (source-slot :value-type clipboard :user-name (make-instance 'meta-level:translated-string :en "" :fr "source-slot" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable nil :modifiable-groups 'nil :stored nil :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values nil :new-objects-first nil :linked-value nil :modifiable nil :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil)
                  (objects :value-type clipboard :user-name (make-instance 'meta-level:translated-string :en "Copied objects" :fr "Objects copi�s" :de "" :sp "" :it "") :description "" :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "") :choices (list) :visible t :visible-groups 'nil :modifiable nil :modifiable-groups 'nil :stored nil :in-proxy nil :indexed nil :unique nil :null-allowed t :list-of-values t :new-objects-first nil :linked-value t :modifiable nil :duplicate-value t :make-copy-string nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :sql-length 0 :value-to-string-fn nil :nb-decimals 0 :void-link-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :can-create-new-object nil :create-new-object nil :process-new-object-fn 'nil :get-value-sql "" :html-tag-attributes 'nil :dont-display-null-value nil :view-type :default :slot-view-name 'nil))
                 (:user-name
                  (make-instance 'meta-level:translated-string :en "clipboard" :fr "clipboard" :de "" :sp "" :it "")
                  :guid
                  44565462735855467339436917756
                  :object-help
                  (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "")
                  :functions
                  (list (make-instance 'meta-level::fc-function :name 'paste-from-user-clipboard :user-name (make-instance 'meta-level:translated-string :en "" :fr "paste-from-user-clipboard" :de "" :sp "" :it "") :visible nil :visible-groups 'nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-sql "" :html-tag-attributes 'nil :disable-predicate 'nil :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "")) (make-instance 'meta-level::fc-function :name 'cut-to-user-clipboard :user-name (make-instance 'meta-level:translated-string :en "" :fr "cut-to-user-clipboard" :de "" :sp "" :it "") :visible nil :visible-groups 'nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-sql "" :html-tag-attributes 'nil :disable-predicate 'nil :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "")) (make-instance 'meta-level::fc-function :name 'clear-user-clipboard :user-name (make-instance 'meta-level:translated-string :en "Empty the clipboard" :fr "Vider le presse papier" :de "" :sp "" :it "") :visible t :visible-groups 'nil :get-value-title (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-text (make-instance 'meta-level:translated-string :en "" :fr "" :de "" :sp "" :it "") :get-value-sql "" :html-tag-attributes 'nil :disable-predicate 'nil :object-help (make-instance 'meta-level::object-help :en "" :fr "" :de "" :sp "" :it "" :en-h "" :fr-h "" :de-h "" :sp-h "" :it-h "")))
                  :visible
                  t
                  :visible-groups
                  'nil
                  :instanciable
                  t)))

