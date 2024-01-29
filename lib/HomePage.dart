import 'package:flutter/material.dart';

import 'login_page.dart';


class HorizontalMarqueeText extends StatefulWidget {
  final String text;

  HorizontalMarqueeText({required this.text});

  @override
  _HorizontalMarqueeTextState createState() => _HorizontalMarqueeTextState();
}

class _HorizontalMarqueeTextState extends State<HorizontalMarqueeText> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scroll();
  }

  void _scroll() {
    Future.delayed(Duration(seconds: 1), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 5),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ).createShader(bounds);
        },
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_balance,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Visit'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutMePage()),
                  );
                },
                child: Text('About Me'),
              ),
              SizedBox(height: 20),
              HorizontalMarqueeText(
                text: 'Empowering your real estate journey, one byte at a time ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('About Me'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance,
                size: 120,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to RealEstateApp!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Our Mission:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Revolutionizing real estate by providing a secure blockchain-based platform for managing property data.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Why Choose RealEstateApp?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                '• Blockchain Security: Your property data is stored securely on the blockchain, ensuring transparency and immutability.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '• User-Friendly Interface: Our app offers an intuitive and easy-to-use interface for a seamless experience.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '• Empowering Users: RealEstateApp empowers users by providing direct control and access to their property information.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Email: info@realestateapp.com',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
