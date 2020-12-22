LATEST_CHANGES=$(sed -f -n '1p;1,/^##/!d;/##/d' ./CHANGELOG.md)
echo $LATEST_CHANGES

FORMATTED_LATEST_CHANGES=$(echo $LATEST_CHANGES | xargs | paste -sd "\\\n" -)
echo $FORMATTED_LATEST_CHANGES
