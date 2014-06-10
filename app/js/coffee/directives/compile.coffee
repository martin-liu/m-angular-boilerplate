# The directive for loading style
angular.module('m-directive').directive 'mCompile', ($compile) ->
  return {
  restrict : 'A'
  link : (scope, element, attrs) ->
    scope.$watch ->
      scope.$eval attrs.mCompile
    , (value)->
      element.html value

      $compile(element.contents())(scope)
  }
