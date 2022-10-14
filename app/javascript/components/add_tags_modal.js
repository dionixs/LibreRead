// TODO: Refactoring

import Tagify from '@yaireo/tagify'

const csrfToken = document.getElementsByName("csrf-token")[0].content;

const inputTags = document.getElementById("input-tags")
const addNewTagForm = document.getElementById("add-new-tag-form")
const addTagButtons = document.querySelectorAll(".add-tag");

function changeActionInForm(import_id, note_id) {
  addNewTagForm.action = `/imports/${import_id}/notes/${note_id}`
}

function submitNewTags(url) {
  console.log(url);
  $("#save-tags-btn").on("click", function(event) {
    // event.preventDefault();
    $.ajax({
      headers: {
        "X-CSRF-Token": csrfToken
      },
      type: "PATCH",
      url: url,
      data: {
      note: {
        all_tags: inputTags.value
      },
    },
      success: function(result) {
        // Append the result to a table or list, $("list").append(result)
      },
    });
  });
}

addTagButtons.forEach(btn => {

  btn.addEventListener('click', (event)=> {
    let queryString = window.location.search;
    let urlParams = new URLSearchParams(queryString);

    const import_id = btn.dataset.importId;
    const note_id = btn.dataset.noteId;

    urlParams.set('note_id', note_id);

    // // Change some part of the URL params
    if (history.pushState) {
      const new_url =
        window.location.protocol + "//" + window.location.host +
        window.location.pathname + "?" + urlParams.toString() +
        window.location.hash.replace('#','');
      window.history.replaceState({ path: new_url }, "", new_url);
    } else {
      window.location.search = urlParams.toString();
    }

    function getTitles(data) {
      let titles = []

      data.forEach(title => {
        for (let key in title) {
          let str = `${title[key]}`;
          titles.push(str);
        }
      })
      return titles;
    }

    function changeDataForm(data) {
      changeActionInForm(import_id, note_id);

      let tagify = new Tagify(inputTags, {
        originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(', ')
      })

      tagify.removeAllTags();
      tagify.addTags(getTitles(data));
      tagify.updateValueByDOMTags();
    }

    // Ajax
    fetch(`/imports/${import_id}/notes/${note_id}.json`, {
      method: "GET",
      headers: {
        "X-CSRF-Token": csrfToken,          // 👈👈👈 you need to set token
        "Content-Type": "application/json", // 👈👈👈 To send json in body, specify this
        Accept: "application/json"         // 👈👈👈 Specify the response to be returned as json. For api only mode, this may not be needed
      }
    })
      .then((response) => response.json())
      .then((data) => {
        changeDataForm(data);
        submitNewTags(addNewTagForm.action);
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  });
});
