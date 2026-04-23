---
name: Laravel Forge
description: Trigger a Laravel Forge deployment from Woodpecker CI
author: Njazi Shehu
tags: [deploy, laravel, forge]
containerImage: njaaazi/laravel-forge-woodpecker
url: https://github.com/njaaazi/laravel-forge-woodpecker
---

# Overview

Woodpecker CI plugin that triggers a [Laravel Forge](https://forge.laravel.com) deployment.

Heavily based on [`jbrooksuk/laravel-forge-action`](https://github.com/jbrooksuk/laravel-forge-action).

## Settings

| Settings Name | Default | Description |
| ------------- | ------- | ----------- |
| `trigger_url` | _none_  | Forge deployment trigger URL. Found in your site's detail panel in Forge. |
| `api_key`     | _none_  | Forge API key. Generate one at https://forge.laravel.com/user-profile/api. Requires `server_id` and `site_id`. |
| `server_id`   | _none_  | Forge server ID. Found in the server's detail panel. |
| `site_id`     | _none_  | Forge site ID. Found in the site's detail panel. |
| `query`       | _none_  | Optional. Extra query string appended to `trigger_url` (e.g. `tag=v1.0.0`). Do not include a leading `?`. |

If both `trigger_url` and `api_key` are set, `trigger_url` takes precedence. It is highly recommended to store all settings using [Woodpecker secrets](https://woodpecker-ci.org/docs/usage/secrets).

## Examples

### Trigger URL mode

```yaml
steps:
  deploy:
    image: njaaazi/laravel-forge-woodpecker:latest
    settings:
      trigger_url:
        from_secret: forge_trigger_url
    when:
      - branch: main
        event: push
```

Pass extra query params (e.g. a tag) via `query`:

```yaml
steps:
  deploy:
    image: njaaazi/laravel-forge-woodpecker:latest
    settings:
      trigger_url:
        from_secret: forge_trigger_url
      query: "tag=${CI_COMMIT_TAG}"
    when:
      - event: tag
```

### API mode

```yaml
steps:
  deploy:
    image: njaaazi/laravel-forge-woodpecker:latest
    settings:
      api_key:
        from_secret: forge_api_key
      server_id:
        from_secret: forge_server_id
      site_id:
        from_secret: forge_site_id
    when:
      - branch: main
        event: push
```
