# The directive for fullscreen a element
angular.module('m-directive').directive 'mFullscreen', () ->
  findChild = (el, func)->
    el = angular.element el
    children = el.children()
    e = _.find children, (d)->
      func d
    if e
      return e
    else
      for child in children
        find = findChild child, func
        if find
          return find

  return {
    restrict : 'A'
    scope : {}
    link : (scope, element, attrs) ->
      toggleEl = findChild element, (d)->
        'm-fullscreen' == angular.element(d).attr 'data-toggle'
      if toggleEl
        toggleEl = angular.element toggleEl
        toggleEl.attr 'style', 'cursor:sw-resize'
        toggleEl.bind 'click', ()->
          angular.element(document.body).toggleClass 'fullscreenStatic'
          element.toggleClass 'fullscreen'
        # Prevent memory leak
        scope.$on '$destroy', ->
          toggleEl.unbind 'click'
  }
