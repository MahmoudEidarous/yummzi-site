#!/bin/sh
# Publishes the Yummzi support and privacy pages to GitHub Pages:
#   https://mahmoudeidarous.github.io/yummzi-site/
# Run once:  sh ~/Documents/ChatGPT/yummzi-site/publish.sh
set -e
cd "$(dirname "$0")"
[ -f .nojekyll ] || touch .nojekyll
if [ ! -d .git ]; then
  git init -q -b main
  git add -A
  git commit -q -m "Yummzi home, support and privacy pages"
  gh repo create MahmoudEidarous/yummzi-site --public --source . --push \
    --description "Support and privacy pages for the Yummzi iPhone app"
  gh api -X POST repos/MahmoudEidarous/yummzi-site/pages -f "source[branch]=main" -f "source[path]=/" >/dev/null
else
  git add -A && git commit -q -m "Update pages" || true
  git push -q
fi
echo "Published. Live in about a minute at https://mahmoudeidarous.github.io/yummzi-site/"
