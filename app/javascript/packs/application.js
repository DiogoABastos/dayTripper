import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

import { initAutocomplete } from '../plugins/init_autocomplete';


import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

initMapbox();

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
const reviewForm = document.querySelector('.review-form');
const theMap = document.querySelector('.the-map');
const reviewCards = document.querySelector('.review-cards');

if (reviewButton && reviewForm && theMap && reviewCards) {
  reviewButton.addEventListener('click', (e) => {
    reviewForm.classList.toggle('review-form-active');
    theMap.classList.toggle('the-map-active');
    reviewCards.classList.toggle('review-cards-active');
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


