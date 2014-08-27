"use strict"
module.exports = (grunt) ->
  require("time-grunt") grunt

  # Project configuration.
  grunt.config.init
    buildEnv: grunt.option("buildEnv") or "prod"
    repoName: grunt.option("repoName")
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
        ".tmp/"
      ]
      tmp: [".tmp/"]

    concat:
      template:
        src: [
          ".tmp/concat/js/scripts.min.js"
          ".tmp/js/templates.js"
        ]
        dest: ".tmp/concat/js/scripts.min.js"

    copy:
      init:
        files: [
          {
            expand: true
            cwd: 'app/'
            src: ['config.cson.dist', 'htaccess.dist']
            dest: 'app/'
            rename: (dest, src) ->
              if src == 'htaccess.dist'
                dest + '.htaccess'
              else
                dest + 'config.cson'
          }
          {
            expand: true
            cwd: 'app/js/'
            src: ['local.js.dist']
            dest: 'app/js/'
            rename: (dest, src) ->
              dest + 'local.js'
          }
        ]
      tmp:
        files: [
          expand: true
          cwd: "app/"
          src: ["**"]
          dest: ".tmp/"
        ]

      build:
        files: [
          {
            expand: true
            cwd: ".tmp/"
            src: [
              "index.*"
              "maintainance.html"
              "js/json2.js"
              "image/**"
              "fonts/*"
              "routes.json"
              "intro.json"
            ]
            dest: "dist/"
          }
          {
            expand: true
            cwd: ".tmp/"
            src: [
              "htaccess.dist"
              "<%= buildEnv %>.json"
            ]
            dest: "dist/"
            rename: (dest, src) ->
              if src is "htaccess.dist"
                dest + ".htaccess"
              else
                dest + "config.json"
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
        dest: ".tmp/js/templates.js"
        module: "templates"
        options:
          base: "app/"

    jshint:
      files: [
        "app/js/**/*.js"
        "!app/components/**"
      ]
      options:
        jshintrc: ".jshintrc"

    less:
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
        src: [".tmp/concat/js/scripts.min.js"]
        actions: [
          name: "use strict"
          search: "\\'use strict\\';"
          replace: ""
          flags: "gmi"
        ]

      manifest:
        src: [".tmp/index.*"]
        actions: [
          name: "manifest"
          search: "<html>"
          replace: "<html manifest=\"manifest.appcache\">"
        ]

      templates:
        src: [".tmp/concat/js/scripts.min.js"]
        actions: [
          name: "templates"
          search: /app\',\s\[/
          replace: "app', ['templates',"
          flags: "gmi"
        ]

      travis:
        src: ['dist/index.html']
        actions: [
          name: "travis"
          search: /<base href="\/">/
          replace: '<base <%= repoName %> href="\/<%= repoName %>\/">'
        ]

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
        src: ['.tmp/*.cson' ]
        dest: ''
        ext: '.json'
    watch:
      config:
        files: ["app/**/*.cson"]
        tasks: ["cson:dev"]
        options:
          atBegin: true
      scripts:
        files: [
          "app/js/coffee/**/*.coffee"
          "test/coffee/**/*.coffee"
        ]
        tasks: [
          "coffee"
          "coffeelint"
          "ngdocs"
        ]
        options:
          debounceDelay: 300
          atBegin: true

      styles:
        files: ["app/css/less/**/*.less"]
        tasks: ["less:dev"]
        options:
          atBegin: true

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
    # Static file server
    connect:
      server:
        options:
          port: 8000
          base: 'app'
          keepalive: true
    # Concurrent tasks
    concurrent:
      dev:
        tasks: ['connect', 'watch']
        options:
          logConcurrentOutput: true

    ngdocs:
      options:
        dest: 'app/docs'
        scripts: ['dist/js/scripts.min.0.js']
        styles: ['dist/css/styles.min.0.css']
      all: ['app/js/app.js']

    "git-rev-parse":
      build:
        options:
          prop: "buildCommitId"
          number: "8"

    ngAnnotate:
      dist:
        files:
          '.tmp/concat/js/scripts.min.js': '.tmp/concat/js/scripts.min.js'

    filerev:
      options:
        encoding: 'utf8'
        algorithm: 'md5'
        length: 8
      images:
        src: [
          'dist/image/**/*.{jpg,jpeg,gif,png,webp}'
          'dist/js/scripts.min.js'
          'dist/css/styles.min.css'
        ]

    useminPrepare:
      html: '.tmp/index.*'

    usemin:
      html: 'dist/index.*'

  # Additional task plugins
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-conventional-changelog"
  grunt.loadNpmTasks "grunt-bump"
  grunt.loadNpmTasks "grunt-html2js"
  grunt.loadNpmTasks "grunt-lesslint"
  grunt.loadNpmTasks "grunt-manifest"
  grunt.loadNpmTasks "grunt-regex-replace"
  grunt.loadNpmTasks "grunt-karma"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-cson"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-ngdocs"
  grunt.loadNpmTasks "grunt-usemin"
  grunt.loadNpmTasks "grunt-ng-annotate"
  grunt.loadNpmTasks "grunt-filerev"

  grunt.registerTask "init", [
    "copy:init"
  ]

  grunt.registerTask "dev", [
    "concurrent:dev"
  ]

  grunt.registerTask "test", [
    "coffeelint"
    "lesslint"
  ]

  grunt.registerTask 'do-usemin', [
    'useminPrepare'
    'concat:generated'
    'concat:template'
    "regex-replace:strict"
    "regex-replace:templates"
    'ngAnnotate'
    'cssmin:generated'
    'uglify:generated'
    "regex-replace:manifest"
    "cson:prod"
    "copy:build"
    'filerev'
    'usemin'
  ]

  grunt.registerTask "build", [
    #    'test',
    "clean:build"
    "coffee"
    "less:dev"
    "copy:tmp"
    "html2js"
    "do-usemin"
    #"clean:tmp"
    "manifest"
    "changelog"
  ]
  return
