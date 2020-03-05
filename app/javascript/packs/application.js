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
console.log(add);
const form = document.querySelector(".location-form");

if (add) {
  add.addEventListener('click', (e) => {
    e.preventDefault();
    form.classList.toggle('form-show');
  });
}

