import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masken/components/drawer.dart';
import 'package:masken/customer/favorite.dart';
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
      drawer: MyDrawer(
        
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClientProfile()));
                },
                icon: const Icon(color: Color(0xff052659), Icons.person),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff052659),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sms),
            label: '',
          )
        ],
      ),
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
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'ابحث هنا',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Cairo'),
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff052659)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Category Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryPill('منزل', false),
                  _buildCategoryPill('فيلا', false),
                  _buildCategoryPill('شقة', false),
                  _buildCategoryPill('الكل', true),
                ],
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

Widget _buildCategoryPill(String text, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 7),
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
    decoration: BoxDecoration(
      color: isSelected ? Color(0xff052659) : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: isSelected ? Color(0xff052659)! : Colors.grey[300]!),
    ),
    child: Text(
      text,
      style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontWeight: FontWeight.w500,
          fontFamily: "Cairo"),
    ),
  );
}
