App.factory 'HomeViewModel', ($q, $location, $timeout, Constant
, BaseViewModel, Util, Cache) ->

  class HomeViewModel extends BaseViewModel
    ## Override
    bindView : =>
      @data.announcements = [
        {
          date: "2014-01-01"
          msg: "this is a test"
        }
      ]

    ## Override
    bindAction: =>
