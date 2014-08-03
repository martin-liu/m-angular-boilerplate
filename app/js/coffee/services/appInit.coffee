App.factory 'AppInitService', ($rootScope, $window, IntroService,
$q, Util, Config, Cache) ->
  promises = []
  return {
    init: ->
      $rootScope.$on '$routeChangeSuccess', ($event, current) ->
        $rootScope.currentPage = current.name

      $rootScope.Util = Util

      $rootScope.config = Config

      $rootScope.user = angular.fromJson localStorage.getItem 'user'

      $rootScope.dict = {
        get : (key) ->
          ret = Constant.dict[key]
          ret ?= key
          ret
      }

      $rootScope.startIntro = ->
        IntroService.start()

      $rootScope.persistence = {}
      persistenceDefer = $q.defer()
      promises.push persistenceDefer
      # Watch to persist object in local storage
      $rootScope.$watch =>
        # use angular.toJson to remove internal properties like $$hashKey
        angular.toJson $rootScope.persistence
      , (newVal, oldVal) =>
        key = 'persistent_object'
        if newVal == oldVal     # initial
          _.extend $rootScope.persistence, Cache.get key
          persistenceDefer.resolve()
        else
          Cache.set key, JSON.parse newVal
      , true                    # equal

    add: (promise)->
      promises.push promise

    done: ->
      $q.all promises
  }
