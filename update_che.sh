#!/bin/bash

for repo_dir in `find . -name .git | sed 's/\/\.git//'`; do cd $repo_dir; echo === REBASING : $repo_dir ===; git fetch; git rebase; cd -; done
