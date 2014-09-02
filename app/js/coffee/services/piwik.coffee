'use strict'
App.factory 'PiwikService', (Config)->
  return {
  init : (username, pagename) ->
    if Piwik?
      siteId = Config.piwik.siteId
      pkBaseURL = Config.piwik.url
      app = Config.piwik.app
      prod = Config.piwik.prod
      piwikTracker = Piwik.getTracker "#{pkBaseURL}/piwik.php", siteId
      piwikTracker.setCustomVariable 1, "User", username, "visit"
      piwikTracker.setCustomVariable 2, "App", app, "page"
      piwikTracker.setCustomVariable 3, "PageName", pagename, "page"
      piwikTracker.setCustomVariable 4, "Prod", prod, "page"
      piwikTracker.trackPageView()
      piwikTracker.enableLinkTracking()
  }
