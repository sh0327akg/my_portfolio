module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("daisyui"),
  ],
  theme: {
    fontSize: {
      sm: '0.8rem',
      base: '1rem',
      xl: '1.25rem',
      '2xl': '1.8rem',
      '3xl': '2rem',
      '4xl': '2.5rem',
      '5xl': '3.2rem',
    },
    container: {
      center: true,
    },
  },
  daisyui:{
    themes:[
      {
        mytheme:{
          "primary": "#004643",
          "secondary": "#bbf7d0",
          "accent": "#f9bc60",
          "neutral": "#fffffe",
          "base-100": "#abd1c6",
          "info": "#a3e635",
          "success": "#22d3ee",
          "warning": "#fde047",
          "error": "#f87171",
        }
      }
    ],
  },
}
