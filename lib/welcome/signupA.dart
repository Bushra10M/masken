import 'package:flutter/material.dart';
import 'package:masken/components/fixedbackground.dart';
import 'package:masken/welcome/login.dart';
import 'package:masken/components/mytextfield.dart';
class Signupa extends StatelessWidget {
   Signupa({super.key});
  final agencynameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
      children: [
        FixedBackground(),
          SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'إنشاء حساب مكتب عقارات:',
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
                    controller: agencynameController,
                    hintText: "Agency Name",
                    obscureText: false),
                    const SizedBox(height: 15.0,),
                 MyTextField(
                    controller: phoneNumController,
                    hintText: "Your Phone Number",
                    obscureText: false),
                    const SizedBox(height: 15.0,),
                 MyTextField(
                    controller: locationController,
                    hintText: "Agency Location",
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
                    hintText: "Confirm Your Password",
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
      ],
        ),
      );
  }
}
