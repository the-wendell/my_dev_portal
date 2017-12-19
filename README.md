# My Dev Portal

Create a portfolio and manage your job applications.  My Dev Portal is an app that will help you manage your job hunt and show off your work.

## Current State

My Dev Portal is roughly half-way to a full release.  The 'build your own portfolio' portion of the app is mostly complete and is fully functional.  It can be found at http://mydevportal.io.  Users are able to sign up and create a portfolio that will be publicly visible at http://mydevportal.io/your-custom-name.

My Dev Portal consists of two main features:
  1. A Portfolio to show off your work
  2. A system to help you track your job applications and interviews

Feature 1 is complete and functioning.  Feature 2 is under development.

## Want to Contribute?

Currently I am only accepting contributions towards adding more portfolio themes.  If you would like to add a portfolio theme that would be awesome!

### Getting the Development Environment Started

  **Requirments:**
    * Rails 5
    * Postgres
    * Bundler -v 1.15.2 (This is the version Heroku is currently using)

  1. Run `bundle install`
  2. Run `rails db:migrate`
  3. Run `rails server`

### Instructions for Adding a New Theme

  1. Create a new template file in app/views/portfolios/themes
    * The file name will be the theme name
    * The file extension must be html.haml  If you don't already know Haml it will take you less than 20 minutes to learn and save you hours in the long run. http://http://haml.info/tutorial.html
  2. Create a new stylesheet in app/assets/stylesheets/themes
    * Give it the same name as your theme
    * The file extension must be .scss
  3.  Restart the server for the asset pipeline to pickup the new stylesheet and for the Themes initializer to pick up the template.

  The template is now selectable while logged into the My Dev Portal dashboard under the Portfolio Settings page.

  **Available Resources**

  * `@portfolio_header` **hash**
    * `.header_one` **string** = User's name
    * `.header_two` **string** = Subheading
    * `.cover_image` **string** = User's cover image.  Suffix with `.url` for original upload size, `.full.url` for an image 800px high, and `.preview.url` for an image 230px high.
    * `.avatar_image` **string** = User's avatar image.  Suffix with `.url` for original upload size, `.full.url` for an image 225px by 300px, and `.preview.url` for an image 66px by 88px.
  * `@projects` **array** = The users projects (loop through this to get individual projects)
    * `.title` **string** = Title of the project
    * `.link` **string** = Link to project webpage
    * `.description` text = Description of the project
    * `.image` **string** = Project image
    * `.tech` **string** = list of technologies used on the project
    * `.role` **string** = User's role on the project
    * `.order` **int** = User given order.  `@projects` will already be sorted by `.order`
  * `@technologies` **array** = List of technologies/skills known by the user (loop through this to get individual technologies)
    * `.name` **string** = The name of the technology
    * `.years_exp` **int** = Number of years experience
    * `.proficiency` **int** = Number from 1 to 10 of the users proficiency with a given technology
  * `@about` **hash** = Contains contact info and "About Me"
    * `.about_me` **text** = About me paragraph
    * `.about_me_brief` **string** = Abrieviated about me
    * `.location` **string** = User's location
    * `.email` **string**
    * `.github` **string**
    * `.linkedin` **string**
    * `.twitter` **string**
    * `.facebook` **string**
    * `.website` **string**
  * `@first_name` **string** User's first name

  **Available User Preferences** (Your theme must support these options)

  * Options for displaying technologies
    * The user can chose how they would like to display their skills.  They can display their years of experience, their proficiency, both, or none at all simply electing to display only the name.
    * `@show_technology` **string** Returns either 'all', 'years', 'proficiency', or 'none' indicating the user's preferences.
  * Options for displaying header
    * The user can chose if they would like to display uploaded images or none at all.
    * `@portfolio.show_cover_image` **boolean** if true then show
    * `@portfolio.show_avatar_image` **boolean** if true then show
  * Options for custom colors. Use inline CSS to allow for custom user colors.  They are all data type **string** formated as hex colors (example: `#FFFFFF`)  
    * There are 6 colors accessed through `@portfolio`
      * `.color_one`
      * `.color_two`
      * `.color_two`
      * `.color_two`
      * `.font_color_one`
      * `.font_color_one`
    * There are 2 colors accessed through `@portfolio_header`
      * `.header_one_color`
      * `.header_two_color`


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

  * Please make your theme mobile friendly
  * Your shouldn't need to add any dependencies.  Bootstrap 4, Sass, and jQuery are supported and with the fantastic addition of CSS grid you should be able to manage without adding further dependencies
