// Karma configuration

// root of the application
basePath = '';

// frameworks
frameworks = ['jasmine'];

// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  'app/components/angular-unstable/angular.js',
  'app/components/angular-resource-unstable/angular-resource.js',
  'app/components/angular-bootstrap/ui-bootstrap.js',
  'app/components/angular-bootstrap/ui-bootstrap-tpls.js',
  'app/components/dh-services/dh.services.js',
  'app/components/dh-logging/dh.logging.js',
  'app/components/dh-authentication/dh.authentication.js',
  'app/components/dh-bootstrap/dh.bootstrap.js',
  'app/components/dh-config/dh.config.js',
  'app/components/angular-mocks/angular-mocks.js',
  'app/js/**/*.js',
  'test/unit/**/*.js'
];
preprocessors = {
  'app/js/**/*.js': 'coverage'
};

// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];

// enable / disable colors in the output (reporters and logs)
colors = true;

// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_DEBUG;

// enable / disable watching file and executing tests whenever any file changes
autoWatch = false;

// Continuous Integration mode.
// If true, it captures browsers, runs tests and exits with 0 exit code (if all tests passed) or 1 exit code (if any test failed).
singleRun = true;
// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS'];


// Reporter for Coverage
reporters = ['coverage'];

// Attributes of the Coverage Report (Type / Location)
coverageReporter = {
	type : 'cobertura',
	dir : 'coverage/',
//	file : 'coverage.txt'
}
