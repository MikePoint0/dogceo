# **DogCEO**

A comprehensive Flutter application for displaying dog breeds and related information.

## **Overview**

This project showcases various Flutter functionalities and capabilities, including API integration, state management using Bloc, real-time connectivity handling, and responsive UI. Below is a detailed list of the features implemented in this app.

**Functionalities & Capabilities**

    Splash Screen:
        Displays an introductory splash screen when the app starts.

    Fetch Dog Breeds from API:
        Fetches a list of dog breeds from the Dog CEO API.

    Display Dog Breeds in Accordion:
        The main page displays the fetched dog breeds in an expandable list (accordion).

    Accordion Response:
        Each accordion (breed) can expand and collapse to show or hide sub-breeds.
        Only one accordion can be expanded at a time, closing others automatically.

    Navigate to Details Page:
        Each breed or sub-breed can be clicked to navigate to a details page showing breed information.

    Fetch and Display Random Dog Image:
        The details page fetches and displays a random image of the selected breed or sub-breed using the Dog CEO API.

    Offline Mode Handling:
        Detects if the device is offline and navigates to an "Offline Page" with a message to reconnect to the internet.

    Real-time Internet Connectivity Detection:
        Monitors the device's internet connectivity and responds in real time, navigating to the offline page if the internet connection is lost.

    Double Back to Exit:
        Implements a feature where the user needs to press back twice to exit the application.

    Error Handling for API Failures:
        Displays a user-friendly error message if the dog breeds or images fail to load due to API errors.

    Light/Dark Mode Support:
        Automatically adapts to the system-wide light/dark mode.
        The app has a customized theme for both light and dark modes.

    Custom Color Scheme:
        Uses a consistent color scheme with deep purple as the base color.
        Custom fonts and colors applied across all pages.

    Custom Font Integration:
        Uses the Roboto font (or any other custom font) for consistent typography across the app.

    Responsive UI with ScreenUtil:
        Ensures the app is responsive across different screen sizes using the ScreenUtil package for adaptive font sizes and spacing.

    Expandable List with Sub-Breed Detection:
        Detects and displays sub-breeds within each breed’s accordion.
        If a breed has no sub-breeds, it shows "No sub-breeds."

    Auto-Capitalization of Breed and Sub-Breed Names:
        Capitalizes the first letter of each word in the breed and sub-breed names.

    Loading Indicators:
        Displays loading spinners while the data is being fetched from the API on both the main and details pages.

    Navigation Stack Management:
        Ensures proper navigation stack management to avoid memory leaks, especially when navigating between online and offline modes.

    Bloc State Management:
        Uses Bloc for managing the app's state, especially for fetching and displaying data from the API.

    Provider for Dependency Injection:
        Uses Provider for dependency injection, making API services and other objects available across the app.

    Custom Error Messages:
        Provides clear and custom error messages when API requests fail or when there is no internet connection.

    Dynamic Fetching Based on Connectivity:
        Only fetches data from the API if there is internet connectivity, otherwise directs users to the offline page.

    Page Routing with Named Routes:
        Implements named routes for navigation between splash screen, main page, details page, and offline page.

    Graceful Handling of No Sub-Breeds:
        Gracefully handles cases where a breed has no sub-breeds and displays an appropriate message.

**Setup Instructions**
To set up and run the DogCEO app, follow these steps:
    Clone the repository:
    
        git clone https://github.com/your-repo-url/dogceo.git
        cd dogceo

        Install dependencies: Ensure that you have Flutter installed. Then, run:

        flutter pub get

        Run the application: Run the app on an emulator or physical device using the following command:

        flutter run

        Running tests: To run the test cases, use the following command:

        flutter test

**Dependencies**
 
The DogCEO app relies on the following Flutter dependencies:

    flutter_bloc: Bloc state management package.

    provider: For dependency injection.

    http: To make network requests to the Dog CEO API.

    connectivity_plus: To detect internet connectivity.

    flutter_screenutil: For responsive design.

    fluttertoast: To display toast messages.

    mockito: For unit testing with mock objects.

    rxdart: To manage streams in testing and bloc handling.

These dependencies are defined in the pubspec.yaml file and are automatically installed when you run flutter pub get.
Architecture

The DogCEO app follows a clean and scalable architecture using the Bloc pattern for state management. Here’s a brief overview:
Layers:

    Data Layer:
        This layer contains the DogApiService, which handles all the API requests made to the Dog CEO API. It fetches the list of dog breeds and random images for the selected breed.

    Business Logic Layer:
        The business logic is handled by the Bloc. The DogBloc manages the state of the application and responds to user interactions (e.g., fetching breeds, navigating to the details page).

    Presentation Layer:
        The UI is built using Flutter widgets and includes the SplashScreen, MainPage, DetailsPage, and OfflinePage.
        It uses BlocBuilder to listen to state changes from the DogBloc and updates the UI accordingly.

    Dependency Injection:
        The Provider package is used for dependency injection, allowing services like the DogApiService and DogBloc to be accessed across the app.

    State Management:
        The Bloc pattern is used for managing application state. All UI components react to the DogBloc state changes via BlocBuilder, ensuring a clear separation of concerns.

**Summary:**

    The DogCEO app utilizes Bloc for predictable and testable state management.

    Provider is used for dependency injection to make API services easily accessible throughout the app.

    FlutterScreenUtil ensures that the UI is responsive across a variety of device sizes.

    ConnectivityPlus detects real-time network changes, and the app handles offline mode gracefully with custom error messages.

This architecture provides a clean and maintainable structure, making it easier to scale and extend the app in the future.
Further Comments

The DogCEO app is designed with a focus on modularity, testability, and responsiveness. All core functionalities such as API fetching, error handling, and real-time connectivity are implemented with performance and user experience in mind. The combination of Bloc, Provider, and FlutterScreenUtil ensures that the app runs smoothly across different device sizes and conditions.