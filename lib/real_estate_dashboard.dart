import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/Addproperty.dart';
import 'package:real_estate/UserProfilePage.dart';


class Property {
  final String imageUrl;
  final String title;
  final String location;
  final HouseType houseType;

  Property({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.houseType,
  });
}

enum HouseType {
  Apartment,
  House,
  Condo,
  Villa,
  Other,
}

class RealEstateDashboard extends StatelessWidget {
  String userName = "John Doe";
  String ownerName = "Owner Name";
  String country = "Country";
  String contactNumber = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Property>>(
            future: _fetchPropertyData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No properties available.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var propertyData = snapshot.data![index];
                    return PropertyCard(
                      imageUrl: propertyData.imageUrl,
                      title: propertyData.title,
                      location: propertyData.location,
                      houseType: propertyData.houseType,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // Add your notification logic here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePage(
                              userName: userName,
                              ownerName: ownerName,
                              country: country,
                              contactNumber: contactNumber,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPropertyPage()),
                  );
                },
                child: Text('Property Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Property>> _fetchPropertyData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('properties').get();

      List<Property> propertyList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Property(
          imageUrl: data['imageUrl'] ?? '',
          title: data['title'] ?? '',
          location: data['location'] ?? '',
          houseType: _getHouseTypeFromString(data['houseType']),
        );
      }).toList();

      return propertyList;
    } catch (e) {
      print('Error fetching property data: $e');
      throw e;
    }
  }

  HouseType _getHouseTypeFromString(String houseTypeString) {
    switch (houseTypeString.toLowerCase()) {
      case 'apartment':
        return HouseType.Apartment;
      case 'house':
        return HouseType.House;
      case 'condo':
        return HouseType.Condo;
      case 'villa':
        return HouseType.Villa;
      default:
        return HouseType.Other;
    }
  }
}

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final HouseType houseType;

  PropertyCard({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.houseType,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData = _getIconDataFromHouseType(houseType);

    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(iconData),
                    SizedBox(width: 8.0),
                    Text(location),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconDataFromHouseType(HouseType houseType) {
    switch (houseType) {
      case HouseType.Apartment:
        return Icons.apartment;
      case HouseType.House:
        return Icons.home;
      case HouseType.Condo:
        return Icons.account_balance;
      case HouseType.Villa:
        return Icons.house;
      case HouseType.Other:
        return Icons.business;
    }
  }
}
