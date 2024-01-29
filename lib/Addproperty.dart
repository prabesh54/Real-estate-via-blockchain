// AddPropertyPage.dart



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'VerificationSuccessPage.dart';

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

class AddPropertyPage extends StatefulWidget {
  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController propertyNumberController = TextEditingController();

  late ImagePicker _imagePicker;
  XFile? _userPhoto;
  XFile? _propertyPhoto;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(propertyNameController, 'Property Name'),
              _buildTextField(ownerNameController, 'Owner Name'),
              _buildTextField(countryController, 'Country'),
              _buildTextField(contactNumberController, 'Contact Number'),
              _buildTextField(propertyNumberController, 'Property Number'),
              _buildImagePicker('User Photo', _userPhoto, () => _pickImage(true)),
              _buildImagePicker('Property Photo', _propertyPhoto, () => _pickImage(false)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _registerProperty(context);
                },
                child: Text('Register Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildImagePicker(String label, XFile? imageFile, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label),
          SizedBox(height: 8),
          if (imageFile != null)
            Image.file(
              File(imageFile.path),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('Pick $label'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(bool isUserPhoto) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (isUserPhoto) {
          _userPhoto = pickedFile;
        } else {
          _propertyPhoto = pickedFile;
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _registerProperty(BuildContext context) async {
    UserProfile userProfile = UserProfile(
      userName: propertyNameController.text,
      ownerName: ownerNameController.text,
      country: countryController.text,
      contactNumber: contactNumberController.text,
      propertyNumber: propertyNumberController.text,
    ); 

    try {
      DocumentReference propertyRef = await FirebaseFirestore.instance.collection('properties').add({
        'userName': userProfile.userName,
        'ownerName': userProfile.ownerName,
        'country': userProfile.country,
        'contactNumber': userProfile.contactNumber,
        'propertyNumber': userProfile.propertyNumber,
      });

      int propertyHashCode = propertyRef.id.hashCode;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationSuccessPage(
            userName: userProfile.userName,
            ownerName: userProfile.ownerName,
            country: userProfile.country,
            contactNumber: userProfile.contactNumber,
            propertyNumber: userProfile.propertyNumber,
            propertyHashCode: propertyHashCode,
          ),
        ),
      );
    } catch (e) {
      print('Error saving property details: $e');
    }
  }
}
