const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        amber: colors.amber
      }
    }
  },
  variants: {
    extend: {}
  },
  plugins: []
};
