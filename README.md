# phantom-crawler

[![GitHub release](https://img.shields.io/github/release/tqn/phantom-crawler.svg?style=flat-square)](https://github.com/tqn/phantom-crawler/releases/latest)
[![Travis](https://img.shields.io/travis/tqn/phantom-crawler.svg?style=flat-square&branch=master)](https://travis-ci.org/tqn/phantom-crawler)
[![David](https://img.shields.io/david/tqn/phantom-crawler.svg?style=flat-square)](https://david-dm.org/tqn/phantom-crawler#info=dependencies)
[![David](https://img.shields.io/david/dev/tqn/phantom-crawler.svg?style=flat-square)](https://david-dm.org/tqn/phantom-crawler#info=devDependencies)

## examples
(Check unit tests for more details)

### coffeescript
```coffeescript
Crawler = require('phantom-crawler')
# Can be initialized with optional options object
crawler = new Crawler()
# queue is an array of URLs to be crawled
crawler.queue.push 'http://google.com/', 'http://npmjs.com/'
# Can also do `crawler.fetch url` instead of pushing it and crawling it
# Extract plainText out of each phantomjs page
Promise.all crawler.crawl()
.then (pages) ->
  texts = []
  for page in pages
    text = page.getPromise 'plainText'
    text.then do (page) -> -> page.close()
    texts.push text
  return Promise.all texts
.then (texts) ->
  # texts = array of plaintext from the website bodies
  # also supports ajax requests
  console.log texts
# kill that phantomjs bridge
.then -> crawler.phantom.then (p) -> p.exit()
```

### significantly uglier javascript
```javascript
var Crawler = require('phantom-crawler');

// Can be initialized with optional options object
var crawler = new Crawler();
// queue is an array of URLs to be crawled
crawler.queue.push('http://google.com/', 'http://npmjs.com/');
// Can also do `crawler.fetch(url)` instead of pushing it and crawling it
// Extract plainText out of each phantomjs page
Promise.all(crawler.crawl())
.then(function(pages) {
  var texts = [];
  for (var i = 0; i < pages.length; i++) {
    var page = pages[i];
    // suffix Promise to return promises instead of callbacks
    var text = page.getPromise('plainText');
    texts.push(text);
    text.then(function(p) {
      return function() {
        // Pages are like tabs, they should be closed
        p.close()
      }
    }(page));
  }
  return Promise.all(texts);
})
.then(function(texts) {
  // texts = array of plaintext from the website bodies
  // also supports ajax requests
  console.log(texts);
})
.then(function () {
  // kill that phantomjs bridge
  crawler.phantom.then(function (p) {
    p.exit();
  });
})
```

### long example output
```javascript
[ 'Google+\nSearch\nImages\nMaps\nPlay\nYouTube\nNews\nGmail\nMore\nSign in\n×\n\tA better way to browse the web\nGet Google Chrome\n\n\n\n \t\n\n\nAdvanced search\nLanguage tools\n\nExplore the history of Civil Rights with Google \n\n\nAdvertising ProgramsBusiness Solutions+GoogleAbout Google\n© 2016 - Privacy - Terms\n\n',
  '\nsign up or log in\n \nnpm is the package manager for\nnode.js\npackages people \'npm install\' a lot\n\n\nbrowserify\nbrowser-side require() the node way\n13.0.0 published a month ago by feross\n\ngrunt-cli\nThe grunt command line interface.\n0.1.13 published 2 years ago by tkellen\n\nbower\nThe browser package manager\n1.7.7 published 4 weeks ago by sheerun\n\ngulp\nThe streaming build system\n3.9.0 published 9 months ago by phated\n\ngrunt\nThe JavaScript Task Runner\n0.4.5 published 2 years ago by cowboy\n\nexpress\nFast, unopinionated, minimalist web framework\n4.13.4 published a month ago by dougwilson\n\nnpm\na package manager for JavaScript\n3.7.1 published 3 weeks ago by iarna\n\ncordova\nCordova command line interface tool\n6.0.0 published 4 weeks ago by stevegill\n\nforever\nA simple CLI tool for ensuring that a given node script runs continuously (i.e. forever)\n0.15.1 published 7 months ago by indexzero\n\nless\nLeaner CSS\n2.6.0 published 3 weeks ago by matthew-dean\n\npm2\nProduction process manager for Node.JS applications with a built-in load balancer.\n1.0.0 published 2 months ago by tknew\n\nkarma\nSpectacular Test Runner for JavaScript.\n0.13.19 published 2 months ago by dignifiedquire\n\ncoffee-script\nUnfancy JavaScript\n1.10.0 published 6 months ago by jashkenas\n\nstatsd\nA simple, lightweight network daemon to collect metrics over UDP\n0.7.2 published a year ago by pkhzzrd\n\nyo\nCLI tool for running Yeoman generators\n1.6.0 published a month ago by sboudrias\ngetting started\n\ninstalling npm\nThe npm command-line tool is bundled with Node.js. If you have it installed, then you already have npm too. If not, go download Node.js.\n\nscreencasts and docs\nWe\'ve got a new docs site featuring videos and tutorials to help you make your javascript dreams come true. Head on over to docs.npmjs.com\n\nget a job\nmicroapps, Voxer, Reserve and lots of other companies are hiring javascript developers. View all 34…\nrecently updated packages\n\nquick-pomelo\nScalable, Transactional and Reliable Game Server Framework based on Pomelo and MemDB\n0.2.3 published 5 months ago by rain1017\niobroker.yamaha\nioBroker yamaha Adapter\n0.1.1 published a minute ago by soef\ngulp-concat\nConcatenates files\n2.6.0 published 8 months ago by fractal\nwebkitgtk\nDrive webkitgtk from Node.js\n3.6.0 published a minute ago by kapouer\ncheckdeps\nCheck dependencies of a Node.js project against package.json\n0.1.9 published a minute ago by adamkdean\njs-templates.function-export\nGenerate a sample function export code.\n1.0.1 published a minute ago by ionicabizau\ncocos-cli\ncocos cli\n0.1.3 published a minute ago by heysdk\nthot\nlog management for node and express\n0.2.1 published 2 minutes ago by guduf\ngulp-uglify\nMinify files with UglifyJS.\n1.5.2 published 2 weeks ago by terinjokes\njusto-generator-justo\nGenerator for a Justo.js project.\n0.1.0 published 3 minutes ago by justojs\nmarked-plus-renderer\nmarked with a few more features\n0.0.20160222 published 3 minutes ago by leungwensen\nreact-styleguidist\nReact components styleguide generator\n2.0.0 published 4 minutes ago by sapegin\nmost depended-upon packages\n\nlodash\nLodash modular utilities.\n4.5.1 published 3 hours ago by jdalton\nasync\nHigher-order functions and common patterns for asynchronous code\n1.5.2 published a month ago by aearly\nrequest\nSimplified HTTP request client.\n2.69.0 published 4 weeks ago by mikeal\nunderscore\nJavaScript\'s functional programming helper library.\n1.8.3 published 11 months ago by jashkenas\nexpress\nFast, unopinionated, minimalist web framework\n4.13.4 published a month ago by dougwilson\ncommander\nthe complete solution for node.js command-line programs\n2.9.0 published 4 months ago by zhiyelee\ndebug\nsmall debugging utility\n2.2.0 published 9 months ago by tootallnate\nchalk\nTerminal string styling done right. Much color.\n1.1.1 published 6 months ago by sindresorhus\nbluebird\nFull featured Promises/A+ implementation with exceptionally good performance\n3.3.1 published a week ago by esailija\nq\nA library for promises (CommonJS/Promises/A,B,D)\n1.4.1 published 9 months ago by kriskowal\nmkdirp\nRecursively mkdir, like `mkdir -p`\n0.5.1 published 9 months ago by substack\ncolors\nget colors in your node.js console\n1.1.2 published 8 months ago by marak\nYou Need Help\nDocumentation\nSupport / Contact Us\nRegistry Status\nWebsite Issues\nCLI Issues\nSecurity\nAbout npm\nAbout npm, Inc\nJobs\nnpm Weekly\nBlog\nTwitter\nGitHub\nLegal Stuff\nTerms of Use\nCode of Conduct\nPackage Name Disputes\nPrivacy Policy\nReporting Abuse\nOther policies\nnpm loves you' ]
```
huh, syntax highlighting gave up halfway through
