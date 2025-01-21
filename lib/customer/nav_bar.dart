import 'package:flutter/material.dart';
import 'package:masken/agency/agencyprofile.dart';
import 'package:masken/components/drawer.dart';
import 'package:masken/customer/favorite.dart';
import 'package:masken/customer/homepage.dart';
import 'package:masken/customer/message.dart'; // صفحة الرسائل

class NavBarC extends StatefulWidget {
  const NavBarC({super.key});

  @override
  State<NavBarC> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarC> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Favorite(),
    const Messagescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Agencyprofile()),
                );
              },
              icon: const Icon(color: Color(0xff052659), Icons.person),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: 25,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff052659),
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'المفضلة ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sms),
            label: 'الرسائل',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
