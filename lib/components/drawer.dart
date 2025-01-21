import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masken/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
 
   const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              color: Color(0xff052659),
              Icons.person,
              size: 80,
            ),
          ),
          MyListTile(
            icon: Icons.home,
            text: "الصفحة الرئيسية",
            onTap: () => Navigator.pop(context),
          ),
          MyListTile(
            icon: Icons.power_settings_new,
            text: "تسجيل الخروج",
            onTap:(){}
          ),
        ],
      ),
    );
  }
}
