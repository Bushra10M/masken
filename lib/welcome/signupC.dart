import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masken/components/mytextfield.dart';
import 'package:masken/components/fixedbackground.dart';
import 'package:masken/models/user_model.dart';
import 'package:masken/helper/helperfun.dart';
import 'package:masken/welcome/login.dart';

class Signupc extends StatefulWidget {
  const Signupc({super.key});

  @override
  State<Signupc> createState() => _SignupcState();
}

class _SignupcState extends State<Signupc> {
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
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
            userId: '', 
            email: emailController.text,
            location: '',
            name: usernameController.text,
            phoneNumber:phoneNumberController.text
            );
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

   if (userCredential != null) {
        // الحصول على userId من Firebase Authentication بعد التسجيل الناجح
        String userId = userCredential.user!.uid;

        // بناء نموذج المستخدم مع userId
        final UserModel userModel = UserModel(
          userId: userId,  // تعيين userId من FirebaseAuth
          email: emailController.text.trim(),
          location: '', // المكان يمكن أن يتم تحديده لاحقًا
          name: usernameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
        );

        // إضافة بيانات المستخدم إلى Firestore باستخدام الـ userId
        bool success = await addUser(usermodel: userModel);

        if (success) {
          // إذا تم إضافة البيانات بنجاح، انتقل إلى شاشة تسجيل الدخول
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        } else {
          // إذا فشل إضافة البيانات
          Navigator.pop(context);
          displayMessageTouser('Failed to add user data to Firestore', context);
        }
      }
    } on FirebaseAuthException catch (e) {
      // في حالة حدوث خطأ أثناء التسجيل
      Navigator.pop(context);
      displayMessageTouser(e.code, context);
    }
  }
}


  Future<bool> addUser({required UserModel usermodel}) async {
    try {
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    // await fireStore.collection('clients').add(usermodel.toJson());
       await fireStore.collection('clients').doc(usermodel.userId).set(usermodel.toJson());
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
                  IconButton(onPressed:(){ Navigator.pop(context);}, icon: const Icon(Icons.arrow_back ,color:  Colors.white,)),
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
                      hintText: "أسم المستخدم",
                        icon: Icons.person_outlined,
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                 
                  MyTextField(
                      controller: phoneNumberController,
                      hintText: "رقم الهاتف",
                        icon: Icons.phone_outlined,
                      obscureText: false),
                      const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "البريد الالكتروني",
                       icon: Icons.email_outlined,
                      obscureText: false),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: passwordController,
                      hintText: "كلمة المرور",
                        icon: Icons.lock_outline,
                      obscureText: true),
                  const SizedBox(
                    height: 15.0,
                  ),
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: "تأكيد كلمة المرور",
                       icon: Icons.lock_reset_rounded,
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
