# The directive for more button style pagination
angular.module('m-directive').directive 'mMoreButton', ($parse, $q) ->
  return {
    restrict: 'E'
    scope:
      currentCount: '=currentCount'
      loadFunc: '=loadFunc'
      allCount: '=allCount'
    transclude: true
    templateUrl: 'partials/directive/moreButton.html'
    link: (scope, element, attrs) ->
      scope.has_more = ->
        scope.currentCount < scope.allCount

      scope.loaded = true
      scope.show_more = ->
        scope.loaded = false
        scope.loadFunc(scope.currentCount).then ->
          scope.loaded = true
  }
