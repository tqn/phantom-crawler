expect = require('chai').expect
Promise = require 'bluebird'

Crawler = require '../'

URL = 'https://www.google.com/'

describe 'the crawler', ->
  @timeout 30000
  @slow 2000

  it 'should crawl', ->
    crawler = new Crawler queue: [URL]
    return Promise.all crawler.crawl()
    .then ([page]) ->
      # Close the page
      title = page.getPromise 'title'
      title.then -> page.close()
      return title
    .then (title) -> expect(title).to.equal 'Google'
    .then -> crawler.phantom.then (phantom) -> phantom.exit()

  it 'should fetch', ->
    crawler = new Crawler()
    return crawler.fetch URL
    .then (page) ->
      page.close()
      crawler.phantom.then (phantom) -> phantom.exit()
