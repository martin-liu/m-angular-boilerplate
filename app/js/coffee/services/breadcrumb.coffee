App.factory "breadcrumbs", [
  "$rootScope"
  "$location"
  "$route"
  ($rootScope, $location, $route) ->
    BreadcrumbService =
      breadcrumbs: []
      get: ->
        if @options
          self = this
          for key of @options
            if @options.hasOwnProperty(key)
              angular.forEach self.breadcrumbs, (breadcrumb) ->
                breadcrumb.label = self.options[key]  if breadcrumb.label is key
                return

        @breadcrumbs

      generateBreadcrumbs: ->
        routes = $route.routes
        pathElements = $location.path().split("/")
        path = ""
        self = this
        getRoute = (route) ->
          param = undefined
          angular.forEach $route.current.params, (value, key) ->
            re = new RegExp(value)
            param = value  if re.test(route)
            route = route.replace(re, ":" + key)
            return

          path: route
          param: param

        delete pathElements[1]  if pathElements[1] is ""
        @breadcrumbs = []
        angular.forEach pathElements, (el) ->
          path += (if path is "/" then el else "/" + el)
          route = getRoute(path)
          if routes[route.path]
            label = routes[route.path].label or route.param
            self.breadcrumbs.push
              label: label
              path: path

          return

        return


    # We want to update breadcrumbs only when a route is actually changed
    # as $location.path() will get updated immediately
    # (even if route change fails!)
    $rootScope.$on "$routeChangeSuccess", ->
      BreadcrumbService.generateBreadcrumbs()
      return

    return BreadcrumbService
]
