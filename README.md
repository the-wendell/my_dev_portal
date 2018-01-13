# My Dev Portal

My Dev Portal is made with new developers in mind.  It allows you to quickly and easily set up a public front facing portfolio to showcase your projects and skills.  As well, you will be able to track and log your job applications.

Aside from functioning as portfolio and a job hunt managment tool for new developers My Dev Portal is also a great place to dive into the world of open source.  As the public front facing portfolios rely on themes for their layout My Dev Portal allows for an unlimited number of new devlopers to add meanginfull contributions, in the form of new themes, while putting a pull-request or two under their belt.  For detailed instructions on how to contribute see bellow.

## Table of Contents

[Current State](#state)

<a name="state"/>
## Current State

My Dev Portal is up and running at http://mydevportal.io. Users are able to jump right in and create a public facing portfolio that will be hosted at http://mydevportal.io/portfolio_name.  Users can also use their dashboard to track and log all of their current and past job applicaitons.

mydevportal.io is a permanent web app so you need not worry about losing your portfolio or job tracking data.

*mydevportal.io is being reliably hosted on a premium Heroku server*

## Want to Contribute?

As "My Dev Portal" is being built with new devlopers in mind it is also being built to allow for entry level contributions in the form of themes/templates.  One can never have too many themes!  Below you will find *very* detailed instructions on how to create a new Portfolio theme.  Do not let the longwinded instructions fool you as adding a theme is quite simple!  The majority of the instructions are simply tables depicting the available user data.

The standards for contribution are simple and minmal.
* If what you have written is a function then please add an Rspec test for it (tests are not necessary for private/protected functions)
* Portfolio themes should be responsive (tests are not necessary for themes)
* Portfolio themes must support the available user preferences (listed bellow)
* If you are adding a larger feature please do your best to consider edge cases
* This is for fun and experiences so please have fun and learn!

If there is a feature that you would like to add then please send me a quick email at scottwlivingstone@gmail.com to tell me a little bit about it - I am more than happy to have additional features added.  As well, feel free to start working on the laundry list of features to be added which can be found listed under Projects.

Also, if you fancy your self a CSS wizard and a master of style please feel free to update the look of any elements that you wish.

p.s. Pull requests to correct my spelling will also be accepted ;p

### Getting the Development Environment Started

  **Requirments:**
    * Rails 5.1.4
    * Ruby 2.3.5
    * Postgres
    * Bundler -v 1.15.2 (This is the version Heroku is currently using)

  1. Run `bundle install` to install dependencies
  2. Run `rails db:setup` to set up the Postgres database
  3. Run `rails db:migrate` to migrate the databse
  4. Run `rails server` to start the server at localhost:3000

### Instructions for Adding a New Theme

  1. Create a new template file in app/views/front_end/portfolios/themes
    * The file name will be the theme name
    * The file extension must be html.haml  If you don't already know Haml it will take you less than 20 minutes to learn and save you hours in the long run. http://http://haml.info/tutorial.html
  2. Create a new stylesheet in app/assets/stylesheets/themes
    * Give it the same name as your theme
    * The file extension must be .scss
  3.  Restart the server for the asset pipeline to pickup the new stylesheet and for the Themes initializer to pick up the template.

  The template is now selectable while logged into the My Dev Portal dashboard under the Portfolio Settings page.

  **AVAILABLE RESOURCES**

**`@portfolio_header` hash** Header images and text

Attribute Accessor | Type | Description
-------------------|------|------------
`.header_one` | **string** | User's name
`.header_two` | **string** | Subheading
`.cover_image` | **string** | User's cover image.  Suffix with `.url` for original upload size, `.full.url` for an image 800px high, and `.preview.url` for an image 230px high.
`.avatar_image` | **string** | User's avatar image.  Suffix with `.url` for original upload size, `.full.url` for an image 225px by 300px, and `.preview.url` for an image 66px by 88px.

`@projects` **array** The users projects (loop through this to get individual project hashes)

Attribute Accessor | Type | Description
-------------------|------|------------
`.title` | **string** | Title of the project
`.link` | **string** | Link to project webpage
`.description` | **text** | Description of the project
`.image` | **string** | Project image. Suffix with `.url` for original upload size, `.large.url` for an image 600px high, and `.small.url` for an image 150px high.
`.tech` | **string** | list of technologies used on the project
`.role` | **string** | User's role on the project
`.order` | **int** | User given order.  `@projects` will already be sorted by `.order`

`@technologies` **array** List of technologies/skills known by the user (loop through this to get individual technology hashes)

Attribute Accessor | Type | Description
-------------------|------|------------
`.name` | **string** | The name of the technology
`.years_exp` | **int** | Number of years experience
`.proficiency` | **int** | Number from 1 to 10 of the users proficiency with a given technology
`@about` | **hash** | Contains contact info and "About Me"
`.about_me` | **text** | About me paragraph
`.about_me_brief` | **string** | Abrieviated about me
`.location` | **string** | User's location
`.email` | **string** | User's email
`.github` | **string** | User's Github
`.linkedin` | **string** | User's Linkedin
`.twitter` | **string** | User's Twitter
`.facebook` | **string** | User's Facebook
`.website` | **string** | User's Website
`@first_name` | **string** | User's first name

  **AVAILABLE USER PREFERENCES** (Your theme must support these options)

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
  * Feel free to create reusable partials in app/views/portfolios/components.  As well, feel free to use any of the existing components that are in there.  You should be able to drop them straight into your theme with `= render partial: 'portfolios/components/some_component'`
