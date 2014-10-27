# Angular boilerplate out of box

* Pure HTML/CSS/JS
* For Client/Service separately SPA(Single Page Application)

## Setup
**via** `curl`:

`curl -L https://raw.githubusercontent.com/martin-liu/m-angular-boilerplate/master/bin/init.sh | sh`

**via** `wget`:

`wget --no-check-certificate https://raw.githubusercontent.com/martin-liu/m-angular-boilerplate/master/bin/init.sh -O - | sh`

**Or manual way**:
  * Install git, nodejs
  * Go to your repository directory
  * `git remote add bp https://github.com/martin-liu/m-angular-boilerplate.git`
  * `git pull bp master`
  * `sudo npm -g install grunt-cli karma bower`
  * `npm install && bower install && grunt init`

**Note**:
  * You can use `git config --global url."https://".insteadOf git://` to solve possible network issue
  * For **Windows** environment, you must install msysgit correctly, and run `bower install` from the Windows Command Prompt. This is the limitation of Bower only

## Development
  * Run `grunt start`, this will start a static server on http://localhost:8000, and also run watch tasks. You can run `grunt watch` only if the directory is already under a web server

## Documentation

### Watch task
  * JS: All of the coffee codes under `app/js/coffee/` will be compiled and concatenated to `app/app.js`
  * CSS: The `app/css/less/build.less` will be compiled to `app/css/styles.css`, you can create other less files and use `@import` in `build.less`
  * Config: All of the `.cson` files under `app/` will be compiled to corresponding `.json` files

### Execution
  * The application-entry is `app/index.html`, and all the urls should forward to it in web server internally
  * The real execution order of coffeesrcipts is `app/js/coffee/config.coffee` -> `app/js/coffee/main.coffee` -> other coffees
  * `app/js/coffee/config.coffee`
      1. Load config files(routes.json, config.json, intro.json) and save to `Config` object
      2. Create controlles based on routes.json, the created controllers will reference crossponding ViewModels to `$scope.vm`
      3. Bootstrap angular
  * `app/js/coffee/main.coffee`
      1. Angular config for dependencies and global error handler
      2. `$rootScope` binding

## Learn
### Directory Structure
```
├── CHANGELOG.md
├── Gruntfile.coffee
├── README.md
├── app
│   ├── config.cson.dist
│   ├── css
│   │   ├── less
│   │   └── styles.css
│   ├── dev.config.cson
│   ├── htaccess.dist
│   ├── index.html
│   ├── intro.cson
│   ├── js
│   │   ├── coffee
│   │   ├── json2.js
│   │   └── local.js.dist
│   ├── maintainance.html
│   ├── partials
│   │   ├── directive
│   │   ├── home.html
│   │   ├── logout.html
│   │   └── modal
│   ├── prod.config.cson
│   └── routes.cson
├── bower.json
├── changelog.tpl
├── grunt.json
├── karma.e2e.conf.js
├── karma.unit.conf.js
└── package.json
```

### Highlight
* Static file server for quick development
* Dev/test/build process
* CacheBust, minify, uglify
* Livereload
* Animation
* Modular && Inheritance support
* Resueable UI functions/components
* Local cache, persistence
* Global error handler
* Travis build && auto push to github pages
  - Go to GitHub.com -> Settings -> Applications -> Personal Access Tokens — > Create new token, and copy it to your clipboard
  - In `.travis.yml` file, Change `GH_REF` value to your repository
  - `npm install travis-encrypt -g`
  - `travis-encrypt -r [repository slug] GH_TOKEN=[the token you created before]`, repository slug is for example `martin-liu/m-angular-boilerplate`
  - copy the long encrypt string to `.travis.yml`

### Details
#### Base
* `routes.cson` && viewmodels
You don't have to write controllers, controller will be auto created based on routes.cson.
For example, when routes.cson is as below:
```
  [{
    url: "/"
    params:
      name: "home"
      label: "Home"
      templateUrl: "partials/home.html"
      controller: "HomeCtrl"
  }]
```
You don't need to write HomeCtrl controller, you should create a HomeViewModel class and extends BaseViewModel


* nprogress
* intro.js && `intro.cson`

#### UI Components / Directives
* announcement
* breadcrumb
* fullscreen
* loading
* more button
* no result
* resize
* scroll
