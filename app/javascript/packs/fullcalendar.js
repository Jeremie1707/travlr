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

let CALENDARS = [];

const buildCalendar = (elementId) => {
    var calendarEl = document.querySelector(elementId);
    const id = calendarEl.dataset.id;

    var calendar = new Calendar(calendarEl, {
      firstDay: 1,
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
    calendar.travlrCalendarName = elementId;

    calendar.render();
    CALENDARS.push(calendar);
};

const renderCalendar = elementId => {
  CALENDARS.forEach(calendar => {
    if (calendar.travlrCalendarName === elementId) {
      calendar.updateSize();
      return;
    }
  });
};

document.addEventListener('DOMContentLoaded', function(event) {
  // Render calendars after page loads
  buildCalendar('#calendar');
  buildCalendar('#small-calendar-container');


  // Click the Calendar tab - render the big calendar
  document.querySelector('.tab-button-calendar').addEventListener('click', () => {
    renderCalendar('#calendar');
  });

  // Click the small calendar tab on Trip Suggestions page -
  // render the small calendar
  document.getElementById('profile-tab-md').addEventListener('click', () => {
    renderCalendar('#small-calendar-container');
  });


  // Click the expand button - render the big calendar.
  document.querySelector('.fa-expand-arrows-alt').addEventListener('click', () => {
    renderCalendar('#calendar');
  });
});
