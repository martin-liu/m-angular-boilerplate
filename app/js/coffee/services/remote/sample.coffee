'use strict'
App.factory 'SampleRemoteService', (Config, Restangular, Util) ->
  rest = Restangular.all 'ops'
  getCacheKey = (method, param)->
    "#{Config.name}_SampleRemoteservice_#{method}_#{JSON.stringify param}"
  # Session cache
  getWithCache = (method, param, func, timeout)->
    Util.getWithCache getCacheKey(method, param), true, func, timeout

  @query = (param) ->
    getWithCache 'query', param, ->
      rest.one('query').get param

  return @
