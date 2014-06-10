App.factory 'HomeViewModel', ($q, $location, $timeout, Constant
, BaseViewModel, Util, Cache) ->

  class HomeViewModel extends BaseViewModel
    ## Override
    bindView : =>

    ## Override
    bindAction: =>
