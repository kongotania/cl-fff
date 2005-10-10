(lw:defsystem "META-WEB"
  (:default-pathname "")
  :members (("INTERFACE" :type :system)
	    ("LISP-UTILITY" :type :system)
	    "global"
	    "style"
	    "classes"
	    "slot-info"
	    "class-info"
	    "sql-list"
	    "project-info"
	    "pages.lisp"
	    )
  :rules
  ((:in-order-to :compile :all (:requires (:load :previous)))
   (:in-order-to :load :all (:requires (:load :previous))))
  )
