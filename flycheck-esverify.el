;;; flycheck-esverify.el --- Flycheck: esverify support

;; Copyright (C) 2017 Sohum Banerjea <sohumb@gmail.com>

;; Author: Sohum Banerjea <sohumb@gmail.com>
;; URL: https://github.com/SohumB/flycheck-esverify
;; Package-Version: 20170623.1
;; Keywords: convenience, tools, languages
;; Version: 0.1
;; Package-Requires: ((emacs "24.1") (flycheck "0.22"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This Flycheck extension provides a syntax checker for the esverify tool, as found in
;; https://github.com/levjj/esverify . You will need to configure both the path to the esverify executable and
;; the path to the z3 binary to use.

;;; code:

(require 'flycheck)

(flycheck-def-executable-var esverify "esverify")
(flycheck-def-executable-var esverify-z3 "/usr/bin/z3")

(flycheck-define-checker esverify
  "Run the esverify verifier on javascript files."

  :command ("esverify" "-f" "simple" "--z3path" (eval (eval (flycheck-checker-executable-variable 'esverify-z3))) source)
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ": error: " (message) line-end)
   (warning line-start (file-name) ":" line ":" column ": warning: " (message) line-end)
   (info line-start (file-name) ":" line ":" column ": info: " (message) line-end))
  :modes js2-mode
  )

(provide 'flycheck-esverify)

;;; flycheck-esverify.el ends here
