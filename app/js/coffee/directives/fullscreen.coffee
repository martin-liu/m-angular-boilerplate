# The directive for fullscreen a element
angular.module('m-directive').directive 'mFullscreen', () ->
  return {
    restric : 'A'
    scope : {}
    link : (scope, element, attrs) ->
      toggleEl = element.find '[data-toggle=m-fullscreen]'
      toggleEl.bind 'click', ()->
        angular.element(document.body).toggleClass 'fullscreenStatic'
        element.toggleClass 'fullscreen'
  }
