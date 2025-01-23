import 'package:flutter/material.dart';
import 'package:masken/models/property_model.dart';

class Propertycard extends StatelessWidget {
  final PropertyModel propertyModel;

  const Propertycard({super.key, required this.propertyModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3)),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة وعلامة المفضلة
            Stack(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                    // إضافة الصورة هنا:
                    // image: DecorationImage(
                    //   image: NetworkImage(propertyModel.imageUrl),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15, // العلامة في الجهة العلوية اليسرى
                  child: Container(
                    width: 25, // حجم الدائرة
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5), // تقليل الشفافية
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero, // إزالة المسافات حول الأيقونة
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Color(0xff052659),
                        size: 16, // حجم الأيقونة
                      ),
                      onPressed: () {
                        // وظيفة عند الضغط على علامة المفضلة
                      },
                    ),
                  ),
                ),
              ],
            ),
            // اسم العقار أسفل الصورة في الجهة اليمنى
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 5),
                  child: Text(
                    propertyModel.title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Color(0xff052659),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // السعر والموقع
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    propertyModel.price,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        propertyModel.location,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
