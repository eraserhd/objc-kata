objc-kata
=========

This is a Makefile some boilerplate for doing a kata in Objective-C.

To start a kata:

    git clone --recursive git@github.com:eraserhd/objc-kata.git MyKataName

Another good way is to fork the project on github, then clone the fork. This
makes your local clone's `origin` somewhere to which you can push - useful
if your fingers often push before your brain engages.

Add your kata's files to the root of the cloned repository.  The Makefile uses
some magic shell globbing to pick up the files so that you don't need to add
them anywhere.

[Kiwi] is imported as a submodule (this is why you need `--recursive`) and
linked into the testing bundle automatically.

[Kiwi]: https://github.com/allending/Kiwi
