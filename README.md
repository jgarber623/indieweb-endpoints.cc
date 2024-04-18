# IndieWeb Endpoints

**Discover a URL's IndieAuth, Micropub, Microsub, and Webmention endpoints.**

[![Build](https://img.shields.io/github/actions/workflow/status/jgarber623/indieweb-endpoints.cc/ci.yml?branch=main&logo=github&style=for-the-badge)](https://github.com/jgarber623/indieweb-endpoints.cc/actions/workflows/ci.yml)
[![Deployment](https://img.shields.io/github/deployments/jgarber623/indieweb-endpoints.cc/production?label=Deployment&logo=github&style=for-the-badge)](https://github.com/jgarber623/indieweb-endpoints.cc/deployments/activity_log?environment=production)

## Usage

There are a couple of ways you can use IndieWeb Endpoints:

You may point your browser at [the website](https://indieweb-endpoints.cc), enter a URL into the search form, and submit! You could also hack on the URL itself and throw something like this at your browser's URL bar:

```text
https://indieweb-endpoints.cc/u/https://sixtwothree.org
```

Lastly, if you're comfortable working on the command line, you can query the service directly using a tool like [curl](https://curl.haxx.se):

```sh
curl --header "Accept: application/json" --silent "https://indieweb-endpoints.cc/u/https://sixtwothree.org"
```

…or [Wget](https://www.gnu.org/software/wget/):

```sh
wget --header "Accept: application/json" --quiet -O - "https://indieweb-endpoints.cc/u/https://sixtwothree.org"
```

The above command will return a [JSON](https://json.org) object with the results of the search:

```json
{
  "authorization_endpoint": "https://indieauth.com/auth",
  "micropub": null,
  "microsub": "https://aperture.p3k.io/microsub/219",
  "redirect_uri": [
    "https://sixtwothree.org/auth"
  ],
  "token_endpoint": "https://tokens.indieauth.com/token",
  "webmention": "https://sixtwothree.org/webmentions"
}
```

## Acknowledgments

IndieWeb Endpoints wouldn't exist without the hard work put in by everyone involved in the [IndieWeb](https://indieweb.org) movement.

Text is set using [Alfa Slab One](https://fonts.google.com/specimen/Alfa+Slab+One) and [Gentium Book Basic](https://fonts.google.com/specimen/Gentium+Book+Basic) which are provided by [Google Fonts](https://fonts.google.com). Iconography is from [Font Awesome](https://fontawesome.com)'s icon set.

IndieWeb Endpoints is written and maintained by [Jason Garber](https://sixtwothree.org).

## License

IndieWeb Endpoints is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
