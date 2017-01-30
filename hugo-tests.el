(require 'ert)
(require 'ox-hugo)

(ert-deftest title ()
  (should (equal "+++\ntitle = \"hoge\"\n+++\n"
                 (org-export-string-as "#+TITLE: hoge" 'hugo))))

(ert-deftest date ()
  (should (equal "+++\ntitle = \"hoge\"\ndate = \"2016-12-14T23:34:00+09:00\"\n+++\n"
                 (org-export-string-as "#+TITLE: hoge\n#+DATE: <2016-12-14 Wed 23:34>" 'hugo))))

(ert-deftest slug ()
  (should (equal "+++\ntitle = \"hoge\"\nslug = \"dameleon\"\n+++\n"
                 (org-export-string-as "#+TITLE: hoge\n#+SLUG: dameleon" 'hugo))))

(ert-deftest tags ()
  (should (equal "+++\ntitle = \"hoge\"\ntags = [\"foo\", \"bar\"]\n+++\n"
                 (org-export-string-as "#+TITLE: hoge\n#+TAGS: foo bar" 'hugo))))


(ert-run-tests-batch-and-exit)
