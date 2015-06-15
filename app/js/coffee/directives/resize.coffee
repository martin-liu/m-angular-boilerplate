# Reset height for element
angular.module('m-directive').directive 'mResize', ($window) ->
  return {
    restrict : 'A'
    scope : {}
    link : (scope, element, attrs) ->
      w = $window
      h = w.innerHeight
      rate = attrs.mResize
      isFixed = attrs.mResizeFixed
      min = attrs.mResizeMin

      if !rate
        rate = 100
      r = rate / 100

      height = Math.max(h * r, min)
      if isFixed == 'true'
        element.css 'height', height
        element.css 'overflow-y', 'auto'
        element.css 'overflow-x', 'hidden'
      else
        element.css 'min-height', height
  }
