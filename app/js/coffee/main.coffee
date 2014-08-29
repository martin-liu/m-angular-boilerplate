'use strict'
window.App = angular.module 'app', ['ngSanitize', 'ngRoute', 'ngAnimate'
, 'restangular', 'ui.bootstrap', 'headroom'
, 'config', 'm-directive', 'm-service']

angular.module 'm-service', ['m-util']
angular.module 'm-directive', ['m-util']

# Constans
App.constant 'Config', Config
App.constant 'Cache', locache
App.constant '_', _

App.config ($provide, $httpProvider, RestangularProvider) ->
  # Restangular base url
  RestangularProvider.setBaseUrl Config.uri.api

  # Global http error handler
  $httpProvider.interceptors.push ($timeout, $q, $rootScope, $location, Util) ->
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

App.run (AppInitService) ->
  AppInitService.init()
