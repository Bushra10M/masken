import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masken/agency/agency_property.dart';
import 'package:masken/customer/propertycard.dart';
import 'package:masken/models/property_model.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PropertyModel> properties = [];
  List<PropertyModel> filteredProperties = [];
  bool isLoading = true;
  @override
  void initState() {
    getData(); //
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Column(
      children: [
        isLoading
            ? Center(child: CircularProgressIndicator()) // عرض مؤشر تحميل
            : filteredProperties.isEmpty
                ? Center(child: Text('لا توجد عقارات متاحة للعرض'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredProperties.length,
                      itemBuilder: (context, index) {
                        return Propertycard(
                          propertyModel: filteredProperties[index],
                        );
                      },
                    ),
                  ),
      ],
    ),
  );
}


 

Future<void> getData() async {
  isLoading = true;
  setState(() {});

  try {
    // الحصول على user.uid كمصدر للـ agencyId
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول.');
    }

    String agencyid = user.uid; // استخدم user.uid كـ agencyId

    // جلب العقارات بناءً على agencyId
    properties = await fetchagencyProperties(agencyid);

    // تخصيص العقارات حسب الحاجة
    filteredProperties = properties;
  } catch (e) {
    print('خطأ أثناء جلب البيانات: $e');
    // يمكن عرض رسالة خطأ للمستخدم هنا
  } finally {
    isLoading = false;
    setState(() {});
  }
}


}
