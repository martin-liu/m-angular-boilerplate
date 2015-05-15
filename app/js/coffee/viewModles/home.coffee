App.factory 'HomeViewModel', ($timeout, $window, $q
, BaseViewModel, Constant, Util) ->

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
      @state.curr = @data.products[0]

      @scope.$watch =>
        @state.curr
      , (newV, oldV)=>
        currId = @state.curr.id
        Util.waitUntil ->
          $("div.slick-active[data-slick-index]")
        , (els)->
          els.length > 0
        .then (els)->
          els.removeClass "product-active"
          els.addClass (i)->
            id = $(@).attr "data-product-id"
            if currId == id
              "product-active"

    ## Override
    bindAction: =>
      slideChange: =>
        @scope.$apply =>
          index = _.indexOf @data.products, @state.curr
          if index == @data.products.length - 1
            index = 0
          else
            index = index + 1
          @state.curr = @data.products[index]

      slidesToShow: =>
        width = $(document).width()
        Math.min Math.floor(width/250), 6
