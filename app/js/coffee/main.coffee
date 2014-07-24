'use strict'
window.App = angular.module 'app', ['m-directive', 'ngSanitize', 'ngRoute'
, 'ngAnimate', 'config', 'restangular', 'ui.bootstrap', 'headroom']

App.config ($provide, $httpProvider, RestangularProvider) ->
  # Restangular base url
  RestangularProvider.setBaseUrl Config.uri.api

  # Global http error handler
  $httpProvider.interceptors.push ($timeout, $q, $rootScope, $location) ->
    request : (config) ->
      return config || $q.when(config)
    responseError : (response) ->
      if !response.status       # reload when no status code
        document.location.reload()
      if response.data && response.data.message
        tplErrorHandler = 'partials/modal/error_handler.html'
        $rootScope.Util.createDialog tplErrorHandler
        , {message: response.data.message}, ->
        $q.reject response
      else
        response

App.run ($rootScope, $window, IntroService, Util, Config) ->

  $rootScope.$on '$routeChangeSuccess', ($event, current) ->
    $rootScope.currentPage = current.name

    # Watch config to persist it in local storage
    $rootScope.$watch =>
      # use angular.toJson to remove internal properties like $$hashKey
      angular.toJson $rootScope.state.config
    , (newVal, oldVal) =>
      key = 'OpsViewmodel_Config'
      if newVal == oldVal     # initial
        _.extend @state.config, Cache.get key
        @initConfig()
      else
        Cache.set key, JSON.parse newVal
    , true                    # equal

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

App.constant 'Config', Config
App.constant 'Cache', locache
App.constant '_', _
