import 'package:flutter/material.dart';
import 'package:masken/agency/add_property.dart';
import 'package:masken/agency/agencyprofile.dart';
import 'package:masken/agency/agencyhome.dart';
import 'package:masken/components/drawer.dart';
import 'package:masken/agency/sms.dart'; // صفحة الرسائل

class AgencyHome extends StatefulWidget {
  const AgencyHome({super.key});

  @override
  State<AgencyHome> createState() => _AgencyHomeState();
}

class _AgencyHomeState extends State<AgencyHome> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Home(),
    const AddPropertyScreen(),
    const Sms(),
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
                  MaterialPageRoute(builder: (context) => const Agencyprofile()),
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
            icon: Icon(Icons.add_home),
            label: 'إضافة عقار',
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
