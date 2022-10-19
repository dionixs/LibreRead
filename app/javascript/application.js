import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import * as ActiveStorage from "@rails/activestorage"
import 'flowbite';
import './add_jquery'
import './components/add_tags_modal'
import './components/search_by_tags'

ActiveStorage.start()
