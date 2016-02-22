Promise = require 'bluebird'

module.exports = class Crawler

  constructor: (@options = {}) ->
    @queue = @options.queue ? []
    # Promise for phantom bridge
    @phantom = Promise.promisify(require('node-phantom-simple').create)
      path: require('phantomjs').path
    .then Promise.promisifyAll

  # Array of promises for phantomjs pages
  crawl: -> @fetch @queue.shift() while @queue.length isnt 0

  # Get a page
  fetch: Promise.coroutine (url) ->
    phantom = yield @phantom
    # create page
    page = Promise.promisifyAll (yield phantom.createPageAsync()),
      suffix: 'Promise'
    # page settings
    settings = []
    if @options.XSSAuditingEnabled
      settings.push page.setPromise 'settings.XSSAuditingEnabled', true
    if @options.userAgent?
      settings.push page.setPromise 'settings.userAgent', @options.userAgent
    yield Promise.all settings
    # open the url
    if (yield page.openPromise url) isnt 'success'
      throw new Error "#{url} failed to open"
    # Check for timeout
    if (yield page.getPromise 'url') is 'about:blank'
      throw new Error "#{url} timed out"
    # Return page
    return page
