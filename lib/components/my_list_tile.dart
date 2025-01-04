import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTile({super.key, required this.icon , required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        
      leading: Icon(icon, color: const Color(0xff052659),),
      onTap: onTap,
      title: Text(
        text,
        style: const TextStyle(
      color: Color(0xff052659),
      fontFamily: 'Cairo',
      fontSize: 15,
      
        ),
      ),
      
      ),
    );

  }
}
