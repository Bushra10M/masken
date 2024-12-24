import 'package:flutter/material.dart';
import 'package:masken/welcome/signupA.dart';
import 'package:masken/welcome/signupC.dart';
import 'package:masken/components/fixedbackground.dart';

class Choosing extends StatelessWidget {
  const Choosing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FixedBackground(),
          SafeArea(
            child:  Padding(
              padding: const EdgeInsets.all(60),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed:(){ Navigator.pop(context);}, icon: const Icon(Icons.arrow_back ,color:  Colors.white,)),
                    const Text(
                      "إنشاء حساب جديد:",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Cairo",
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "أي نوع من الحسابات  تريد إنشاؤه؟",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(300.0, 80.0)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Signupa()));
                      },
                      child: const Text(
                        "مكتب عقارات",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xff052659),
                          fontFamily: 'Cairo',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(300.0, 80.0)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Signupc()));
                      },
                      child: const Text(
                        textDirection: TextDirection.rtl,
                        "عميل",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Color(0xff052659),
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
