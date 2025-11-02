import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/providers.dart';
import 'appbar.dart';
import 'app_pallete.dart';
import 'providers.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => CorrectProvider())],child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppPallete.primary,
        fontFamily: 'Fredoka',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(leading: Icon(Icons.home), title: Text('Home')),
              ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
            ],
          ),
        ),
        appBar: CustomAppbar(),
        extendBodyBehindAppBar: true,
        body: HomeScreen(),
      ),
    );
  }
}
