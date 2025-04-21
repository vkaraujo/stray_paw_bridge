/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.{html,erb}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Nunito', 'sans-serif'],
      },
      colors: {
        cream: {
          50: '#FAF3E0',
          100: '#f6e9c7',
        },
        coral: '#F4978E',
        teal: '#A8D0DB',
      },
    },
  },
  plugins: [],
}
