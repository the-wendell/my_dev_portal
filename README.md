# My Dev Portal

Create a portfolio and manage your job applications.  My Dev Portal is an app that will help you manage your job hunt and show off your work.

## Current State

My Dev Portal is roughly half-way to a full release.  The current build is hosted at https://infinite-meadow-93946.herokuapp.coms.  The final build will be hosted at mydevportal.io.  In the final build a user will be able to have a public facing portfolio with the URL mydevportal.io/username.

My Dev Portal consists of two main features:
  1. A Portfolio to show off your work
  2. A system to help you track your job applications and interviews

Feature 1 is complete and function.  Feature 2 is under development.

## Want to Contribute?

Currently I am only accepting contributions towards adding more portfolio themes.  If you would like to add a portfolio theme that would be awesome!

### Getting the Development Environment Started

  **Requirments:**
    * Rails 5
    * Postgres

  1. Run `bundle install`
  2. Run `rails db:migrate`
  3. Run `rails server`

### Instructions for Adding a New Theme

  1. Create a new template file in app/views/portfolios/themes
    * The file name will be the theme name
    * The file extension must be html.haml
  2. Create a new stylesheet in app/assets/stylesheets/themes
    * Give it the same name as your theme
    * The file extension must be .scss
  3.  Restart the server for the asset pipeline to pickup the new stylesheet and for the Themes initializer to pick up the template.

  The template is now selectable while logged into the My Dev Portal dashboard under the Portfolio Settings page.

  **IMPORTANT NOTES**

  * Name space your CSS by wrapping your entire theme in a div with the class name <your-theme>.  Then reference all calls in the CSS with that div.  This will prevent styles from overlapping between themes.
    ```
    // mytheme.html.haml

    .mytheme
      .header
      .body
        .content
      .footer

    // mytheme.scss

    .mytheme .header {
      style
    }

    .mytheme .body {
      style
    }
    ```
  * Use inline CSS to allow for custom user colors.  
    * There are 6 colors accessed through `@portfolio`
      * `@portfolio.color_one`
      * `@portfolio.color_two`
      * `@portfolio.color_two`
      * `@portfolio.color_two`
      * `@portfolio.font_color_one`
      * `@portfolio.font_color_one`
    * There are 2 colors accessed through `@portfolio_header`
      * `@portfolio_header.header_one_color`
      * `@portfolio_header.header_two_color`
  * Check out db/schema.rb to reference available portfolio data.  The data can usually be accessed by `@table_name.column_name`.
  * The PortfoliosController found in app/controllers is also a greate reference for what is available to you as this is the controller that handles displaying the portfolio.
