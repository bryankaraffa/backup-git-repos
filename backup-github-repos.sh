#!/bin/bash
# Backup GitHub Repo Script
# Developed by: Bryan Karaffa
# github.com/bryankaraffa
#

$github_username=${github_username:='bryankaraffa'}

mkdir github-repo-backup
cd github-repo-backup
git init .

touch README.md
git add README.md
git commit -a -m "Initial commit"

git rm README.md
git commit -a -m "Clean repo so no conflicts will arise during backup"

echo "git-repo-backup repository created.  Ready to start the backup process."
echo "Downloading jq which will is used to parse JSON from the GitHub API"
curl -L http://stedolan.github.io/jq/download/osx32/jq > jq
chmod +x jq

curl -sL https://api.github.com/users/$github_username/repos | ./jq ".[].name" | sed 's/"//g' >> .github-backup.repoNames
while read r; do
  git checkout -b $r
  git remote add -f $r "https://github.com/$github_username/$r.git"
  git merge "$r/master"
  git commit -a -m "Repo backed up from master branch"
  git checkout master
done < .github-backup.repoNames
rm .github-backup.repoNames jq

touch README.md
echo "This repository contains backups of a user's git repositories.  Each repository is saved in it's own branch.  Git Repo Backup Script Developed by: [Bryan Karaffa](https://github.com/bryankaraffa)" >> README.md
git add README.md

git commit -a -m "Repository backed up"
