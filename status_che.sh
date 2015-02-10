#!/bin/bash

for repo_dir in `find . -name .git | sed 's/\/\.git//'`; do
	cd $repo_dir
	echo "git status for $repo_dir"
	git status 2>/dev/null | grep -v "On branch" | grep -v "Your branch is up-to-date with" | grep -v "nothing to commit, working directory clean" | grep -v assembly-che
	cd - 1>/dev/null
done

