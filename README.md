# git-backup-script
#### Developed by: [Bryan Karaffa](https://github.com/bryankaraffa)

This script will backup all the public repositories for a github user into a single git repository.  Each backed up repository will be included in it's own branch.

# Usage:
To use the script, simple clone this repo and run `backup-github-repos.sh`:

```bash
$ git clone https://github.com/bryankaraffa/backup-git-repos.git
Cloning into 'backup-git-repos'...
remote: Counting objects: 15, done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 15 (delta 4), reused 14 (delta 3), pack-reused 0
Unpacking objects: 100% (15/15), done.
Checking connectivity... done.

$ cd backup-git-repos/

$ ./backup-github-repos.sh
Please enter your GitHub username, followed by [ENTER]:  bryankaraffa
```

The resulting backups are stored in the `./github-repo-backup/` relative to the working directory the script was executed from.
