# The directive for no result style
angular.module('m-directive').directive 'mNoResult', () ->
  return {
    restric : 'E'
    scope : {}
    template : """
               <div class="no-result">
                 {{ text }}
               </div>
               """
    link : (scope, element, attrs) ->
      scope.text = attrs.text
      scope.text ?= 'No Result.'
  }
