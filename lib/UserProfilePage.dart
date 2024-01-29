import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String userName;
  final String ownerName;
  final String country;
  final String contactNumber;

  UserProfilePage({
    required this.userName,
    required this.ownerName,
    required this.country,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Name: $userName'),
            Text('Owner Name: $ownerName'),
            Text('Country: $country'),
            Text('Contact Number: $contactNumber'),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
class UserProfile {
  final String userName;
  final String ownerName;
  final String country;
  final String contactNumber;
  final String propertyNumber;

  UserProfile({
    required this.userName,
    required this.ownerName,
    required this.country,
    required this.contactNumber,
    required this.propertyNumber,
  });
}

