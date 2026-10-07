#!/bin/bash
# Refresh this copy of the Statamic documentation from github.com/statamic/docs
# and publish any changes. Runs weekly from cron; safe to run by hand.
set -euo pipefail
cd "$(dirname "$0")"

UPSTREAM_URL="https://github.com/statamic/docs.git"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Download only the content folder of the default branch (the one statamic.dev is built from).
git clone --quiet --depth 1 --filter=blob:none --sparse "$UPSTREAM_URL" "$TMP/docs"
git -C "$TMP/docs" sparse-checkout set content
[ -d "$TMP/docs/content" ] || { echo "upstream has no content folder"; exit 1; }

rsync -a --delete "$TMP/docs/content/" content/
git -C "$TMP/docs" show HEAD:LICENSE.md > LICENSE.md

git add -A content LICENSE.md
if git diff --cached --quiet; then
    echo "$(date +%Y-%m-%d) no changes"
else
    cat > manifest.json <<EOF
{
  "source": "https://github.com/statamic/docs",
  "branch": "$(git -C "$TMP/docs" rev-parse --abbrev-ref HEAD)",
  "upstream_commit": "$(git -C "$TMP/docs" rev-parse HEAD)",
  "upstream_commit_date": "$(git -C "$TMP/docs" log -1 --format=%cI)",
  "files": $(find content -type f | wc -l | tr -d ' '),
  "markdown_files": $(find content -type f -name '*.md' | wc -l | tr -d ' ')
}
EOF
    git add manifest.json
    git commit --quiet -m "docs update $(date +%Y-%m-%d)"
    echo "$(date +%Y-%m-%d) updated to upstream $(git -C "$TMP/docs" rev-parse --short HEAD)"
fi

# Also sends a commit left behind by an earlier run whose push failed.
git push --quiet
