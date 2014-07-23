App.factory("animateCSSBuild", [
  "$timeout"
  ($timeout) ->
    return (baseClass, classNames) ->
      if arguments.length is 3
        a = classNames
        b = arguments[2]
        classNames =
          enter: a
          move: a
          leave: b
          show: a
          hide: b
          addClass: a
          removeClass: b
      timeoutKey = "$$animate.css-timer"
      animateCSSStart = (element, className, delay, done) ->
        element.addClass className
        element.addClass "animated"
        timer = $timeout(done, delay or 300, false)
        element.data timeoutKey, timer
        return

      animateCSSEnd = (element, className) ->
        (cancelled) ->
          timer = element.data(timeoutKey)
          if timer
            $timeout.cancel timer
            element.removeData timeoutKey
          element.removeClass className
          element.removeClass "animated"
          return

      enter: (element, done) ->
        animateCSSStart element, classNames.enter, classNames.delay, done
        animateCSSEnd element, classNames.enter

      leave: (element, done) ->
        animateCSSStart element, classNames.leave, classNames.delay, done
        animateCSSEnd element, classNames.leave

      move: (element, done) ->
        animateCSSStart element, classNames.move, classNames.delay, done
        animateCSSEnd element, classNames.move

      beforeAddClass: (element, className, done) ->
        klass = className is "ng-hide" and
        (classNames.hide or ((if angular.isFunction(classNames.addClass)
        then classNames.addClass(className) else classNames.addClass)))
        if klass
          animateCSSStart element, klass, classNames.delay, done
          return animateCSSEnd(element, klass)
        done()
        return

      addClass: (element, className, done) ->
        klass = className isnt "ng-hide" and
        ((if angular.isFunction(classNames.addClass)
        then classNames.addClass(className) else classNames.addClass))
        if klass
          animateCSSStart element, klass, classNames.delay, done
          return animateCSSEnd(element, klass)
        done()
        return

      removeClass: (element, className, done) ->
        klass = (className is "ng-hide" and classNames.show) or
        ((if angular.isFunction(classNames.removeClass)
        then classNames.removeClass(className) else classNames.removeClass))
        if klass
          animateCSSStart element, klass, classNames.delay, done
          return animateCSSEnd(element, klass)
        done()
        return
]).animation(".animate-flip-x", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-flip-x", "flipInX", "flipOutX")
]).animation(".animate-flip-y", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-flip-y", "flipInY", "flipOutY")
]).animation(".animate-fade", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade", "fadeIn", "fadeOut")
]).animation(".animate-fade-up", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-up", "fadeInUp", "fadeOutUp")
]).animation(".animate-fade-down", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-down", "fadeInDown", "fadeOutDown")
]).animation(".animate-fade-left", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-left", "fadeInLeft", "fadeOutLeft")
]).animation(".animate-fade-right", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-right", "fadeInRight", "fadeOutRight")
]).animation(".animate-fade-up-big", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-up-big", "fadeInUpBig", "fadeOutUpBig")
]).animation(".animate-fade-down-big", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-down-big", "fadeInDownBig", "fadeOutDownBig")
]).animation(".animate-fade-left-big", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-left-big", "fadeInLeftBig", "fadeOutLeftBig")
]).animation(".animate-fade-right-big", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-fade-right-big", "fadeInRightBig", "fadeOutRightBig")
]).animation(".animate-bounce", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-bounce", "bounceIn", "bounceOut")
]).animation(".animate-bounce-up", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-bounce-up", "bounceInUp", "bounceOutUp")
]).animation(".animate-bounce-down", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-bounce-down", "bounceInDown", "bounceOutDown")
]).animation(".animate-bounce-left", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-bounce-left", "bounceInLeft", "bounceOutLeft")
]).animation(".animate-bounce-right", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-bounce-right", "bounceInRight", "bounceOutRight")
]).animation(".animate-rotate", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-rotate", "rotateIn", "rotateOut")
]).animation(".animate-rotate-up-left", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild "animate-rotate-up-left"
    , "rotateInUpLeft", "rotateOutUpLeft"
]).animation(".animate-rotate-down-left", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild "animate-rotate-down-left"
    , "rotateInDownLeft", "rotateOutDownLeft"
]).animation(".animate-rotate-up-right", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild "animate-rotate-up-right"
    , "rotateInUpRight", "rotateOutUpRight"
]).animation(".animate-rotate-down-right", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild "animate-rotate-down-right"
    , "rotateInDownRight", "rotateOutDownRight"
]).animation(".animate-lightspeed", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-lightspeed", "lightSpeedIn", "lightSpeedOut")
]).animation(".animate-roll", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-roll", "rollIn", "rollOut")
]).animation ".animate-hinge", [
  "animateCSSBuild"
  (animateCSSBuild) ->
    return animateCSSBuild("animate-hinge", "fadeIn", "hinge")
]
