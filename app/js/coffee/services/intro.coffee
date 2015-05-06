'use strict'
App.factory 'IntroService', (Config, Cache, $timeout)->
  intro = null
  cacheKey = "#{Config.name}_IntroService_init"
  initIntro = ->
    if introJs?
      steps = Config.intros

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

      # refresh after change to prevent position:fixed issue
      # position:fixed may cause calculation of position not correct
      # FIXME: this seems not work in Firefox
      intro.onafterchange (targetElement) ->
        intro.refresh()

  init: () ->
    # Initial introducing
    initIntro()
    isInit = Cache.get cacheKey
    if not isInit
      start = @start
      $timeout ->
        if start()
          Cache.set cacheKey, true
      , 1500

  start: ->
    if intro
      intro.start()
      true
    else false
