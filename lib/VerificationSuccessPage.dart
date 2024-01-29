// VerificationSuccessPage.dart

import 'package:flutter/material.dart';

class VerificationSuccessPage extends StatelessWidget {
  final String userName;
  final String ownerName;
  final String country;
  final String contactNumber;
  final String propertyNumber;
  final int propertyHashCode;

  VerificationSuccessPage({
    required this.userName,
    required this.ownerName,
    required this.country,
    required this.contactNumber,
    required this.propertyNumber,
    required this.propertyHashCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Successful'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.check_circle, // Checkmark icon for congratulations
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Your property registration was successful.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildDetailRow('User Name', userName),
            _buildDetailRow('Owner Name', ownerName),
            _buildDetailRow('Country', country),
            _buildDetailRow('Contact Number', contactNumber),
            _buildDetailRow('Property Number', propertyNumber),
            _buildDetailRow('Property Hash Code', propertyHashCode.toString()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}