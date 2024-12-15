import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masken/components/mytextfield.dart';
import 'package:masken/customer/homepage.dart';
import 'package:masken/components/fixedbackground.dart';
import 'package:masken/customer/user_model.dart';
import 'package:masken/helper/helperfun.dart';
import 'package:masken/welcome/login.dart';

class Signupc extends StatefulWidget {
  Signupc({super.key});

  @override
  State<Signupc> createState() => _SignupcState();
}

class _SignupcState extends State<Signupc> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();
  final phoneNumber = TextEditingController();

  void registerUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
// make sure paasword match
    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);
      displayMessageTouser("password don't match", context);
    } else {
      // create the user
      try {
        final UserModel userModel = UserModel(
            email: emailController.text,
            location:  '',
            name:  usernameController.text,
            phoneNumber: ' phoneNumber.text');
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        addUser(usermodel :userModel );
        //pop loading circle
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageTouser(e.code, context);
      }
    }
  }

  Future<bool> addUser({required UserModel usermodel}) async {
    try {
      final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
      await _fireStore.collection('clients').add(usermodel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FixedBackground(),
          SafeArea(
            child: Padding(
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
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: "Confirm Yuor Password",
                      obscureText: true),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff052659),
                        minimumSize: const Size(300.0, 60.0)),
                    onPressed: () {
                      registerUser();
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
