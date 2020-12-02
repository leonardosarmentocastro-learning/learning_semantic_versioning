readonly local SEMANTIC_VERSION=$(git log -1 --pretty=format:"%s")
echo "SEMANTIC_VERSION: $SEMANTIC_VERSION"

readonly local PR_MERGE_DATE=$(git log -2 --format=%ci | head -n 2 | tail -1)
echo "PR_MERGE_DATE: $PR_MERGE_DATE"

# https://devhints.io/git-log-format
# https://stackoverflow.com/questions/14093452/grep-only-the-first-match-and-stop
readonly local PR_TITLE=$(git log -2 --grep="Merge pull request" --pretty=format:"%b" | head -1)
echo "PR_TITLE: $PR_TITLE"

readonly local PR_AUTHOR=$(git log -2 --pretty=format:"%an" --grep="Merge pull request" | head -1)
echo "PR_AUTHOR: $PR_AUTHOR"

# https://stackoverflow.com/questions/43428293/git-log-pretty-format-grab-just-a-number-from-the-title
readonly local PR_NUMBER=$(git log -2 | grep -o '#[0-9]\+' | grep -o '[0-9]\+')
echo "PR_NUMBER: $PR_NUMBER"

# Add content to the beginning of "CHANGELOG.md" file.
# NOTE: Every special character must be back-slashed (escaped).
echo '' | cat - CHANGELOG.md > temp && mv temp CHANGELOG.md
echo \* $PR_TITLE \(por \"$PR_AUTHOR\" em \[\#$PR_NUMBER\]\(https\:\/\/github.com\/quero\-edu/melhor\_escola/pull\/$PR_NUMBER\)\) | cat - CHANGELOG.md > temp && mv temp CHANGELOG.md
echo '' | cat - CHANGELOG.md > temp && mv temp CHANGELOG.md
echo \#\# $SEMANTIC_VERSION \($PR_MERGE_DATE\) | cat - CHANGELOG.md > temp && mv temp CHANGELOG.md

git add CHANGELOG.md
git commit -m "CHANGELOG.md"
