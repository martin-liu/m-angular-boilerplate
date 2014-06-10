App.factory 'HomeViewModel', ($q, $location, $timeout, Constant
, BaseViewModel, ReportRemoteService, ChartService, Util, Cache) ->

  class HomeViewModel extends BaseViewModel
    ## Override
    bindView : =>

    ## Override
    bindAction: =>
