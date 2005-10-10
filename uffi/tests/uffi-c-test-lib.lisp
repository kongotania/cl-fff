;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; *************************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          uffi-c-test-lib.lisp
;;;; Purpose:       UFFI Example file for zlib compression
;;;; Programmer:    Kevin M. Rosenberg
;;;; Date Started:  Mar 2002
;;;;
;;;; $Id: uffi-c-test-lib.lisp 454 2003-09-07 06:34:45Z kevin $
;;;;
;;;; This file, part of UFFI, is Copyright (c) 2002-2003 by Kevin M. Rosenberg
;;;;
;;;; *************************************************************************

(in-package #:uffi-tests)


(uffi:def-function ("cs_to_upper" cs-to-upper)
  ((input (* :unsigned-char)))
  :returning :void
  )

(defun string-to-upper (str)
  (uffi:with-foreign-string (str-foreign str)
    (cs-to-upper str-foreign)
    (uffi:convert-from-foreign-string str-foreign)))

(uffi:def-function ("cs_count_upper" cs-count-upper)
  ((input :cstring))
  :returning :int
  )

(defun string-count-upper (str)
  (uffi:with-cstring (str-cstring str)
    (cs-count-upper str-cstring)))

(uffi:def-function ("half_double_vector" half-double-vector)
    ((size :int)
     (vec (* :double)))
  :returning :void)

(uffi:def-constant +double-vec-length+ 10)
(defun test-half-double-vector ()
  (let ((vec (uffi:allocate-foreign-object :double +double-vec-length+))
	results)
    (dotimes (i +double-vec-length+)
      (setf (uffi:deref-array vec '(:array :double) i) 
	    (coerce i 'double-float)))
    (half-double-vector +double-vec-length+ vec)
    (dotimes (i +double-vec-length+)
      (push (uffi:deref-array vec '(:array :double) i) results))
    (uffi:free-foreign-object vec)
    (nreverse results)))

(defun t2 ()
  (let ((vec (make-array +double-vec-length+ :element-type 'double-float)))
    (dotimes (i +double-vec-length+)
      (setf (aref vec i) (coerce i 'double-float)))
    (half-double-vector +double-vec-length+ vec)
    vec))

#+(or cmu scl)
(defun t3 ()
  (let ((vec (make-array +double-vec-length+ :element-type 'double-float)))
    (dotimes (i +double-vec-length+)
      (setf (aref vec i) (coerce i 'double-float)))
    (system:without-gcing
     (half-double-vector +double-vec-length+ (system:vector-sap vec)))
    vec))
    
(deftest c-test.1 (string-to-upper "this is a test") "THIS IS A TEST")
(deftest c-test.2 (string-to-upper nil) nil)
(deftest c-test.3 (string-count-upper "This is a Test") 2)
(deftest c-test.4 (string-count-upper nil) -1)
(deftest c-test.5 (test-half-double-vector)
  (0.0d0 0.5d0 1.0d0 1.5d0 2.0d0 2.5d0 3.0d0 3.5d0 4.0d0 4.5d0))

