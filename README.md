## Room Booking App
#### Overview
The Room Booking App is a SwiftUI-based iOS application that allows users to view 
and filter project rooms available for reservation. 
The app provides a clean interface with advanced filtering options, allowing users to narrow down their search by:
- Room name selection

- Minimum capacity requirement

- Resource type (Projector or Whiteboard)

While the app currently does not support actual room bookings, it lays a strong foundation for adding this functionality in the future.
This app is mocking part of the design and behaviour of the UBC SBME Booking System.

#### Features
##### Login System
Username: `Student`

Password: `sbme`

Upon successful login, users are directed to the main screen where they can browse and filter available rooms.

##### Main Screen
Displays a date range with navigation arrows to change the week.

Room availability is shown for the selected date range.

Clicking on + New Reservation opens a detailed reservation form.

##### Filtering Options
Users can refine their room search using the Resource Filter button:

Room Name: Select specific rooms to filter.

Minimum Capacity: Filter rooms that meet or exceed a certain capacity.

Resource Type: Choose between Projector, Whiteboard, or All.

##### Reservation Form
Opens when the user clicks + New Reservation next to a room.

Includes fields for:

Title of the reservation.

Owner (pre-filled with Student).

Begin and End time pickers.

Automatically calculates the booking duration.

Displays the selected Room and a Description field.


#### Acknowledgments
Thanks for trying the Room Booking App!
