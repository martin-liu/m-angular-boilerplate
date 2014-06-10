# The directive for more button style pagination
angular.module('m-directive').directive 'mMoreButton', ($parse, $q) ->
  return {
  restrict: 'E'
  scope: {}
  templateUrl: 'partials/directive/pagination.html'
  link: (scope, element, attrs) ->
    scope.data = $parse(attrs.data)(scope.$parent)
    scope.loadFunc = $parse(attrs.loadFunc)(scope.$parent)
    scope.countAllFunc = $parse(attrs.countAllFunc)(scope.$parent)

    scope.countAllFunc().then (data) =>
      scope.allNum = data

    scope.has_more = ->
      scope.data.length < scope.allNum

    scope.loaded = true
    scope.show_more = ->
      scope.loaded = false
      loadPromise = scope.loadFunc(scope.data.length).then ->
        scope.data = $parse(attrs.data)(scope.$parent)
      countPromise = scope.countAllFunc().then (data) =>
        scope.allNum = data
      $q.all([loadPromise, countPromise]).then ->
        scope.loaded = true
  }
