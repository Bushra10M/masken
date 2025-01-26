import 'package:flutter/material.dart';
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
