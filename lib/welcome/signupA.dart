import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masken/agency/agency_home.dart';
import 'package:masken/components/fixedbackground.dart';
import 'package:masken/models/user_model.dart';
import 'package:masken/helper/helperfun.dart';
import 'package:masken/welcome/login.dart';
import 'package:masken/components/mytextfield.dart';

class Signupa extends StatefulWidget {
  const Signupa({super.key});

  @override
  State<Signupa> createState() => _SignupaState();
}

class _SignupaState extends State<Signupa> {
  final agencynameController = TextEditingController();

  final phoneNumController = TextEditingController();

  final locationController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

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
          location: locationController.text,
          name: agencynameController.text,
          phoneNumber: phoneNumController.text,
        );
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        addUser(userModel: userModel);
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

  Future<bool> addUser({required UserModel userModel}) async {
    try {
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      await fireStore.collection('agency').add(userModel.toJson());
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
                  IconButton(onPressed:(){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back ,color:  Colors.white,)),
                  const Text(
                    'إنشاء حساب مكتب عقارات:',
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
                      controller: agencynameController,
                      hintText: "أسم الوكالة العقارية",
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: phoneNumController,
                      hintText: "رقم الهاتف",
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: locationController,
                      hintText: "موقع الوكالة",
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "البريد الالكتروني",
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: passwordController,
                      hintText: "كلمة المرور",
                      obscureText: true),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: "تأكيد كلمة المرور",
                      obscureText: true),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff052659),
                        minimumSize: const Size(300.0, 60.0)),
                    onPressed: registerUser,
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
