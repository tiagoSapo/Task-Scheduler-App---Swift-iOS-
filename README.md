# Task Scheduler App

An iOS application built using Swift for task scheduling and management. Users can create, register, edit, and delete tasks. The app provides different view controllers for managing tasks based on their status (e.g., not started, in progress, completed) and supports various device sizes and orientations.

## View Controllers Overview

- **ViewController**: Main view controller where users start the application and can create a new task.
- **CriarTarefaViewController**: Allows users to input task details and create a new task. Utilizes CoreKit for data storage.
- **TarefasNaoRealizadasViewController**: Displays tasks that have not been started. Users can delete, edit, or create new tasks.
- **TarefasEmRealizaçaoViewController**: Displays tasks that are in progress. Similar functionality to the previous view controller.
- **TarefasConcluidasViewController**: Displays completed tasks. Similar functionality to the previous view controller.
- **TodasAsTarefasViewController**: Displays all tasks, regardless of their status. Similar functionality to the previous view controllers.

## Storyboard Design

The app's user interface was designed using a storyboard to ensure compatibility with different iOS devices, including iPad and iPhone. Constraints were used to adapt layouts to various device sizes and orientations.

## General Information

This task scheduling application was developed for iOS using Swift programming language. It offers a user-friendly interface for managing tasks across different Apple devices, utilizing modern design principles and adapting to various screen sizes.
