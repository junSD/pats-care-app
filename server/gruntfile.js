module.exports = function(grunt) {
  "use strict";

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    copy: {
      build: {
        files: [
          {
            expand: true,
            cwd: "./public",
            src: ["**"],
            dest: "./dist/public"
          },
          {
            expand: true,
            cwd: "./views",
            src: ["**"],
            dest: "./dist/views"
          },
          {
            expand: true,
            cwd: "./src/dbpostgre",
            src: ["**"],
            dest: "./dist/dbpostgre"
          },
          {
            expand: true,
            cwd: "./env",
            src: ["**"],
            dest: "./dist/env"
          }
        ]
      }
    },
    ts: {
      app: {
        files: [{
          src: ["src/**/*.ts", "!src/.baseDir.ts"],
          dest: "./dist"
        }],
        options: {
          module: "commonjs",
          target: "es6",
          sourceMap: false,
          rootDir: "src",
          fast: "never"
        }
      }
    },
    watch: {
      ts: {
        files: ["src/**/*.ts"],
        tasks: ["tslint:all", "ts"]
      },
      views: {
        files: ["views/**/*.jade"],
        tasks: ["copy"]
      }
    },
    concurrent: {
        watchers: {
            tasks: ['nodemon', 'watch'],
            options: {
                logConcurrentOutput: true
            }
        }
      },
      nodemon: {
          dev: {
              script: './bin/www'
          },
          options: {
              ignore: ['node_modules/**', 'gruntfile.js'],
              env: {
                  PORT: '3000'
              }
          }
      },
      tslint: {
          options: {
              configuration: grunt.file.readJSON("tslint.json")
          },
          all: {
              src: ["src/**/*.ts", "!node_modules/**/*.ts", "!typings/**/*.ts"] // avoid linting typings files and node_modules files
          }
      },
  });

  grunt.loadNpmTasks("grunt-ts");
  grunt.loadNpmTasks("grunt-tslint");
  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks("grunt-nodemon");
  grunt.loadNpmTasks("grunt-concurrent");

    // Default tasks.
    grunt.registerTask('default', ["tslint:all", "ts"]);

    // grunt.registerTask('default', ["tslint:all", "ts"]);
    grunt.registerTask("serve", ["concurrent:watchers"]);

    grunt.registerTask('build', ["ts"]);

};
