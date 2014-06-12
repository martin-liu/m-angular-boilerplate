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
    restric : 'A'
    scope : {}
    link : (scope, element, attrs) ->
      toggleEl = findChild element, (d)->
        'm-fullscreen' == angular.element(d).attr 'data-toggle'
      angular.element(toggleEl).bind 'click', ()->
        angular.element(document.body).toggleClass 'fullscreenStatic'
        element.toggleClass 'fullscreen'
  }
