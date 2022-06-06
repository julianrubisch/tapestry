const gray = {
  50: "#fafbfa",
  100: "#f3f5f1",
  200: "#eff2ed",
  300: "#e7ebe3",
  400: "#d4dbce",
  500: "#c9c6b8",
  600: "#a29f90",
  700: "#7b786b",
  800: "#1F2937",
  900: "#292824",
};

const primary = {
  50: "#F7FEFF",
  100: "#E6F5F6",
  200: "#c4e3e7",
  300: "#92d2da",
  400: "#46bbca",
  500: "#2ea6b6",
  600: "#1697a9",
  700: "#12798b",
  800: "#0d6373",
  900: "#0a4f5b",
};

module.exports = {
  mode: "jit",
  content: [
    "./app/**/*.html.erb",
    "./app/components/**/*.rb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        gray,
        primary,
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
