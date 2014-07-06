'use strict'
App.factory 'PiwikService', (Config)->
  return {
  init : (username) ->
    if Piwik?
      siteId = Config.piwik.siteId
      pkBaseURL = Config.piwik.url
      app = Config.piwik.app
      piwikTracker = Piwik.getTracker "#{pkBaseURL}/piwik.php", siteId
      piwikTracker.setCustomVariable 1, "User", username, "visit"
      piwikTracker.setCustomVariable 2, "App", app, "page"
      piwikTracker.trackPageView()
      piwikTracker.enableLinkTracking()
  }
