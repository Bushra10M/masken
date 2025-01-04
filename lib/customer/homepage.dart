import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masken/customer/propertycard.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/provider/property_provider.dart';
import 'profilec.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PropertyModel> properties = [];
  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
       backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ClientProfile()));
                },
                icon: const Icon(color: Color(0xff052659),Icons.person),
          )
      )],
      ),
      bottomNavigationBar: CurvedNavigationBar(
animationDuration: Duration(milliseconds: 300),
        color: Color(0xff052659),
        backgroundColor: Colors.white,
        items: [
         Icon(color: Colors.white,Icons.home),
        Icon(color: Colors.white,Icons.favorite),

      ],),
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
            const SizedBox(
              height: 15,
            ),

            // property list
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          return Propertycard(
                            propertyModel: properties[index],
                          );
                        })),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    properties = await fetchProperties();
    isLoading = false;
    setState(() {});
  }
}
