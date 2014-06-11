# The directive for no result style
angular.module('m-directive').directive 'mResize', ($window) ->
  return {
    restric : 'A'
    scope : {}
    link : (scope, element, attrs) ->
      w = $window
      h = w.innerHeight
      rate = attrs.mResize
      isFixed = attrs.mResizeFixed

      if !rate
        rate = 100
      r = rate / 100

      if isFixed == 'true'
        element.css 'height', h * r
        element.css 'overflow-y', 'auto'
        element.css 'overflow-x', 'hidden'
      else
        element.css 'min-height', h * r
  }
