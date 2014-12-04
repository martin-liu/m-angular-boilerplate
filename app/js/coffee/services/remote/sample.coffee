'use strict'
App.factory 'SampleRemoteService', (Config, Restangular, Util) ->
  rest = Restangular.all 'ops'
  getCacheKey = (method, param)->
    "#{Config.name}_SampleRemoteservice_#{method}_#{JSON.stringify param}"
  # Session cache
  getWithCache = (method, param, func, timeout)->
    Util.getWithCache getCacheKey(method, param), true, func, timeout

  @query = (param, canceler) ->
    getWithCache 'query', param, ->
      if canceler && canceler.promise
        rest.one('query').withHttpConfig({timeout: canceler.promise}).get param
      else
        rest.one('query').get param

  return @
