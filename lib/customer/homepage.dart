import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masken/customer/propertycard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.person),
          )],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
      
      ]),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "ابحث عن العقار الذي يناسب احتياجاتك",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Color(0xff052659)),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // search bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff052659)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            
            // property list
          Expanded(
            child:ListView( 
              children: [
             Propertycard(),
Propertycard(),
Propertycard()
            ],
            ), 
            )
          ],
        ),
      ),
    );
  }
}
