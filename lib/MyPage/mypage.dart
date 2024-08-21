import 'package:flutter/material.dart';
import 'package:aipet/Utility/http.dart';
import 'package:aipet/Utility/typedefinition.dart';

/// The main page of the application, displaying user information.
class MyPage extends StatelessWidget {
  final myuser = fetchUserData("");
  
  MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Optional: Add padding for better layout
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
          children: <Widget>[
            UserProfile(user: myuser), // Display user profile (avatar and name)
            const SizedBox(height: 20), // Add spacing between profile and details
            UserDetails(user: myuser), // Display user details (email and buttons)
          ],
        ),
      ),
    );
  }
}

/// A widget to display the user's profile, including avatar and name.
class UserProfile extends StatelessWidget {
  final User user;

  const UserProfile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 50, // Set the size of the avatar
          backgroundImage: NetworkImage(user.avatarUrl), // Load the avatar image from the URL
        ),
        const SizedBox(width: 10), // Add spacing between avatar and name
        Text(
          user.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Style the name text
        ),
      ],
    );
  }
}

/// A widget to display the user's details, including email and action buttons.
class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
      children: <Widget>[
        Text(
          user.email,
          style: const TextStyle(fontSize: 16, color: Colors.grey), // Style the email text
        ),
        const SizedBox(height: 20), // Add spacing between email and buttons
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()), // Navigate to SettingsPage
            );
          },
          child: const Text('Settings'), // Button text
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PetPage()), // Navigate to PetPage
            );
          },
          child: const Text('PetPage'), // Button text
        ),
        // Add more elements here as needed
      ],
    );
  }
}

/// A placeholder page for settings.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')), // App bar title
      body: const Center(child: Text('Settings Page')), // Page content
    );
  }
}

/// A placeholder page for pet information.
class PetPage extends StatelessWidget {
  const PetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Page')), // App bar title
      body: const Center(child: Text('Pet Page')), // Page content
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPage(), // Set MyPage as the home page of the app
  ));
}