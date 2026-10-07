# Statamic documentation (local copy)

A copy of the official Statamic documentation, kept as plain Markdown files so it can be read and searched offline.

- Source: https://github.com/statamic/docs (the repository behind https://statamic.dev)
- Contents: the `content/` folder of the source repository, unchanged
- Refreshed: weekly, by `update.sh`

This is an unofficial copy and is not affiliated with Statamic.

## Layout

| Folder | What it holds |
|---|---|
| `content/collections/pages/` | Guides: installing, configuring, content modelling, the control panel, extending |
| `content/collections/tags/` | Reference for template tags |
| `content/collections/modifiers/` | Reference for template modifiers |
| `content/collections/variables/` | Reference for template variables |
| `content/collections/fieldtypes/` | Reference for fieldtypes |
| `content/collections/resource_apis/` | Reference for the REST API resources |
| `content/collections/widgets/` | Reference for control panel widgets |
| `content/collections/tips/` | Short how-to articles |
| `content/collections/troubleshooting/` | Fixes for common errors |
| `content/trees/navigation/` | The menu structure of statamic.dev |

Each page is a Markdown file with a YAML front matter block (`id`, `title`, `intro`, `parent`). A page's `parent` holds the `id` of the page above it.

## Updating

Run `./update.sh`. It downloads the current `content/` folder from the source repository, replaces the local copy, and commits and pushes only when something changed. `manifest.json` records the source branch and commit the copy was taken from.

## License

The documentation is copyright Statamic, LLC and is distributed under the terms in `LICENSE.md`, which is copied unchanged from the source repository.
