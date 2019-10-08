import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';
import bootstrapPlugin from '@fullcalendar/bootstrap';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';
import '@fullcalendar/list/main.css';
import '@fullcalendar/timegrid/main.css';
import '@fullcalendar/bootstrap/main.css';


const renderCalendar = (elementId) => {
    var calendarEl = document.getElementById(elementId);
    const id = calendarEl.dataset.id;

    var calendar = new Calendar(calendarEl, {

      plugins: [ dayGridPlugin, interactionPlugin, listPlugin, bootstrapPlugin ],
      themeSystem: 'bootstrap',
      header: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
    },
      editable: false,
      events: `/trips/${id}.json`,
      eventClick: (eventClickInfo) => {
        eventClickInfo.jsEvent.preventDefault();
        console.log('clicked on event ', eventClickInfo);
        // get id of event item
        let eventArray = eventClickInfo.el.href.split("@");
        let tripItemRef = eventArray[eventArray.length - 1];
        // console.log(tripItemRef);

        document.getElementById(`card-image-${tripItemRef}`).click()

        // display the relevant modal

      }
    });

    calendar.render();

}

document.addEventListener('DOMContentLoaded', function(event) {
  document.querySelector('.tab-button-calendar').addEventListener('click', () => {
    renderCalendar('calendar');

  });
    renderCalendar('small-calendar-container');
      // windowResize: function(view);


});

// $(document).ready(function() {
//     $('#calendar').fullCalendar({
//         eventStartEditable: false
//     });
// });


