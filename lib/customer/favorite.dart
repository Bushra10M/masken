import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/customer/propertycard.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<PropertyModel> favoriteProperties = [];
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadFavoriteProperties();
  }

  // دالة لتحميل العقارات المفضلة من Firestore
Future<void> _loadFavoriteProperties() async {
  final user = _auth.currentUser;
  if (user == null) {
    setState(() {
      isLoading = false;
    });
    return;
  }

  try {
    // جلب العقارات المفضلة من مجموعة favorites الخاصة بالمستخدم
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('clients')
        .doc(user.uid)
        .collection('favorites')
        .get();

    List<PropertyModel> properties = [];
    for (var doc in snapshot.docs) {
      var propertyId = doc['id'];
      var propertySnapshot = await FirebaseFirestore.instance
          .collection('properties')
          .doc(propertyId)
          .get();

      if (propertySnapshot.exists) {
        // استخدام fromJson لتحويل بيانات Firestore إلى PropertyModel مع تحديد الـ id يدويًا
        var propertyData = propertySnapshot.data()!;
        propertyData['id'] = propertySnapshot.id; // إضافة الـ id في الـ JSON
        properties.add(PropertyModel.fromJson(propertyData));
      }
    }

    setState(() {
      favoriteProperties = properties;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print("Error loading favorites: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null, // إزالة الـ AppBar
        body: isLoading
            ? const Center(child: CircularProgressIndicator()) // عرض مؤشر التحميل
            : favoriteProperties.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Colors.grey, // يمكن تغيير اللون حسب الحاجة
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          textDirection: TextDirection.rtl,
                          'لا توجد عقارات مفضلة.',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Cairo',
                            color: Colors.grey, // استخدام اللون الرمادي للنص
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: favoriteProperties.length,
                    itemBuilder: (context, index) {
                      return Propertycard(
                        propertyModel: favoriteProperties[index],
                      );
                    },
                  ),
      ),
    );
  }
}
