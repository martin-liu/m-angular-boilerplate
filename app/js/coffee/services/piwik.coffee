'use strict'
App.factory 'PiwikService', ->
  return {
  init : (username) ->
    if Piwik?
      if "https:" == document.location.protocol
        protocol = "https"
      else
        protocol = "http"
      pkBaseURL = protocol + "://opspiwik.corp.ebay.com/piwik/"
      piwikTracker = Piwik.getTracker "#{pkBaseURL}/piwik.php", 1
      piwikTracker.setCustomVariable 1, "User", username, "visit"
      piwikTracker.trackPageView()
      piwikTracker.enableLinkTracking()
  }
