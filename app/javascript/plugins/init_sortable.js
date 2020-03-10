import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.getElementById('location-cards');
  Sortable.create(list);
};

export { initSortable };

