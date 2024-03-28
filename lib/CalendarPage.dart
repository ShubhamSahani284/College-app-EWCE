import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Home.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_app/AnnouncementPage.dart';
import 'package:first_app/AssignmentPage.dart';
import 'package:first_app/AttendancePage.dart';
import 'package:first_app/FeePage.dart';
import 'package:first_app/GalleryPage.dart';
import 'package:first_app/ResultPage.dart';
import 'package:first_app/Time_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student name'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              selectedDayPredicate: (day) {
                // Use `==` to determine if it's the selected day.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            // Add your events or custom calendar content below
          ],
        ),
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

