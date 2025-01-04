import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masken/agency/agency_home.dart';
import 'package:masken/components/mytextfield.dart';
import 'package:masken/components/fixedbackground.dart';
import 'package:masken/customer/homepage.dart';
import 'package:masken/models/user_model.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim());

      final user = await loadUsers(email: usernameController.text.trim());
      if (user == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AgencyHome()));
      } else if (user == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  const HomePage()));
        print('He is not an agency');
      } else {
        print('caanot login');
      }
    } catch (e) {
      print(e.toString());
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
                    'تسجيل الدخول الى حسابك :',
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
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff052659),
                        minimumSize: const Size(300.0, 60.0)),
                    onPressed: () async {
                      await signIn(context);
                    },
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "or continue with",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("images/google-icon.png"),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage("images/facebook-logo.png"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<int> loadUsers({required String email}) async {
    try {
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      int level = 0;
      final querSnaphot = await fireStore.collection('agency').get();

      List<UserModel> users = querSnaphot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.email == email)
          .toList();

      if (users.isEmpty) {
        final querSnaphot = await fireStore.collection('clients').get();

        users = querSnaphot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .where((user) => user.email == email)
            .toList();
        level = 2;
      } else {
        level = 1;
      }
      return level;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }
}
