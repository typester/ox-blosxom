(require 'ox-simple-html)
(require 'json)

(org-export-define-derived-backend 'html-json 'simple-html
  :translate-alist '((template . org-html-json-template))
  :options-alist '((:tags "TAGS" nil nil split)))

(defun org-html-json-template (contents info)
  (let* ((title (org-export-data
                 (or (plist-get info :title) "") info))
         (timestamp (plist-get info :date))
         (datetime (if timestamp
                       (org-timestamp-format (car timestamp) "%Y-%m-%dT%T%z")
                     ""))
         (tags (plist-get info :tags))
         (data `(:title ,title
                        :date ,datetime
                        :tags ,tags
                        :content ,contents)))
    (json-encode data)))

;; End-user functions
(defun org-html-json-publish-to-json (plist filename pub-dir)
  (org-publish-org-to 'html-json filename
                      ".json"
                      plist pub-dir))

(provide 'ox-html-json)
