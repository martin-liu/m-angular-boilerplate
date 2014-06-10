# The directive for loading style
angular.module('m-directive').directive 'mLoading', () ->
  return {
    restrict : 'E'
    scope : {}
    template : """
               <div class="loading">
               <i class="fa fa-spinner fa-spin pull-left">
               </i>
               <h4>{{ text }}</h4>
               </div>
               """
    link : (scope, element, attrs) ->
      scope.text = attrs.text
      scope.text ?= 'Loading...'
  }
