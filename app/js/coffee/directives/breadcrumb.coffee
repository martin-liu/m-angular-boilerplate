# The directive for loading style
angular.module('m-directive').directive 'mBreadcrumb',  ->
  restrict : 'AE'
  scope: {}
  controller: ($scope, breadcrumbs)->
    $scope.breadcrumbs = breadcrumbs
  template: """
    <ol class="ab-nav breadcrumb">
      <li ng-repeat="breadcrumb in breadcrumbs.get() track by breadcrumb.path" ng-class="{ active: $last }">
        <a ng-if="!$last" ng-href="{{ breadcrumb.path }}" ng-bind="breadcrumb.label" class="margin-right-xs"></a>
        <span ng-if="$last" ng-bind="breadcrumb.label"></span>
      </li>
    </ol>
  """
