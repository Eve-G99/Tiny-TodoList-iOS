# Tiny Todolist - A Simple SwiftUI App

This is a todolist app built with SwiftUI for iOS. It allows you to create, edit, and manage your tasks efficiently with a user-friendly interface.

## Features

- Add new tasks with descriptions and due dates.
- Edit existing tasks.
- Mark tasks as complete.
- Filter tasks by completion status.
- Sort tasks by due date or creation date, in both ascending or descending order.
- Save and load tasks using UserDefaults.

## Getting Started

1. Clone this repository.
2. Open the project in Xcode.
3. Ensure you have the necessary Xcode version (V15.2) to run the app.
4. Run the app on a simulator or device.

## Code Structure

- `Task`: A model representing a single task with properties such as description, due date, and completion status.
- `TaskViewModel`: Manages the logic for adding, editing, and retrieving tasks.

- `MainView`: The main view of the app where tasks are displayed.
- `CreateTaskView`: A view for creating new tasks.
- `EditTaskView`: A view for editing existing tasks.
- `SettingsView`: A view for configuring filtering and sorting options.

## Testing Instructions

- When testing the "Select Due Date" feature in the `EditTaskView` and `CreateTaskView`, please click on the date text itself instead of the calendar image icon to trigger the datepicker.

Feel free to contribute or extend this project to fit your needs!
