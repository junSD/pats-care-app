var gulp = require('gulp');
var sonarqubeScanner = require('sonarqube-scanner');

gulp.task('sonar', (callback) => {
    sonarqubeScanner({
        serverUrl: 'http://192.168.88.241:9000',
        options: {
            "sonar.username": "developer",
            "sonar.login": "developer",
            "sonar.password": "developer"
        },
    }, callback);
});
