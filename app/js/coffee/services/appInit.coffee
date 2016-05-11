App.factory 'AppInitService', ($rootScope, $window, IntroService,
$http, $q, Util, Config, Cache, Constant) ->
  promises = []
  return {
    initUser: ->
      $rootScope.user = angular.fromJson localStorage.getItem 'user'
      defer = $q.defer()
      if not $rootScope.user and Config.PFSSO and Config.PFSSO.enabled
        $http({
          method: 'GET',
          url: document.location
        }).then (res)->
          nt = res.headers 'PF_AUTH_SUBJECT'
          email = res.headers 'PF_AUTH_EMAIL'
          firstName = res.headers 'PF_AUTH_FIRST'
          lastName = res.headers 'PF_AUTH_LAST'
          displayName = lastName + ', ' + firstName

          if nt
            user =
              nt : nt
              firstName : firstName
              lastName : lastName
              email : email
              displayName : displayName
              label : displayName + '(' + nt + ')'
            $rootScope.user = user
            localStorage.setItem 'user', JSON.stringify(user)
          defer.resolve()
      else
        defer.resolve()

      defer.promise

    setupPersistence: (obj, cache)->
      defer = $q.defer()
      promises.push defer
      # Wach to persist object in local/session storage
      $rootScope.$watch =>
        # use angular.toJson to remove internal properties like $$hashKey
        angular.toJson obj
      , (newVal, oldVal) =>
        key = 'persistent_object'
        if newVal == oldVal     # initial
          _.extend obj, cache.get key
          defer.resolve()
        else
          cache.set key, JSON.parse newVal
      , true                    # equal

    init: ->
      $rootScope.$on '$routeChangeSuccess', ($event, current) ->
        $rootScope.currentPage = current.name

      $rootScope.Util = Util

      $rootScope.config = Config

      @add @initUser()

      $rootScope.dict = {
        get : (key) ->
          ret = Constant.dict[key]
          ret ?= key
          ret
      }

      $rootScope.startIntro = ->
        IntroService.start()

      $rootScope.persistence = {}
      $rootScope.session = {}
      @setupPersistence $rootScope.persistence, Cache
      @setupPersistence $rootScope.session, Cache.session

    add: (promise)->
      promises.push promise

    done: ->
      $q.all promises
  }
