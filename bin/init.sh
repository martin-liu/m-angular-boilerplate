git init || {
    echo 'git not installed'
    exit
}
git remote add bp https://github.com/martin-liu/m-angular-boilerplate.git
git pull bp master
sudo npm -g install grunt-cli karma bower || {
    echo 'nodejs not installed'
    exit
}
npm install && bower install && grunt init
