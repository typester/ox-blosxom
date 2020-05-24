(require 'ert)
(require 'ox-blosxom)

(setq org-export-async-debug t)

(ert-deftest paragraph ()
  (should (equal "<p>foo\nbar</p>\n<p>buzz</p>\n"
                 (org-export-string-as "foo
bar

buzz" 'blosxom t))))

(ert-deftest bold ()
  (should (equal "<p><strong>foo</strong></p>\n"
                 (org-export-string-as "*foo*" 'blosxom t))))

(ert-deftest h1 ()
  (should (equal "<h3>hoge</h3>\n"
                 (org-export-string-as "* hoge" 'blosxom t))))

(ert-deftest h1h2h3 ()
  (should (equal "<h3>hoge</h3>
<h3>hoge2</h3>
<h4>h2</h4>
<h5>h3</h5>
"
                 (org-export-string-as "* hoge\n* hoge2\n** h2\n*** h3" 'blosxom t))))

(ert-deftest title ()
  (should (equal "hoge\n\n"
                 (org-export-string-as "#+TITLE: hoge" 'blosxom))))

(ert-deftest title-and-body ()
  (should (equal "hoge\n\n<p>fuga</p>\n"
                 (org-export-string-as "#+TITLE: hoge\n\nfuga" 'blosxom))))

(ert-deftest code ()
  (should (equal "<pre><code class=\"perl\">hoge</code></pre>\n"
                (org-export-string-as "#+BEGIN_SRC perl
  hoge
#+END_SRC" 'blosxom t))))

(ert-deftest code-keyword ()
  (should (equal "<pre><code class=\"perl\"><span class=\"keyword\">use</span> <span class=\"constant\">strict</span>;</code></pre>\n"
                (org-export-string-as "#+BEGIN_SRC perl
  use strict;
#+END_SRC" 'blosxom t))))

(ert-deftest code-with-indent ()
  (should (equal "<pre><code class=\"emacs-lisp\">(add-hook 'before-save-hook 'gofmt-before-save)</code></pre>\n"
                 (org-export-string-as "   #+BEGIN_SRC emacs-lisp
     (add-hook 'before-save-hook 'gofmt-before-save)
   #+END_SRC
" 'blosxom t))))

(ert-deftest footnote ()
  (should (equal "<p>hello<a class=\"footref\" href=\"#fn1\" id=\"r1\">[1]</a></p>
<aside class=\"footdef\">
<p id=\"fn1\"><a href=\"#r1\">[1]</a> hoge</p>
</aside>
"
                 (org-export-string-as
  "hello[fn:1]

* Footnotes

[fn:1] hoge
"
'blosxom t))))

(ert-deftest meta-date ()
  (should (equal "hoge
meta-creation_date: 2013-06-10T13:47:00+0900\n\n"
                 (org-export-string-as "#+TITLE: hoge
#+DATE: <2013-06-10 Mon 13:47>
#+TZ: +0900 (JST)
" 'blosxom))))

(ert-run-tests-batch-and-exit)
