import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget MyTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
    int maxLines = 1,
   required TextInputType keyboardType,
     required List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
       inputFormatters:inputFormatters, 
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'Cairo',
          color: const Color(0xff052659),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.grey[500],
          ),
          suffixIcon: Icon(
            icon,
            color: const Color(0xff052659).withOpacity(0.7),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
