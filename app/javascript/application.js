import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import * as ActiveStorage from "@rails/activestorage"
import 'flowbite';
import './add_jquery'

ActiveStorage.start()

import './components/add_tags_modal'
