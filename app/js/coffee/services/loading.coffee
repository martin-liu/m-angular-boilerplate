'use strict'
App.factory 'LoadingService', ($rootScope, $q, $timeout, Util)->
  return {
  init : () ->
    # Initial loading bar
    loadingDefer = $q.defer()
    $rootScope.$watch (-> $rootScope.loading), ->
      if $rootScope.loading?
        if $rootScope.loading == 'loaded'
          if $rootScope.loadDialog?
            $rootScope.initializing = 100
            $timeout ->
              $rootScope.loadDialog.close()
            , 1000
          $rootScope.initiated = true
          loadingDefer.resolve()
      else
        $rootScope.initializing = 10
        $rootScope.loadDialog =
          Util.createDialog 'partials/modal/loading.html'
          , null, angular.noop, {backdrop : 'static'}
    loadingDefer.promise

  done : ->
    $rootScope.loading = 'loaded'
  }
