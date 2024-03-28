
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
import 'package:first_app/Time_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

Widget _buildMenuItem(BuildContext context, String imageUrl, String label) {
  return GestureDetector(
    onTap: () {
      // Add navigation logic here
    },
    child: Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl, // Provide the URL of the online image
            width: 180.0, // Set the desired width
            height: 160.0, // Set the desired height
          ),
          const SizedBox(height: 8.0),
          Text(label, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GalleryPage(),
    );
  }
}
class GalleryPage extends StatelessWidget {
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

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
        ),
        itemBuilder: (BuildContext context, int index) {
          // You can replace this with your image data or widgets
          return _buildMenuItem(
            context,
            'data:image/jpeg;base64,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', // Provide the URL of the online image
            'Item $index', // Replace with a meaningful label
          );
        },
      ),

















      drawer: Drawer(
        // Define your drawer content here
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue, // Set the background color to blue
              padding: EdgeInsets.all(18.0),
              child: Center(
                child: Column(
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


