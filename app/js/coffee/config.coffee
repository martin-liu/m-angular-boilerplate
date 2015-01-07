#
# This module loads the configuration and routes files,
# as well as bootstraps the application.

# Angular module to load routes.
angular.module("config", [])
.config ($routeProvider, $locationProvider, $logProvider) ->
  # Set debug to true by default.
  if angular.isUndefined(Config.debug) or Config.debug isnt false
    Config.debug = true

  # Set development to true by default.
  if angular.isUndefined(Config.development) or Config.development isnt false
    Config.development = true

  # Disable logging if debug is off.
  $logProvider.debugEnabled false if Config.debug is false

  # Loop over routes and add to router.
  angular.forEach Config.routes, (route) ->
    if route.params && !route.params.controller
      route.params.controller = 'BaseCtrl'
    $routeProvider.when route.url, route.params
    return
  # Otherwise
  $routeProvider.otherwise {
    templateUrl: 'partials/404.html'
  }

  # Set to use HTML5 mode, which removes the #! from modern browsers.
  # Only when config it and browser support HTML5 history API
  isHtml5Mode = !!Config.urlHtml5Mode && Modernizr.history
  $locationProvider.html5Mode isHtml5Mode
  $locationProvider.hashPrefix '!'

  return

# Setting configs
window.onload = ->
  # Declare error if we are missing a name.
  if angular.isUndefined(Config.name)
    console.error "Config.name is undefined,
    please update config.json to include this property."

  registerController = ( ->
    ctrlSet = {}
    return (ctrl) ->
      if !ctrlSet[ctrl]
        name = ctrl.substring 0, ctrl.indexOf 'Ctrl'
        angular.module(Config.name).controller ctrl,
        ['$scope', "#{name}ViewModel", (scope, ViewModel) ->
          scope.vm = new ViewModel scope
        ]
        ctrlSet[ctrl] = 1
  )()

  # Register route controllers
  angular.forEach Config.routes, (route) ->
    ctrl = route.params.controller
    ctrl ?= 'BaseCtrl'
    registerController ctrl

  # Bootstrap the application.
  angular.bootstrap document, [Config.name]
