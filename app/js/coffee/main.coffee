'use strict'
window.App = angular.module 'app', ['m-directive', 'ngSanitize', 'ngRoute'
, 'config', 'restangular', 'ui.bootstrap', 'headroom']

App.config ($provide, $httpProvider, RestangularProvider) ->
  # Restangular base url
  RestangularProvider.setBaseUrl Config.uri.api

  # Global http error handler
  $httpProvider.interceptors.push ($timeout, $q, $rootScope, $location) ->
    request : (config) ->
      return config || $q.when(config)
    responseError : (response) ->
      if response.data && response.data.message
        tplErrorHandler = 'partials/modal/error_handler.html'
        $rootScope.Util.createDialog tplErrorHandler
        , {message: response.data.message}, ->
        $q.reject response
      else
        response

App.run ($rootScope, $window, LoadingService, Util) ->

  $rootScope.$on '$routeChangeSuccess', ($event, current) ->
    $rootScope.currentPage = current.name

  promise = LoadingService.init()
  $rootScope.init = -> promise

  $rootScope.window = $window

  $rootScope.Util = Util

  $rootScope.user = angular.fromJson localStorage.getItem 'user'

  $rootScope.dict = {
    get : (key) ->
      ret = Constant.dict[key]
      ret ?= key
      ret
  }

  sessionStorage.clear()

App.constant 'Config', Config
App.constant 'Cache', locache
App.constant '_', _
