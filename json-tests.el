(require 'ert)
(require 'json)
(require 'ox-html-json)

(defun render-json-to-string (data)
  (let ((json-object-type 'plist))
    (json-read-from-string data)))

(ert-deftest title ()
  (let* ((json (render-json-to-string (org-export-string-as "#+TITLE: hoge" 'html-json)))
         (title (plist-get json :title)))
    (should (equal title "hoge"))))

(ert-deftest date ()
  (let* ((json (render-json-to-string (org-export-string-as "#+TITLE: hoge\n#+DATE: <2016-12-14 Wed 23:34>\n#+TZ: +0900 (JST)" 'html-json)))
         (date (plist-get json :date)))
    (should (equal date "2016-12-14T23:34:00+09:00"))))

(ert-deftest date2 ()
  (let* ((json (render-json-to-string (org-export-string-as "#+TITLE: hoge\n#+DATE: <2016-12-14 Wed 23:34>\n#+TZ: +0900" 'html-json)))
         (date (plist-get json :date)))
    (should (equal date "2016-12-14T23:34:00+09:00"))))

(ert-deftest tags ()
  (let* ((json (render-json-to-string (org-export-string-as "#+TITLE: hoge\n#+TAGS: foo bar" 'html-json)))
         (tags (plist-get json :tags)))
    (should (equal tags ["foo" "bar"]))))

(ert-deftest empty_tags ()
  (let* ((json (render-json-to-string (org-export-string-as "#+TITLE: hoge\n#+TAGS:" 'html-json)))
         (tags (plist-get json :tags)))
    (should (equal tags []))))

(ert-deftest image ()
  (let* ((json (render-json-to-string (org-export-string-as "#+IMAGE: https://example.com/thumbnail.jpg" 'html-json)))
         (image (plist-get json :image)))
    (should (equal image "https://example.com/thumbnail.jpg"))))

(ert-run-tests-batch-and-exit)
