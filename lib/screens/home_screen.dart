import 'package:flutter/material.dart';
import 'package:quiz_app/appfonts.dart';
import 'package:quiz_app/loading.dart';
import 'package:quiz_app/widgets/gradient_button.dart';
import 'package:quiz_app/widgets/home_bar.dart';
import '../appbar.dart';
import '../auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void _signOut() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Home')),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            const Divider(),
            // ADDED THIS:
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: _signOut, // Call the sign out method
            ),
          ],
        ),
      ),
      appBar: CustomAppbar(),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          HomeBar(),
          Spacer(),
          Container(
            height: height * 0.5,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get Started", style: Appfonts.subheading),
                SizedBox(height: height * 0.01),
                Text(
                  "Test your knowledge with our exciting quizzes! Challenge yourself and learn new things every day.",
                  style: Appfonts.smallbodybold,
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: GradientButton(
                    buttontext: "Start Quiz",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Loading()),
                      );
                    },
                    dimensions: {
                      'width': width > height && width > 600
                          ? 300
                          : width * 0.8,
                    },
                    icon: Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ), // Your original home screen
    );
  }
}
