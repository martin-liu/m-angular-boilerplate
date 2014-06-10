# The directive for load Dynamic Templates
angular.module('m-directive').directive 'mDynamicTpl', (Util, $rootScope) ->
  linker = (scope, element, attrs) ->
    scope.Util = Util
    scope.dict = $rootScope.dict
    Util.compileTemplate(scope.tpl, scope).then (html)->
      element.replaceWith html

  return {
    restrict : 'E'
    scope :
      tpl : '='
      data : '='
      actions : '='
    link : linker
  }
