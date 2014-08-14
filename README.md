# hubot-color

A Hubot script that convert the color code to rgb, hsl, and hex format.

## Installation

    $ npm install git://github.com/bouzuya/hubot-color.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-color.git#TAG'

## Sample Interaction

    bouzuya> hubot help color
    hubot> hubot color - convert the color code to rgb, hsl, and hex format

    bouzuya> hubot color green
    hubot> color green is rgb(0, 128, 0), hsl(120, 100%, 25%), #008000.
    bouzuya> hubot color #4e6a41
    hubot> color #4e6a41 is rgb(78, 106, 65), hsl(101, 24%, 34%), #4e6a41.
    bouzuya> hubot color rgb(78, 106, 65)
    hubot> color rgb(78, 106, 65) is rgb(78, 106, 65), hsl(101, 24%, 34%), #4e6a41.

See [`src/scripts/color.coffee`](src/scripts/color.coffee) for full documentation.

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/hubot-color
[travis-badge]: https://travis-ci.org/bouzuya/hubot-color.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-color
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-color.png
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
