'use strict'
App.factory 'SampleRemoteService', (Restangular, Util) ->
  rest = Restangular.all 'ops'
  getCacheKey = (method, param)->
    "SampleRemoteservice_#{method}_#{JSON.stringify param}"
  # Session cache
  getWithCache = (method, param, func)->
    Util.getWithCache getCacheKey(method, param), true, func

  @query = (param) ->
    getWithCache 'query', param, ->
      rest.one('query').get param

  return @
