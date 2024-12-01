import 'package:flutter/material.dart';
import 'package:masken/welcome/choosing.dart';
import 'package:masken/welcome/login.dart';
class Signupa extends StatelessWidget {
  const Signupa({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/House.jfif"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Color(0xFF052659).withOpacity(0.5),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'إنشاء حساب مكتب عقارات:',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 370.0,
                  height: 70.0,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Agency Name"),
                  ),
                ),
                SizedBox(
                  width: 370.0,
                  height: 75.0,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "phone number"),
                  ),
                ),
                SizedBox(
                  width: 370.0,
                  height: 70.0,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "location"),
                  ),
                ),
                SizedBox(
                  width: 370.0,
                  height: 75.0,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "email"),
                  ),
                ),
                 SizedBox(
                  width: 370.0,
                  height: 75.0,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "password"),
                  ),
                ),
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff052659),
                      minimumSize: Size(350.0, 70.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "إنشاء الحساب",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  
