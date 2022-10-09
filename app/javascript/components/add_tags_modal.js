import TomSelect from "tom-select";

new TomSelect('#input-tags',{
	plugins: {
		remove_button:{
			title:'Remove this item',
		},
    clear_button:{
			title:'Remove all selected options',
		}
	},
	persist: false,
	create: true,
	onDelete: function(values) {
		return confirm(values.length > 1 ? 'Are you sure you want to remove these ' + values.length + ' items?' : 'Are you sure you want to remove "' + values[0] + '"?');
	}
});

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






