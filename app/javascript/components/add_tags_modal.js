// Open modal window

// Set note_id to params

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);

const add_tag_buttons = document.querySelectorAll(".add-tag");

add_tag_buttons.forEach(btn => {

  btn.addEventListener('click', (event)=> {
    let id = btn.id.split('-').slice(-1);

    urlParams.set('note_id', id);

    // Change some part of the URL params
    if (history.pushState) {
      const new_url =
        window.location.protocol + "//" + window.location.host +
        window.location.pathname + "?" + urlParams.toString() +
        window.location.hash.replace('#','');
      window.history.replaceState({ path: new_url }, "", new_url);
    } else {
      window.location.search = urlParams.toString();
    }

    console.log();
  });
});


// var up = document.getElementById('GFG_UP');
//             var url = new URL("https://www.geeksforgeeks.org");
//             up.innerHTML = url;
//             var down = document.getElementById('GFG_DOWN');
//
//             function GFG_Fun() {
//                 url.searchParams.set('param_1', 'val_1');
//                 down.innerHTML = url;
//             }

// const form = document.getElementById("add-tags-form");
//
// async function handleSubmit(event) {
//   event.preventDefault();
//   let tags = document.getElementById("input-tags").value;
//   let data = new FormData(event.target);
//   console.log(tags);
//   console.log(data);
// fetch(event.target.action, {
//   method: form.method,
//   body: data,
//   headers: {
//     'Accept': 'application/json'
//   }
// }).then(response => {
//   if (response.ok) {
//     status.innerHTML = "Thanks for your submission!";
//     form.reset()
//   } else {
//     response.json().then(data => {
//       if (Object.hasOwn(data, 'errors')) {
//         status.innerHTML = data["errors"].map(error => error["message"]).join(", ")
//       } else {
//         status.innerHTML = "Oops! There was a problem submitting your form"
//       }
//     })
//   }
// }).catch(error => {
//   status.innerHTML = "Oops! There was a problem submitting your form"
// });
// }
// form.addEventListener("submit", handleSubmit)

// ✅ Create element
// const note_tag = document.createElement('span');
// note_tag.innerHTML = 'Hello, World!';
//
// document.getElementById('add-tag-btn').addEventListener('click', function handleClick(event) {
//   console.log('element clicked 🎉🎉🎉', event);
// });

// document.getElementById('add-tag-btn').onclick = function() {
//
//   const note_tags = document.getElementById('note-tags');
//   note_tags.append(note_tag);

// const elements = document.getElementsByClassName('note-tag');
//
// for(let i = 0; i < elements.length; i++)
// {
//   elements[i].classList.add('note-tag');
//   console.log(elements[i].className);
// }

// document.getElementsByClassName('note-tag').classList.toggle('hidden');
// }






