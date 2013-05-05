Related.vim
===========

[![Build Status](https://secure.travis-ci.org/v-yarotsky/related.vim.png)](http://travis-ci.org/v-yarotsky/related.vim)
[![Coverage Status](https://coveralls.io/repos/v-yarotsky/related.vim/badge.png?branch=master)](https://coveralls.io/r/v-yarotsky/related.vim)
[![Code Climate](https://codeclimate.com/github/v-yarotsky/related.vim.png)](https://codeclimate.com/github/v-yarotsky/related.vim)

This plugin allows quick switching between ruby tests and sources, and to run tests

Requirements:
-------------

  * Ruby 1.8+
  * VIM compiled with ruby support

Installation:
-------------

Using [pathogen.vim](https://github.com/tpope/vim-pathogen):

```sh
cd ~/.vim/bundle
git clone git://github.com/v-yarotsky/related.vim.git
```

Usage:
------

command `:RelatedOpenFile` opens related file
command `:RelatedRunTest` runs related test
command `:RelatedPipe` makes the plugin echo test commands to given named pipe
command `:RelatedNoPipe` makes the plugin run test commands in background (default)

`RelatedPipe` is useful for GUI MacVim:

    $ mkfifo my_tests
    $ while true; do sh -c "$(cat my_tests"); done

in Macvim:

    :RelatedPipe my_tests

