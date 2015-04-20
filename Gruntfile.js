module.exports = function(grunt) {
  "use strict";

  grunt.initConfig({ 
    psc: {
      options: {
            main: "Examples",
            modules: ["Examples"]
      },
      example: {
          src: ["<%=libFiles%>"],
          dest: "output/examples.js"
      }
    },
    libFiles: [
      "src/**/*.purs",
      "examples/*.purs",
      "bower_components/purescript-*/src/**/*.purs",
    ],
    
    clean: ["output"],
  
    pscMake: {
      rx: {
        src: "<%=libFiles%>",
        dest: "output/node_modules"
      }
    },
    dotPsci: ["<%=libFiles%>"],
    pscDocs: {
        readme: {
            src: "src/**/*.purs",
            dest: "README.md"
        }
    },
    browserify: {
      examples: {
        src: 'main.js',
        dest: 'output/bundle.js'
      }
    }
  });

  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-purescript");
  grunt.loadNpmTasks('grunt-jsvalidate');
  grunt.loadNpmTasks('grunt-browserify');
  
  grunt.registerTask("make", ["pscMake", "dotPsci", "pscDocs", "browserify"]);
  grunt.registerTask("test", ["psc", "pscDocs"]);
  grunt.registerTask("default", ["make"]);
};
