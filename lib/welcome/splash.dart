import 'package:flutter/material.dart';
import 'package:masken/welcome/choosing.dart';
import 'package:masken/welcome/login.dart';
import 'signupC.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/House.jfif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF052659).withOpacity(0.5),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 25.0,
                  ),
                  child: const Text(
                    "مَسكن",
                    style: TextStyle(
                      fontFamily: 'El Messiri',
                      color: Colors.white,
                      fontSize: 55.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "اختيارات متنوعة من العقارات في متناول يديك",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 520.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(379.0, 78.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
                    "تسجيل دخول",
                    style: TextStyle(
                      color: Color(0xff052659),
                      fontFamily: 'Cairo',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Choosing()));
                      },
                      child: const Text(
                        "إنشاء حساب جديد",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "ليس لديك حساب؟",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
