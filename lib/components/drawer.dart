import 'package:flutter/material.dart';
import 'package:masken/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onSignOut;
  const MyDrawer({super.key,required this.onSignOut });

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
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
             onTap: onSignOut,
             ),

        ],
      ),
    );
  }
}
