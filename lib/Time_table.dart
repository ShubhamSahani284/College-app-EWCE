import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/CalendarPage.dart';
import 'package:first_app/Home.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:first_app/AnnouncementPage.dart';
import 'package:first_app/AssignmentPage.dart';
import 'package:first_app/AttendancePage.dart';
import 'package:first_app/FeePage.dart';
import 'package:first_app/ResultPage.dart';
import 'package:first_app/GalleryPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Time_tablepage(),
    );
  }
}

class Time_tablepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // Menu Icon
              onPressed: () {
                // Handle menu action
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text("Shubham Sahani"), // App Name
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Sign out the user from Firebase
              await FirebaseAuth.instance.signOut();

              // Clear the login state in shared preferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);

              // Clear any user-related data or state (you may need to add this part)
              // For example, if you have user-specific data in a provider, reset it here

              // Navigate to the login page and remove back navigation history
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false, // This clears the navigation stack
              );
            },
          )
        ],
      ),


      body: ListView(
        children: [
          ListTile(
            title: Text('Time table of the 7th sem'),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          Container(
            width: 120.0, // Set the desired width for the image
            height: 420.0, // Set the desired height for the image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/7th sem.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Add more list items as needed
        ],
      ),

      drawer: Drawer(
        // Define your drawer content here
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue, // Set the background color to blue
              padding: EdgeInsets.all(18.0),
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160.0,
                      height: 180.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    const Text('East west', style: TextStyle(fontSize: 18.0)),
                    const Text('College of engineering', style: TextStyle(fontSize: 18.0)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Fee'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeePage()), // Navigate to FeePage
                );
              },
            ),

            ListTile(
              title: Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendancePage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Time Table'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Time_tablepage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Announcement'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnnouncementPage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Assignment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssignmentPage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()), // Navigate to FeePage
                );
              },
            ),
            ListTile(
              title: Text('Result'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultPage()), // Navigate to FeePage
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
Widget _buildMenuItem(BuildContext context, IconData icon, String label) {
  return GestureDetector(
    onTap: () {
      // Add navigation logic here
    },
    child: Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.0),
          const SizedBox(height: 8.0),
          Text(label, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    ),
  );
}

