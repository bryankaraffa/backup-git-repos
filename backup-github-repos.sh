#!/bin/bash
# Backup GitHub Repo Script
# Developed by: Bryan Karaffa
# github.com/bryankaraffa
#

echo -n "Please enter your GitHub username, followed by [ENTER]:  "
read github_username

mkdir github-repo-backup
cd github-repo-backup
git init .

touch README.md
git add README.md
git commit -a -m "git-repo-backup repository created.  Ready to start the backup process."

git rm README.md
git commit -a -m "Emptied repo so no conflicts will arise during backup process"

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
echo "This repository contains backups of github user: $github_username's git repositories.  Each backed up repository is saved in it's own branch.  Git Repo Backup Script Developed by: [Bryan Karaffa](https://github.com/bryankaraffa)" >> README.md
git add README.md

git commit -a -m "Repository backup complete."
