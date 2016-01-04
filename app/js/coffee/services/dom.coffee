'use strict'
App.factory 'DomService', ()->
  new class DomService
    siblings: (el) ->
      [].filter.call el.parentNode.children, (child) ->
        child != el

    # Native - IE10+
    closest: (el, selector) ->
      matchesSelector = el.matches || el.webkitMatchesSelector ||
      el.mozMatchesSelector || el.msMatchesSelector

      while el
        if matchesSelector.call el, selector
          return el
        else
          el = el.parentElement
      return null

    # Get the ancestors of each element in the current set of matched elements,
    # up to but not including the element matched by the selector or DOM node
    parentsUntil: (el, selector, filter) ->
      result = []
      matchesSelector = el.matches || el.webkitMatchesSelector ||
      el.mozMatchesSelector || el.msMatchesSelector

      # match start from parent
      el = el.parentElement
      while el && !matchesSelector.call(el, selector)
        if not filter
          result.push el
        else
          if matchesSelector.call(el, filter)
            result.push el
        el = el.parentElement

      return result

    # get element height
    getHeight: (el) ->
      styles = window.getComputedStyle(el)
      height = el.offsetHeight
      borderTopWidth = parseFloat(styles.borderTopWidth)
      borderBottomWidth = parseFloat(styles.borderBottomWidth)
      paddingTop = parseFloat(styles.paddingTop)
      paddingBottom = parseFloat(styles.paddingBottom)

      return height - borderBottomWidth - borderTopWidth -
      paddingTop - paddingBottom

    # sets or returns the vertical scrollbar position for the selected elements
    scrollTop: (val)->
      if document.documentElement && document.documentElement.scrollTop
        container = document.documentElement
      else
        container = document.body

      if val
        container.scrollTop = val
        return
      else
        return container.scrollTop

    # trigger a event on an element
    trigger: (el, eventName, data) ->
      if window.CustomEvent
        event = new CustomEvent eventName, {detail: data}
      else
        event = document.createEvent 'CustomEvent'
        event.initCustomEvent eventName, true, true, data
      el.dispatchEvent event
