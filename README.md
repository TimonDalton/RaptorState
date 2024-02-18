# giglee_frontend_state_management_iterations

"A new Flutter project."

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Process:

1:Backend<->2:DataStore<->3:Widgets

1<->2: Backend has list of UUID's of resources. Frontend stores them aswell. Frontend polls backend periodically with its in-use UUIDs and their last updated times, it then receives back the UUIDs that changed as well as their new values. If there is an error with the data, it does not update for the user but continues with the current working value. The frontend stores these values locally from time to time aswell.
2<->3: DataStore updates from time to time, either from backend or from frontend input. It then updates the related wigets through a state management solution. Since there may be a discrepency between backend and frontend UUIDs, the frontend generates its own UUIDs and then maps them to the correct backend ones upon updating. This also allows the frontend to create new content offline.

1<->3: When a data widget is created, 
Loadable is created by getterService, which gets data locally if it exists, or sends to backend. On change to loadable, update occurs on UI.

Inherited Widget:
https://stackoverflow.com/questions/49491860/flutter-how-to-correctly-use-an-inherited-widget