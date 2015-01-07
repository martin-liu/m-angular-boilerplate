App.factory 'HomeViewModel', (BaseViewModel, SampleRemoteService) ->

  class HomeViewModel extends BaseViewModel
    ## Override
    bindView : =>
      @data.announcements = [
        {
          date: "2014-01-01"
          msg: "this is a test"
        }
      ]
      SampleRemoteService.query("test").then (data)->
        console.log "success with data: ", data
      , (err)->
        console.log "fail with err: ", err

    ## Override
    bindAction: =>
