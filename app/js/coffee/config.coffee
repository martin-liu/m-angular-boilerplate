#
# This module loads the configuration and routes files,
# as well as bootstraps the application. At
# runtime it adds uri based on application location.

# Config variable.
Config = window.Config = {}

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
    $routeProvider.when route.url, route.params
    return

  # Set to use HTML5 mode, which removes the #! from modern browsers.
  $locationProvider.html5Mode true
  $locationProvider.hashPrefix '!'

  return

# Setting configs
.run ($location) ->
  Config.uri = {}  if angular.isUndefined(Config.uri)

  # Add uri details at runtime based on environment.
  uri = host: $location.protocol() + "://" + $location.host() + "/"

  # Extend uri config with any declared uri values.
  Config.uri = angular.extend(uri, Config.uri)
  return


# This runs when all code has loaded, and loads the config and
# route json manifests, before bootstrapping angular.
window.onload = ->
  if window.unSupport
    return

  # Files to load initially.
  files = [
    {
      property: "config"
      file: "config.json"
    }
    {
      property: "routes"
      file: "routes.json"
    }
    {
      property: "intro"
      file: "intro.json"
    }
  ]
  loaded = 0

  lowercase = (string) ->
    if typeof string == 'string'
      string.toLowerCase()
    else
      string

  ###
   IE 11 changed the format of the UserAgent string.
   See http://msdn.microsoft.com/en-us/library/ms537503.aspx
  ###
  msie = parseInt (/msie (\d+)/.exec(lowercase(navigator.userAgent)) || [])[1]
  if isNaN msie
    msie = parseInt (/trident\/.*; rv:(\d+)/
    .exec(lowercase(navigator.userAgent)) || [])[1]

  # Request object
  Request = (item, file) ->
    if msie <= 8 && !window.XMLHttpRequest
      loader = new ActiveXObject 'Microsoft.XMLHTTP'
    else
      loader = new XMLHttpRequest()

    # onload event for when the file is loaded
    loader.onreadystatechange = ->
      if loader && loader.readyState == 4
        loaded++
        if item is "config"
          Config = angular.extend Config, JSON.parse loader.responseText
        else
          Config[item] = JSON.parse loader.responseText

        # We've loaded all dependencies, lets bootstrap the application.
        if loaded is files.length

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
            if ctrl
              registerController ctrl

          # Bootstrap the application.
          angular.bootstrap document, [Config.name]
      return

    loader.open "get", file, true
    loader.send()
    return

  for index of files
    load = new Request(files[index].property, files[index].file)
  return
