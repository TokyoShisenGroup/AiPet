import 'package:flutter/material.dart';
import 'MyPage/mypage.dart';
import 'AuthPage/login_page.dart';
import 'Utility/typedefinition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aipet/ChatPage/chat_list_page.dart';
import 'package:aipet/PetPage/pet_management_page.dart'; // Import the pet management page
import 'package:aipet/PostPage/post_list_page.dart'; // Import the post list page

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
      home: const LoginPage(), // 启动时直接导航到登录页面
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
    _loadUser();
    _widgetOptions = <Widget>[
      ChatListPage(),
      PetManagementPage(),
      const Center(
          child: Text('Profile Page')), // Placeholder for profile until login
    ];
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final avatarUrl = prefs.getString('avatarUrl');

    if (name != null && email != null && avatarUrl != null) {
      setState(() {
        _user = User(name: name, email: email, avatarUrl: avatarUrl);
        _widgetOptions[2] = MyPage(user: _user!, onLogout: _logout);
      });
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    ChatListPage(),
    PetManagementPage(), // Add the pet management page
    PostListPage(), // Add the post list page
    MyPage(),
  ];


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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('name', result['name']);
      await prefs.setString('email', result['email']);
      await prefs.setString('avatarUrl', result['avatarUrl']);

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

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _user = null;
      _widgetOptions[2] =
          const Center(child: Text('Profile Page')); // Reset to placeholder
      _selectedIndex = 0; // Optionally, switch back to the first tab
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('AiPet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
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
            icon: Icon(Icons.post_add),
            label: 'Posts', // Add the posts label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
