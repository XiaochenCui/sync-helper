upstream_url=$(git config --get remote.upstream.url)
core_url=$(echo $upstream_url | sed "s/git@\(.*\)\.git/\1/g" | sed "s|:|/|g")
branch=$(git rev-parse --abbrev-ref HEAD)
url="https://${core_url}/compare/dev...XiaochenCui:${branch}?expand=1"
echo $url
open $url