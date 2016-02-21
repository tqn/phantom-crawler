Promise = require 'bluebird'

exports = module.exports = class Crawler

  constructor: (@options = {}) ->
    @queue = options.queue ? []

  crawl: ->
    # Array of promises for phantomjs pages
    pages = (fetch @queue.unshift() while @queue.length isnt 0)
    return pages

  # Get a page
  fetch: Promise.coroutine (url) ->
    # create page
    page = yield phantom.createPageAsync()
    # open page
    try
      # page settings
      pageSet = Promise.promisify page.set
      settings = []
      if @options.XSSAuditingEnabled
        settings.push pageSet 'settings.XSSAuditingEnabled', true
      if @options.userAgent?
        settings.push pageSet 'settings.userAgent', @options.userAgent
      yield Promise.all settings
      # open the url
      yield new Promise (resolve, reject) ->
        page.open url, (status) ->
          if status == 'success' then resolve() else reject()
      # Check for timeout
      if (yield page.get 'url') == 'about:blank'
        throw new Error "#{url} timed out"
      # Return page
      return page
    finally page.close()

  # Phantom instance
  phantom: Promise.promisifyAll require('node-phantom-simple').create
    path: require('phantomjs').path
