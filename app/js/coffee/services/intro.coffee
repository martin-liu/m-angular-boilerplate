'use strict'
App.factory 'IntroService', (Config, Cache, $timeout)->
  intro = null
  initIntro = ->
    if introJs?
      steps = Config.intro

      els = document.querySelectorAll('.intro-step')
      steps = _.map steps, (step, i)->
        findEl = _.find els, (e)->
          e = angular.element e
          num = e.attr 'intro-step'
          i == parseInt num - 1
        if findEl
          step.element = findEl
        return step

      intro = introJs()
      intro.setOptions {
        steps: steps
      }

  init: () ->
    # Initial introducing
    isInit = Cache.get 'IntroService_init'
    if not isInit
      initIntro()
      start = @start
      $timeout ->
        if start()
          if not Config.debug
            Cache.set 'IntroService_init', true
      , 1500

  start: ->
    if intro
      intro.start()
      true
    else false
