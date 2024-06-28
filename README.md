#Shop Management App
Overview
The Shop Management App is a Flutter-based application designed for managing products and orders effectively. It utilizes Firebase services for backend operations including authentication, storage, and Firestore for real-time data management.

Features
Login and Signup: Secure authentication using Firebase Authentication.
Dashboard View: Provides insights such as total orders, today's orders, and today's order amount.
Products List: Displays a list of products with options to add new products and update their status.
Orders List: Lists all orders with functionalities for creation, status updates, and filtering.
Order Creation: Allows users to create new orders, select products, and specify details like customer information and order type.
Order Status Update: Enables updating order status (pending, completed, cancelled) via interactive dialogs.
Filtering: Filters available for both products and orders based on various criteria.
Technologies Used
Flutter: Framework for building cross-platform applications.
Firebase Authentication: Secure user authentication.
Firebase Storage: Cloud storage for storing images and files.
Firestore: Real-time database for managing product and order data.
Getting Started
To get started with the Shop Management App, follow these steps:

Clone the repository:

bash
Copy code
git clone https://github.com/mirza-d3x/shop_management_app.git
Navigate to the project directory:

bash
Copy code
cd shop_management_app
Install dependencies:

arduino
Copy code
flutter pub get
Configure Firebase:

Set up Firebase project in the Firebase Console (https://console.firebase.google.com/).
Add your Firebase configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) to the project under android/app and ios/Runner directories respectively.
Enable Firebase Authentication, Firestore, and Firebase Storage in your Firebase project.
Run the application:

arduino
Copy code
flutter run
