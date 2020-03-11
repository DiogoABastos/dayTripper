import Sortable from 'sortablejs';
import { initMapbox } from './init_mapbox';

const initSortable = () => {
  const list = document.getElementById('location-cards');
  //Sortable.create(list);

  var sortable = new Sortable(list, {
    onEnd: function(evt) {
      evt.newIndex // most likely why this event is used is to get the dragging element's current index
          // same properties as onEnd
        console.log("moved", evt.newIndex )
        console.log("EEEE", evt)
        let currentRoute = window.location.href;
        let postRoute = `${currentRoute}/reorder`;
        console.log("Route: ", postRoute)

        fetch(postRoute, {
          method: "POST",
          headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
                  },
          body: JSON.stringify({ old: evt.oldIndex, new: evt.newIndex }),
          credentials: "same-origin"
        })
          .then(response => response/*.json()*/)
          .then((data) => {
            console.log(data.hits); // Look at local_names.default
            initMapbox();
          })


      }
  });

};

export { initSortable };

// reorder_itinerary_location_path
// /itineraries/:itinerary_id/locations/:id/reorder
