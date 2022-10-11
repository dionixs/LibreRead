// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
// import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import 'flowbite';
import './modules/tom_select'

import './components/add_tags_modal'

Rails.start()
// Turbolinks.start()
ActiveStorage.start()
