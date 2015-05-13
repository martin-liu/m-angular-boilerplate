App.factory 'HomeViewModel', ($window, $q, BaseViewModel, Constant, Util) ->

  class HomeViewModel extends BaseViewModel
    ## Override
    initialize: =>
      Util.waitUntil ->
        dssui = $window.dssui
        if dssui && dssui.globalheader && dssui.globalheader._config
          dssui.globalheader._config
      , (config) ->
        !!config
      .then (config)=>
        @data.products = config.menus

    ## Override
    bindView : =>

    ## Override
    bindAction: =>
