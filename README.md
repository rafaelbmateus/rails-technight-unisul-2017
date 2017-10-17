## Tickets Project
Rails Tutorial for Unisul Technight 2017

- Google slides: https://goo.gl/JhQ4pX

## Required
- Create a account in codeanywhere https://codeanywhere.com/
- Create a new project container, "Ruby Development Stack with RVM and Ruby on Rails preinstalled.	Ubuntu 14.04"

## Steps
### Scaffold Users
```
$ rails generate scaffold User name age:integer is_admin:boolean
$ rake db:migrate
```
  
### Get Users
```
localhost:3000/users
localhost:3000/users.json
```

### Scaffold Status
```
$ rails generate scaffold Status name
$ rake db:migrate
```
  
### Get Status
```
localhost:3000/statuses
localhost:3000/statuses.json
```
  
### Scaffold Tickets
```
$ rails generate scaffold Ticket title description status:references user:references
$ rake db:migrate
```
  
### Get Tickets
```
localhost:3000/tickets
localhost:3000/tickets.json
```
  
### Authentication
- Add in Gemfile
```ruby
# Flexible authentication solution for Rails with Warden. 
gem 'devise'
```
```
$ bundle install
$ rails generate devise:install
$ rails generate devise User
$ rake db:migrate
```

- Add in app/controllers/application_controller.rb
```
before_action :authenticate_user!
```

### Routes
- Add in config/routes.rb
```ruby
Rails.application.routes.draw do
  root 'tickets#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users
  resources :tickets
  resources :statuses
end
```
  
### Layout
- Add Bootstrap Sass Gem
```ruby
# Bootstrap Sass
gem 'bootstrap-sass'
```

- Converter your css to scss
```
$ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
```

#### Create custom.scss
```css
app/assets/stylesheets/custom.scss
@import "bootstrap-sprockets";
@import "bootstrap";

/* mixins, variables, etc. */
$color-default  : #2196F3;
$gray-medium-light: #eaeaea;

/* universal */

body {
  padding-top: 60px;
}

section {
  overflow: auto;
}

textarea {
  resize: vertical;
}

.center {
  text-align: center;
  h1 {
    margin-bottom: 10px;
  }
}

/* typography */

h1, h2, h3, h4, h5, h6 {
  line-height: 1;
}

h1 {
  font-size: 3em;
  letter-spacing: -2px;
  margin-bottom: 30px;
  text-align: center;
}

h2 {
  font-size: 1.2em;
  letter-spacing: -1px;
  margin-bottom: 30px;
  text-align: center;
  font-weight: normal;
  color: $gray-light;
}

p {
  font-size: 1.1em;
  line-height: 1.7em;
}


/* header */
header {
  background-color: $color-default;
  border-color: $color-default;
  a {
    color: #ffffff;
  }
}

#logo {
  float: left;
  margin-right: 10px;
  font-size: 1.7em;
  color: white;
  text-transform: uppercase;
  letter-spacing: -1px;
  padding-top: 9px;
  font-weight: bold;
  &:hover {
    color: white;
    text-decoration: none;
  }
}

/* footer */
footer {
  margin-top: 45px;
  padding-top: 5px;
  border-top: 1px solid $gray-medium-light;
  color: $gray-light;
  a {
    color: $gray;
    &:hover {
      color: $gray-darker;
    }
  }
  small {
    float: left;
  }
  ul {
    float: right;
    list-style: none;
    li {
      float: left;
      margin-left: 15px;
    }
  }
}
```

#### Partials
```
$ touch app/views/layouts/_header.html.erb
$ touch app/views/layouts/_footer.html.erb
```

##### Header
- Add in app/views/layouts/_header.html.erb
```html
<header class="navbar navbar-fixed-top">
  <div class="container">
    <%= link_to "Ticket Project", root_path, id: "logo" %>
    <nav>
      <ul class="nav navbar-nav navbar-right">
        <% if user_signed_in? %>
          <li><%= link_to "Tickets", tickets_path %></li>
          <% if current_user.is_admin? %>
            <li><%= link_to "Users", users_path %></li>
          <% end %>
          <li><%= link_to "Logout", destroy_user_session_path, :method => :delete %></li>
        <% end %>
      </ul>
    </nav>
  </div>
</header>

<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```

##### Footer
- Add in app/views/layouts/_footer.html.erb
```html
<footer class="footer">
  <small>
    The Ruby on Rails Technight Unisul 2017
    by <a href="http://www.rafaelbmateus.com.br/">Rafael Mateus</a>
  </small>
  <nav>
    <ul>
      <li><%= link_to "GitHub", 'https://github.com/rafaelbmateus/rails-technight-unisul-2017' %></li>
    </ul>
  </nav>
</footer>
```

##### Application
- Update in app/views/layouts/application.html.erb
```html
<!DOCTYPE html>
<html>
<head>
  <title>Rails Technight Unisul 2017</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <%= render 'layouts/header' %>
  <div class="container">
    <%= yield %>
    <%= render 'layouts/footer' %>
  </div>  
</body>
</html>
```

### Rails Admin
#### Add in Gemfile
```
gem 'rails_admin', '~> 1.2'
```
```
bundle install
rails g rails_admin:install
```

#### Authentication
- add in config/initializers/rails_admin.rb
```ruby
  config.authenticate_with do
    redirect_to main_app.root_path unless
    current_user.is_admin?
  end
```
