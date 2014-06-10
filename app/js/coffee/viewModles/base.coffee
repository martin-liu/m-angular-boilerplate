App.factory 'BaseViewModel', ($q, $location, PiwikService
, LoadingService) ->

  class BaseViewModel
    constructor : (@scope)->
      @state = {}
      @data = {}
      @actions = @bindAction()

      # Bind viewModel to view after page init
      @pageInit().then @bindView

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
      @initialize().then =>
        LoadingService.done()
        @scope.init().then =>
          # Piwik
          # PiwikService.init @scope.user.nt

          @scope.initializing = 100
          defer.resolve()
      defer.promise
