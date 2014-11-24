App.factory 'BaseViewModel', ($q, $location, PiwikService, $timeout, $rootScope,
AppInitService, Config, LoadingService, IntroService, NProgressService) ->

  class BaseViewModel
    constructor : (@scope)->
      @state = {}
      @data = {}
      @actions = @bindAction()

      # Bind viewModel to view after page init
      AppInitService.done().then =>
        @pageInit().then @bindView
        if Config.debug == true
          window.vm = @
          window.scope = @scope

    initialize : =>
      defer = $q.defer()
      defer.resolve()
      defer.promise

    bindView : =>
    bindAction : =>

    logout : ->
      localStorage.clear()
      $location.url('/logout')

    pageInit : =>
      defer = $q.defer()
      NProgressService.start()
      @initialize().then =>
        NProgressService.done()
        # Intro
        if Config.intro.enabled
          IntroService.init()
        # Piwik
        if Config.piwik.enabled && @scope.user
          PiwikService.init @scope.user.nt, $rootScope.currentPage

        defer.resolve()
      defer.promise
