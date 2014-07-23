# The directive for announcement
angular.module('m-directive').directive 'mAnnouncement', ($position) ->
  restrict : 'AE'
  scope:
    announcements: '='
  template : """
              <span ng-show="show">
              <i class="fa fa-bullhorn animated infinite"
                 ng-class="{flash:flash}"></i>
              <div class="popover right fade in"
                style="transform:translateY(-40%)">
                <div class="arrow" style="top:90%"></div>
                <div class="popover-inner">
                <h3 class="popover-title" ng-bind="title" ng-show="title"></h3>
                <div class="popover-content">
                  <alert ng-repeat="a in announcements"
                    type="{{a.type || 'success'}}">
                    <p>
                      <span class="label label-primary"
                        style="margin-right:5px">
                        {{a.date | date:'yyyy-MM-dd'}}
                      </span>
                      {{a.msg}}
                    </p>
                  </alert>
                </div>
                </div>
              </div>
              </span>
           """
  controller: ($scope) ->
    cacheKey = 'viewed_annoucement_date'
    $scope.$watch 'announcements', (newVal, oldVal)->
      if newVal && newVal.length
        $scope.show = true
        first = newVal[0]
        if new Date(first.date) > new Date(localStorage.getItem cacheKey)
          $scope.flash = true
        localStorage.setItem cacheKey, first.date
    , true

    $scope.stopFlash = ->
      $scope.flash = false

  link : (scope, element, attrs) ->
    icon = element.find 'i'
    list = element.find 'div'
    if list.length
      list = angular.element list[0]

    scope.title = attrs.title || 'Announcements'

    element.bind 'mouseenter', ->
      scope.$apply scope.stopFlash

      list.css 'display', 'block'
      ttPosition = $position.positionElements icon, list
      , attrs.placement || 'right'
      ttPosition.top += 'px'
      ttPosition.left += 'px'
      list.css ttPosition
    element.bind 'mouseleave', ->
      list.css 'display', 'none'

    scope.$on '$destroy', ->
      element.unbind 'mouseenter'
      element.unbind 'mouseleave'
