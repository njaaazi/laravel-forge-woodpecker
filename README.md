# Laravel Forge Woodpecker Plugin

Woodpecker CI plugin that triggers a [Laravel Forge](https://forge.laravel.com) deployment. 

## Usage

### Credit
Heavily based on [`jbrooksuk/laravel-forge-action`](https://github.com/jbrooksuk/laravel-forge-action) ❤️

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

## Inputs
It is highly recommended to store all inputs using [Woodpecker Secrets](https://woodpecker-ci.org/docs/usage/secrets).

| Input         | Description                                                                                                                                                                                                             |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `trigger_url` | When using the trigger url to deploy your application, this field is required. You can find this within your site's detail panel in Forge.                                                                              |
| `api_key`     | If you want to use the API to deploy your application, you must provide `api_key`, `server_id` and `site_id`.<br><br>You can generate an API key in your [Forge dashboard](https://forge.laravel.com/user-profile/api). |
| `server_id`   | You can find the ID of the server in the server's detail panel.                                                                                                                                                         |
| `site_id`     | You can find the ID of the site in the site's detail panel.                                                                                                                                                             |
| `query`       | Optional. Extra query string appended to the `trigger_url` (e.g. `tag=v1.0.0&env=prod`). Do not include a leading `?`.                                                                                                  |

If both `trigger_url` and `api_key` are set, `trigger_url` takes precedence.

## License

MIT.
