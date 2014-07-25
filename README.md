# Angular boilerplate out of box

* Pure HTML/CSS/JS
* For Client/Service separately SPA(Single Page Application)

## Setup
  * Install git, nodejs
  * Go to your repository directory
  * `git remote add bp https://github.com/martin-liu/m-angular-boilerplate.git`
  * `git pull bp master`
  * `sudo npm -g install grunt-cli karma bower`
  * `npm install && bower install && grunt init`

### For Windows
  * You must install msysgit correctly, and run `bower install` from the Windows Command Prompt. This is the limitation of Bower only
  * You can use `git config --global url."https://".insteadOf git://` to solve possible network issue

## Development
  * Run `grunt dev`, this will start a static server on http://localhost:8000, and also run watch tasks. You can run `grunt watch` only if the directory is already under a web server

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
* Unify jenkins build
* Travis build && auto push to github pages
  - Go to GitHub.com -> Settings -> Applications -> Personal Access Tokens — > Create new token, and copy it to your clipboard
  - In `.travis.yml` file, Change `GH_REF` value to your repository
  - `npm install travis-encrypt -g`
  - `travis-encrypt -r [repository slug] GH_TOKEN=[the token you created before]`, repository slug is for example `martin-liu/m-angular-boilerplate`
  - copy the long encrypt string to `.travis.yml`

### Details
* `routes.cson` && viewmodels
* nprogress
* intro.js && `intro.cson`
