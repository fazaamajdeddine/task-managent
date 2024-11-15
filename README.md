# Task Management App

This project is a **Task Management Application** built with **Flutter**. It follows the principles of **Clean Architecture**, ensuring scalability, maintainability, and testability. State management is handled using **Riverpod**.

## Table of Contents
1. [Overview](#overview)
2. [Clean Architecture Layers](#clean-architecture-layers)
   - [Domain Layer](#domain-layer)
   - [Data Layer](#data-layer)
   - [Presentation Layer](#presentation-layer)
3. [Riverpod State Management](#riverpod-state-management)
4. [Project Structure](#project-structure)
5. [How to Run](#how-to-run)
6. [Future Improvements](#future-improvements)

---

## Overview

The app allows users to:
- Create, view, update, and delete tasks.
- Mark tasks as completed or incomplete.
- Display task completion status visually.
- Interact with tasks using modern UI/UX practices, including modal bottom sheets and swipe gestures.

By using **Clean Architecture**, the project is divided into three main layers, ensuring separation of concerns and testability.


```
lib
├── features
│   ├── authentication
│   │   ├── data
│   │   │   ├── datasources
│   │   │   │   ├── auth_local_data_source.dart
│   │   │   │   └── auth_remote_data_source.dart
│   │   │   └── repository
│   │   │       └── authentication_repository_impl.dart
│   │   ├── domain
│   │   │   ├── providers
│   │   │   │   └── authentication_provider.dart
│   │   │   ├── repository
│   │   │   │   └── authentication_repository.dart
│   │   │   └── usecases
│   │   │       └── auth_use_case.dart
│   │   └── presentation
│   │       ├── providers
│   │       │   ├── auth_providers.dart
│   │       │   └── states
│   │       │       ├── auth_notifier.dart
│   │       │       ├── auth_state.dart
│   │       │       └── auth_state.freezed.dart
│   │       ├── screens
│   │       │   └── authentication
│   │       │       └── login.dart
│   │       └── widgets
│   │           ├── button_with_text.dart
│   │           └── fields.dart
│   └── tasks
│       ├── data
│       │   ├── datasource
│       │   │   └── tasks_remote_datasource.dart
│       │   └── repository
│       │       └── tasks_repository_impl.dart
│       ├── domain
│       │   ├── providers
│       │   │   └── tasks_providers.dart
│       │   ├── repository
│       │   │   └── tasks_repository.dart
│       │   └── usecases
│       │       ├── add_task_use_case.dart
│       │       ├── delete_task_use_case.dart
│       │       ├── retrieve_tasks_use_case.dart
│       │       └── update_task_use_case.dart
│       └── presentation
│           ├── providers
│           │   ├── states
│           │   │   ├── tasks_notifier.dart
│           │   │   ├── tasks_state.dart
│           │   │   └── tasks_state.freezed.dart
│           │   └── tasks_providers.dart
│           ├── screens
│           │   └── tasks
│           │       └── tasks.dart
│           └── widgets
├── infrastructure
│   ├── either.dart
│   ├── exceptions
│   │   └── http_exception.dart
│   └── response.dart
├── main
│   ├── app.dart
│   ├── app_env.dart
│   └── observer.dart
├── main.dart
├── routes
│   ├── app_router.dart
│   └── app_router.gr.dart
└── shared
    └── use_case.dart
    ```