import Rails from '@rails/ujs'
import axios from 'axios'

Rails.start()

// Configure axios to use the CSRF token to make non-GET requests to work
axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
