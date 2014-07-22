"use strict"
module.exports = (grunt) ->
  require("time-grunt") grunt

  # Project configuration.
  grunt.config.init
    buildEnv: grunt.option("buildEnv") or "prod"
    buildNumber: grunt.option("buildNumber") or "0"
    pkg: grunt.file.readJSON("package.json")
    config: grunt.file.readJSON("grunt.json")
    bump:
      options:
        files: "<%= config.bump.options.files %>"
        commit: true
        commitFiles: "<%= config.bump.options.commitFiles %>"
        commitMessage: "Release v%VERSION%"
        createTag: false
        tagName: "v%VERSION%"
        tagMessage: "Version %VERSION%"
        push: false

    changelog:
      options:
        dest: "CHANGELOG.md"
        template: "changelog.tpl"

    clean:
      build: [
        "dist/"
        "tmp/"
      ]
      tmp: ["tmp/"]

    concat:
      app:
        src: [
          "tmp/js/templates.js"
          "app/js/app.js"
        ]
        dest: "tmp/js/scripts.js"

      components: "<%= config.concat.components %>"
      css: "<%= config.concat.css %>"

    copy:
      tmp:
        files: [
          expand: true
          cwd: "app/"
          src: ["**"]
          dest: "tmp/"
        ]

      build:
        files: [
          {
            expand: true
            cwd: "tmp/"
            src: [
              "index.*"
              "maintainance.html"
              "js/scripts.min.js"
              "js/json2.js"
              "image/**"
              "fonts/*"
              "css/styles.min.css"
              "routes.cson"
              "intro.cson"
            ]
            dest: "dist/"
            rename: (desc, src) ->
              desc + src.replace("min.", "min.<%= buildNumber %>.")
          }
          {
            expand: true
            cwd: "tmp/"
            src: [
              "htaccess.dist"
              "<%= buildEnv %>.config.cson"
            ]
            dest: "dist/"
            rename: (dest, src) ->
              if src is "htaccess.dist"
                dest + ".htaccess"
              else
                dest + "config.cson"
          }
          {
            expand: true
            cwd: "app/components/font-awesome/"
            src: ["fonts/*"]
            dest: "dist/"
          }
          {
            expand: true
            cwd: "app/components/bootstrap/dist/"
            src: ["fonts/*"]
            dest: "dist/"
          }
          {
            expand: true
            cwd: "app/components/zeroclipboard/"
            src: ["ZeroClipboard.swf"]
            dest: "dist/asset/"
          }
        ]

    html2js:
      partials:
        src: ["app/partials/**/*.html"]
        dest: "tmp/js/templates.js"
        module: "templates"
        options:
          base: "app/"

    htmlrefs:
      dist:
        src: "tmp/index.*"
        dest: "tmp/"

      options:
        buildNumber: "<%= buildNumber %>"

    jshint:
      files: [
        "app/js/**/*.js"
        "!app/components/**"
      ]
      options:
        jshintrc: ".jshintrc"

    less:
      prod:
        options:
          compress: true
          yuicompress: true

        files:
          "tmp/css/styles.css": ["tmp/less/build.less"]

      dev:
        files:
          "app/css/styles.css": ["app/css/less/**/*.less"]

    lesslint:
      src: ["app/css/less/**.less"]

    manifest:
      build:
        options:
          basePath: "dist/"
          timestamp: true

        src: ["**/**.**"]
        dest: "dist/manifest.appcache"

    "regex-replace":
      strict:
        src: ["tmp/js/scripts.js"]
        actions: [
          name: "use strict"
          search: "\\'use strict\\';"
          replace: ""
          flags: "gmi"
        ]

      manifest:
        src: ["tmp/index.*"]
        actions: [
          name: "manifest"
          search: "<html>"
          replace: "<html manifest=\"manifest.appcache\">"
        ]

      templates:
        src: ["tmp/js/scripts.js"]
        actions: [
          name: "templates"
          search: /app\',\s\[/
          replace: "app', ['templates',"
          flags: "gmi"
        ]

    uglify:
      app:
        options:
          mangle: false

        files:
          "tmp/js/scripts.js": "tmp/js/scripts.js"

    karma:
      unit:
        configFile: "karma.unit.conf.js"

      e2e:
        configFile: "karma.e2e.conf.js"

    coffee:
      compileDefault:
        files:
          "app/js/app.js": [
            "app/js/coffee/config.coffee"
            "app/js/coffee/m-util.coffee"
            "app/js/coffee/directives/m-directive.coffee"
            "app/js/coffee/main.coffee"
            "app/js/coffee/**/*.coffee"
          ]
          "test/unit/CtrlSpec.js": ["test/coffee/unit/*.coffee"]

    coffeelint:
      app: ["app/js/coffee/**/*.coffee"]
      tests:
        files:
          src: ["test/coffee/**/*.coffee"]

        options:
          no_trailing_whitespace:
            level: "error"

    cson:
      dev:
        expand: true
        src: [
          'app/config.cson'
          'app/routes.cson'
          'app/intro.cson'
        ]
        dest: ''
        ext: '.json'
      prod:
        expand: true
        src: ['dist/*.cson' ]
        dest: ''
        ext: '.json'
    watch:
      config:
        files: ["app/**/*.cson"]
        tasks: ["cson:dev"]
      scripts:
        files: [
          "app/js/coffee/**/*.coffee"
          "test/coffee/**/*.coffee"
        ]
        tasks: [
          "coffee"
          "coffeelint"
        ]
        options:
          debounceDelay: 100

      styles:
        files: ["app/css/less/**/*.less"]
        tasks: ["less:dev"]

      livereload:
        options:
          livereload: true

        files: [
          "app/*.json"
          "app/js/*.js"
          "app/css/styles.css"
          "app/index.*"
          "app/partials/**/*.html"
        ]


  # Additional task plugins
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-conventional-changelog"
  grunt.loadNpmTasks "grunt-bump"
  grunt.loadNpmTasks "grunt-html2js"
  grunt.loadNpmTasks "grunt-htmlrefs"
  grunt.loadNpmTasks "grunt-lesslint"
  grunt.loadNpmTasks "grunt-manifest"
  grunt.loadNpmTasks "grunt-regex-replace"
  grunt.loadNpmTasks "grunt-karma"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-cson"

  grunt.registerTask "test", [
    "coffeelint"
    "lesslint"
  ]
  grunt.registerTask "build", [
    #    'test',
    "clean:build"
    "copy:tmp"
    "html2js"
    "coffee"
    "concat:app"
    "regex-replace:strict"
    "regex-replace:templates"
    "uglify"
    "regex-replace:manifest"
    "concat:components"
    "less:prod"
    "concat:css"
    "htmlrefs"
    "copy:build"
    "cson:prod"
    "clean:tmp"
    "manifest"
    "changelog"
  ]
  return
