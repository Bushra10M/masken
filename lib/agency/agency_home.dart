import 'package:flutter/material.dart';
import 'package:masken/agency/add_property.dart';
import 'package:masken/agency/agencyprofile.dart';
import 'package:masken/components/drawer.dart';
import '';
class AgencyHome extends StatefulWidget {
  const AgencyHome({super.key});

  @override
  State<AgencyHome> createState() => _AgencyHomeState();
}

class _AgencyHomeState extends State<AgencyHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            drawer: MyDrawer(
        
      ),
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
                          builder: (context) => const Agencyprofile()));
                },
                icon: const Icon(color: Color(0xff052659), Icons.person),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff052659),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sms),
            label: '',
          )
        ],
      ),
      body:  SafeArea(
              child: TextButton(
                          style:
                              TextButton.styleFrom(foregroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPropertyScreen()));
                          },
                          child: const Text(
                            "اضافة عقار ",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
            ),
    );
  }
}
