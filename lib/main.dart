import 'package:flutter/material.dart';
import 'MyPage/mypage.dart';
import 'ChatPage/chat_list_page.dart';
import 'PetPage/pet_management_page.dart';
import 'AuthPage/login_page.dart';
import 'Utility/typedefinition.dart';
import 'package:flutter/material.dart';
import 'MyPage/mypage.dart';
import 'ChatPage/chat_list_page.dart';
import 'PetPage/pet_management_page.dart';
import 'AuthPage/login_page.dart';
import 'Utility/typedefinition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AiPet',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyBottomNavigationBarApp(),
    );
  }
}

class MyBottomNavigationBarApp extends StatelessWidget {
  const MyBottomNavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyBottomNavigationBar();
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  User? _user; // Variable to track the logged-in user

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      ChatListPage(),
      PetManagementPage(),
      const Center(
          child: Text('Profile Page')), // Placeholder for profile until login
    ];
  }

  void _onItemTapped(int index) {
    if (index == 2 && _user == null) {
      _navigateToLogin(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _navigateToLogin(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );

    if (result != null) {
      setState(() {
        _user = User(
          name: result['name'],
          email: result['email'],
          avatarUrl: result['avatarUrl'],
        );
        _widgetOptions[2] = MyPage(user: _user!, onLogout: _logout);
        _selectedIndex = 2;
      });
    }
  }

  void _logout() {
    setState(() {
      _user = null;
      _widgetOptions[2] =
          const Center(child: Text('Profile Page')); // Reset to placeholder
      _selectedIndex = 0; // Optionally, switch back to the first tab
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyBottomNavigationBarApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiPet'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
