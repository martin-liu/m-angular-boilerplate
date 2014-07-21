'use strict'
App.factory 'NProgressService', ($timeout)->
  start: ->
    if NProgress
      NProgress.start()
  done: ->
    if NProgress
      $timeout ->
        NProgress.done()
      , 1000
