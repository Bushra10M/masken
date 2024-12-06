import 'package:flutter/material.dart';
import 'package:masken/components/mytextfield.dart';
import 'package:masken/welcome/login.dart';

class Signupc extends StatelessWidget {
  Signupc({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/House.jfif"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: const Color(0xFF052659).withOpacity(0.5),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'إنشاء حساب عميل:',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                MyTextField(
                    controller: usernameController,
                    hintText: "Your Name",
                    obscureText: false),
                    const SizedBox(height: 15.0,),
                 MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                    const SizedBox(height: 15.0,),
                 MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),
                    const SizedBox(height: 15.0,),
                 MyTextField(
                    controller: confirmpasswordController,
                    hintText: "Confirm Yuor Password",
                    obscureText: true),
                    const SizedBox(height: 20.0,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff052659),
                      minimumSize: const Size(300.0, 60.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
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
