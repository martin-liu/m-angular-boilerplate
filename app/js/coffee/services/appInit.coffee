App.factory 'AppInitService', ($rootScope, $window, IntroService,
$http, $q, Util, Config, Cache, Constant) ->
  promises = []
  return {
    initUser: ->
      $rootScope.user = angular.fromJson localStorage.getItem 'user'
      if not $rootScope.user and Config.PFSSO.enabled
        $http({
          method: 'GET',
          url: document.location
        }).then (res)->
          nt = res.headers 'PF_AUTH_SUBJECT'
          email = res.headers 'PF_AUTH_EMAIL'
          firstName = res.headers 'PF_AUTH_FIRSTNAME'
          lastName = res.headers 'PF_AUTH_LASTNAME'
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

    init: ->
      $rootScope.$on '$routeChangeSuccess', ($event, current) ->
        $rootScope.currentPage = current.name

      $rootScope.Util = Util

      $rootScope.config = Config

      @initUser()

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
