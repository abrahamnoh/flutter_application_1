🐻 Animated Login Screen with Rive
Welcome to the repository for my animated login screen project! This application showcases how to integrate Rive animations into a Flutter app to create a dynamic and engaging user interface. The teddy bear character reacts to user input, making the login experience more interactive and fun. 


✨ Features
Interactive Animation: The Rive character responds to user actions in real-time.

Dynamic Reactions:

The bear peeks when the user types in the email field. 👀

It covers its eyes when the password field is selected. 🙈

It celebrates with a success animation for correct credentials. 🎉

It shows a sad animation for incorrect credentials. 😢

Password Visibility: Users can toggle the visibility of the password.

Responsive UI: The layout is designed to adapt to different screen sizes.


❓ What are Rive and State Machines?
Rive
Rive is a powerful design and animation tool that allows you to create interactive vector animations. These animations can be integrated into apps, websites, and games, and they can be controlled with code. Unlike static formats like GIFs, Rive animations are lightweight and can be manipulated at runtime.

State Machine
A State Machine is a feature within Rive that allows you to define different states and transitions for an animation. Instead of just playing an animation from beginning to end, you can create complex logic. For example, you can switch between states like "idle," "typing," "success," and "fail" based on user input, just like in this project!

🛠️ Technologies Used
Flutter: The UI toolkit used to build the application.

Dart: The programming language for Flutter.

Rive: The tool and runtime for the interactive animations.

Visual Studio Code: The code editor used for development.


📂 Project Structure
The main logic of the application is located in the lib folder. Here is a brief overview of the key file:

main.dart: This file is the entry point of the application. It sets up the app and launches the login screen.

login_screen.dart: This is the core file for the login page. It contains all the UI elements and the logic for controlling the Rive animation through a StateMachineController. It manages the bear's reactions based on which TextField is focused and what the user types.



// lib/login_screen.dart

// Rive animation controller
StateMachineController? controller;

// State Machine Inputs for animations

SMIBool? isChecking;

SMIBool? isHandsUp;

SMITrigger? trigSuccess;

SMITrigger? trigFail;

SMINumber? numLook;


🚀 Demo
Here is a GIF showing the complete functionality of the app. Watch how the bear reacts to different user interactions!

![2025-09-18 17-04-12](https://github.com/user-attachments/assets/5c2139d7-39e3-43bf-98f0-6fb6134a984f)

🎓 Course Information Course Name: [mobile application programming]

Professor's Name: [Rodrigo Fidel Gaxiola Sosa]

🙏 Credits A huge thank you to the creator of the amazing Rive animation used in this project.

Animation: Remix of Login Machine By: JcToon
