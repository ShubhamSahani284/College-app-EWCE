import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/AnnouncementPage.dart';
import 'package:first_app/AssignmentPage.dart';
import 'package:first_app/AttendancePage.dart';
import 'package:first_app/CalendarPage.dart';
import 'package:first_app/FeePage.dart';
import 'package:first_app/GalleryPage.dart';
import 'package:first_app/ResultPage.dart';
import 'package:first_app/Time_table.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text("Name: Shubham Sahani"),
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
          Container(
              color: Colors.blue,
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/image/pass_BG.png'),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: Shubham Sahani',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'USN: 1EE20CS053',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Dept: CSE     Sem: 7th',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Phone: 8660805657',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Email: shubhamsahani284@gmail.com',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remove the student name text
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildMenuItem(context, Icons.attach_money, 'Fee'),
              _buildMenuItem(context, Icons.calendar_today, 'Attendance'),
              _buildMenuItem(context, Icons.schedule, 'Time Table'),
              _buildMenuItem(context, Icons.announcement, 'Announcement'),
              _buildMenuItem(context, Icons.assignment, 'Assignment'),
              _buildMenuItem(context, Icons.photo_library, 'Gallery'),
              _buildMenuItem(context, Icons.calendar_today, 'Calendar'),
              _buildMenuItem(context, Icons.insert_chart, 'Result'),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(18.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: 100.0,
                      height: 100.0,
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
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Fee'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeePage()),
                );
              },
            ),
            ListTile(
              title: Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendancePage()),
                );
              },
            ),
            ListTile(
              title: Text('Time Table'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Time_tablepage()),
                );
              },
            ),
            ListTile(
              title: Text('Announcement'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnnouncementPage()),
                );
              },
            ),
            ListTile(
              title: Text('Assignment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssignmentPage()),
                );
              },
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
            ),
            ListTile(
              title: Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            ListTile(
              title: Text('Result'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultPage()),
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
      if (label == 'Fee') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeePage()), // Navigate to FeePage
        );
      } else if (label == 'Result') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage()), // Navigate to ResultPage
        );
      } else if (label == 'Attendance') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendancePage()), // Navigate to AttendancePage
        );
      } else if (label == 'Time Table') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Time_tablepage()), // Navigate to AttendancePage
        );
      }else if (label == 'Announcement') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnnouncementPage()), // Navigate to AttendancePage
        );
      }
      else if (label == 'Assignment') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AssignmentPage()), // Navigate to AttendancePage
        );
      }
      else if (label == 'Gallery') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GalleryPage()), // Navigate to AttendancePage
        );
      }
      else if (label == 'Calendar') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage()), // Navigate to AttendancePage
        );
      }
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
