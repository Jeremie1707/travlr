import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

const renderCalendar = (elementId) => {
    var calendarEl = document.getElementById(elementId);
    const id = calendarEl.dataset.id;

    var calendar = new Calendar(calendarEl, {
      plugins: [ dayGridPlugin, interactionPlugin ],
      editable: true,
      events: `/trips/${id}.json`
    });

    calendar.render();

}

document.addEventListener('DOMContentLoaded', function(event) {
  document.querySelector('.tab-button-calendar').addEventListener('click', () => {
    renderCalendar('calendar');
  });
    renderCalendar('small-calendar-container');

});


