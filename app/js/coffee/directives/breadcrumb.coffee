###*
 @ngdoc directive
 @name m-directive.directive:mBreadcrumb
 @element div
 @restrict AE
 @description This directive is used to create breadcrumbs
 @example
    <example module="eg">
    <file name="index.js">
      angular.module('eg',['m-directive'])
        .controller('EgCtrl', function($scope, breadcrumbs){
          $scope.breadcrumbs = breadcrumbs;
        });
    </file>
    <file name="index.html">
      <div ng-controller="EgCtrl">
        <m-breadcrumb></m-breadcrumb>
      </div>
    </file>
    </example>
###
angular.module('m-directive').directive 'mBreadcrumb',  ->
  restrict : 'AE'
  scope: {}
  controller: ($scope, breadcrumbs)->
    $scope.breadcrumbs = breadcrumbs
  template: """
    <ol class="ab-nav breadcrumb">
      <li ng-repeat="breadcrumb in breadcrumbs.get() track by breadcrumb.path"
        ng-class="{ active: $last }">
        <a ng-if="!$last" ng-href="{{ breadcrumb.path }}"
          ng-bind="breadcrumb.label" class="margin-right-xs"></a>
        <span ng-if="$last" ng-bind="breadcrumb.label"></span>
      </li>
    </ol>
  """
