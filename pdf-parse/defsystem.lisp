(lw:defsystem "PDF-PARSE"
  (:default-pathname "")
  :members (("CL-PDF" :type :system)
	    "defpackage"
	    "pdf-parse"
	    )
  :rules
  ((:in-order-to :compile :all (:requires (:load :previous)))
   (:in-order-to :load :all (:requires (:load :previous))))
  )
