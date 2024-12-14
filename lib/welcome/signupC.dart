import 'package:flutter/material.dart';
import 'package:masken/components/mytextfield.dart';
import 'package:masken/customer/homepage.dart';
import 'package:masken/components/fixedbackground.dart';
class Signupc extends StatelessWidget {
  Signupc({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
      children: [
        const FixedBackground(),
          SafeArea(
            child: 
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'إنشاء حساب عميل:',
                  textDirection: TextDirection.rtl,
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
                        MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    "إنشاء الحساب",
                     textDirection: TextDirection.rtl,
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
      ],
      ),
    );
  }
}
