# The directive for process scroll
angular.module('m-directive').directive 'mScroll',  ->
  restrict : 'A'
  link : (scope, el, attrs) ->
    scrollFunc = attrs.scroll
    scrollBottomFunc = attrs.scrollBottom
    raw = el[0]
    if scrollFunc || scrollBottomFunc
      el.bind 'scroll', _.debounce ->
        if scrollFunc
          scope.$apply scrollFunc
        if scrollBottomFunc
          if raw.scrollTop + raw.offsetHeight + 5 >= raw.scrollHeight
            scope.$apply scrollBottomFunc
      , 200
      scope.$on 'destroy', ->
        el.unbind 'scroll'
