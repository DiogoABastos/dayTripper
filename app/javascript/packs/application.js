  import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

import { initAutocomplete } from '../plugins/init_autocomplete';


import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';


const ItIndex = document.querySelector(".itineraries.index")
const locationsShow = document.querySelector(".itineraries.show");
const locationsLocShow = document.querySelector(".locations.show");


// if (document.body.classList.contains('itineraries')) {
//   initMapbox();
// }

if (ItIndex || locationsShow || locationsLocShow) {
  initMapbox();
}

initAutocomplete();

const pagesHome = document.querySelector(".home");
const navbarTarget = document.querySelector(".navbar-lewagon");
if(pagesHome) navbarTarget.classList.add("nav-transparent");

const mapIndex = document.getElementById("map");
const indexClick = document.querySelectorAll(".index-click-map");



indexClick.forEach((itinerary) => {
  itinerary.addEventListener("click", (event) => {
    let currentMarkers = itinerary.dataset.markers;

    mapIndex.dataset.markers = currentMarkers.replace("=>",":");
    initMapbox();
  });
});

const add = document.querySelector(".add-location");
const form = document.querySelector(".location-form");

if (add) {
  add.addEventListener('click', (e) => {
    e.preventDefault();
    form.classList.toggle('form-show');
  });
}

const reviewButton = document.getElementById('review-button');
let content;
if (reviewButton) {
  content = reviewButton.innerHTML;
}
const reviewForm = document.querySelector('.review-form');
const theMap = document.querySelector('.the-map');
const reviewCards = document.querySelector('.review-cards');
// const instructions = document.querySelector('#instructions');

if (reviewButton && reviewForm && theMap && reviewCards) {
  reviewButton.addEventListener('click', (e) => {
    reviewForm.classList.toggle('review-form-active');
    theMap.classList.toggle('the-map-active');
    // instructions.classList.toggle('instructions-active');
    reviewCards.classList.toggle('review-cards-active');
    if (reviewButton.innerHTML === 'Show map') {
      reviewButton.innerHTML = content;
    } else {
      reviewButton.innerHTML = 'Show map';
    }
  });
}

const reviewFormBtn = document.querySelector('.review-form-btn');
const rreviewCards = document.querySelector('.review-cards');
const reviewRating = document.querySelector('.review-rating');

  if (reviewFormBtn && rreviewCards && reviewRating) {
    reviewFormBtn.addEventListener('click', (e) => {
      if (Array.from(Array.from(rreviewCards.children)[rreviewCards.children.length - 1].children).length >= 5) {
        Array.from(Array.from(rreviewCards.children)[rreviewCards.children.length - 1].children)[Array.from(Array.from(rreviewCards.children)[rreviewCards.children.length - 1].children).length - 1].remove();
      }

      reviewRating.lastElementChild.remove();


    });
  }

const locationBtn = document.querySelector('.location-button');

  if (locationBtn) {
    locationBtn.addEventListener('click', () => {
      initMapbox();
      initAutocomplete();
    });
  }



import { initSortable } from '../plugins/init_sortable'; // <-- add this



if(locationsShow) {

  //remove mapbox controllers
  // const mapbox = document.querySelector(".mapboxgl-ctrl")
  // const mapbox2 = document.querySelector(".mapboxgl-ctrl-bottom-right")

  // mapbox.classList.add("d-none")
  // mapbox2.classList.add("d-none")


  // Get the modal
  var modal = document.getElementById("myModal-x");

  // Get the button that opens the modal
  var btn = document.getElementById("myBtn-x");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close-x")[0];

  // When the user clicks on the button, open the modal
  btn.onclick = function() {
    modal.style.display = "block";
  }

  // // When the user clicks on <span> (x), close the modal
  // span.onclick = function() {
  //   modal.style.display = "none";
  // }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }

  initSortable(); // <-- add this

}




if (ItIndex) {
  let firstItinerary = document.querySelector(".index-click-map")

  let currentMarkers = firstItinerary.dataset.markers;

    mapIndex.dataset.markers = currentMarkers.replace("=>",":");
    initMapbox();
}


