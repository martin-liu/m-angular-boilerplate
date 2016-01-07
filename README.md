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
  * If you already have a repository
    + Go to your repository directory
    + `git remote add bp https://github.com/martin-liu/m-angular-boilerplate.git`
    + `git pull bp master`
  * Or you can fork this project, and run `git clone YOUR_REPO_URL`
  * `sudo npm -g install grunt-cli karma bower`
  * `npm install && bower install && grunt init`

**Note**:
  * You can use `git config --global url."https://".insteadOf git://` to solve possible network issue
  * For **Windows** environment, you must install msysgit correctly, and run `bower install` from the Windows Command Prompt. This is the limitation of Bower only

## Development
  * Run `grunt start`, this will start a static server on http://localhost:8000, and also run watch tasks. You can run `grunt watch` only if the directory is already under a web server

## Documentation
Please see [wiki](https://github.com/martin-liu/m-angular-boilerplate/wiki)

### Watch task
  * JS: All of the coffee codes under `app/js/coffee/` will be compiled and concatenated to `app/js/app.js`; js code under `app/js/coffee/` will also be concatenated to `app/js/app.js`
  * CSS: The `app/css/less/build.less` will be compiled to `app/css/styles.css`, you can create other less files and use `@import` in `build.less`
  * Config: Config files are under `app/config/`, they will be concatenated and put on the top of `app/js/app.js`

### Execution
  * The application-entry is `app/index.html`, and all the urls should forward to it in web server internally
  * All JS/Coffee code will be processed and then concatenated to `app/js/app.js`, config files under `app/config/` will be the top of `app.js`; All less code will be processed and concatenated to `app/css/styles.css`.
  * The real execution order of coffeesrcipts is `app/js/coffee/config.coffee` -> `app/js/coffee/main.coffee` -> other coffees
  * `app/js/coffee/config.coffee`
      1. Create controlles and link html file corresponding to `app/config/routes.coffee`, the created controllers will reference crossponding ViewModels to `$scope.vm`
      2. Bootstrap angular
  * `app/js/coffee/main.coffee`
      1. Angular config for dependencies and global error handler
      2. `$rootScope` binding

## Learn
### Directory Structure
```
├├── CHANGELOG.md
├── Gruntfile.coffee
├── README.md
├── app
│   ├── browserconfig.xml
│   ├── config
│   │   ├── config.coffee.dev
│   │   ├── config.coffee.dist
│   │   ├── config.coffee.prod
│   │   ├── intro.coffee
│   │   └── routes.coffee
│   ├── css
│   │   ├── less
│   │   │   ├── app.less
│   │   │   ├── build.less
│   │   │   ├── home.less
│   │   │   └── lesshat-prefixed.less
│   ├── htaccess.dist
│   ├── humans.txt
│   ├── image/
│   ├── index.html
│   ├── js
│   │   ├── coffee
│   │   │   ├── config.coffee
│   │   │   ├── constants.coffee
│   │   │   ├── directives
│   │   │   ├── m-util.coffee
│   │   │   ├── main.coffee
│   │   │   ├── services
│   │   │   └── viewModles
│   │   ├── lib
│   │   │   └── json2.js
│   │   └── local.js.dist
│   ├── maintainance.html
│   ├── notsupport.html
│   ├── partials/
│   └── robots.txt
├── bin
│   ├── init.sh
│   └── travis-deploy-ghpages.sh
├── bower.json
├── changelog.tpl
├── grunt.json
├── karma.e2e.conf.js
├── karma.unit.conf.js
└── package.json
```

### Highlight
* Static file server for quick development
    `grunt start` will start a web server on `http://localhost:8000`
* Dev/test/build process, build with different config file in different env
    `grunt build --buildEnv=prod `
* CacheBust, minify, uglify
* Livereload
    When js/html code change, the browser will auto refresh. When less/css code change, the browser will auto apply new styles
* Animation
    Integrate [animate.css](https://github.com/daneden/animate.css/) with AngularJS, add class name like `.animate-fade` to an element, then it will `fade-in` when display and `fade-out` when dismiss. See [detail](https://github.com/martin-liu/m-angular-boilerplate/blob/master/app/js/coffee/services/animate.coffee)
* Modular && Inheritance support
* Resueable UI functions/components
* Local cache, persistence
    Provide client cache with expire time for performance and reduce requests to server; `$rootScope.persistence` will auto be stored to localstorage, so that it can be used to record user's last status
* Global error handler
* Travis build && auto push to github pages
  - Go to GitHub.com -> Settings -> Applications -> Personal Access Tokens — > Create new token, and copy it to your clipboard
  - In `.travis.yml` file, Change `GH_REF` value to your repository
  - `npm install travis-encrypt -g`
  - `travis-encrypt -r [repository slug] GH_TOKEN=[the token you created before]`, repository slug is for example `martin-liu/m-angular-boilerplate`
  - copy the long encrypt string to `.travis.yml`

### Details
#### Base
* `routes.coffee` && ViewModels
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
