import 'package:flutter/material.dart';
import 'package:masken/customer/propertycard.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/provider/property_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PropertyModel> properties = []; // جميع العقارات
  List<PropertyModel> filteredProperties = []; // العقارات المصفاة للعرض
  bool isLoading = true; // حالة التحميل
  String searchQuery = ''; // النص المدخل في البحث

  @override
  void initState() {
    getData(); // جلب العقارات عند تشغيل الصفحة
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20.0),
            // حقل البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // تحديث النص المدخل
                    applySearch(); // تنفيذ البحث
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'ابحث هنا',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Cairo'),
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
            // الأقسام
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryPill('للبيع', false),
                  _buildCategoryPill('للإيجار', false),
                  _buildCategoryPill('الكل', true),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // قائمة العقارات
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : filteredProperties.isEmpty
                    ? const Center(
                        child: Text(
                          "لا توجد عقارات مطابقة للبحث",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: "Cairo"),
                        ),
                      )
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
      ),
    );
  }

  // جلب العقارات من المصدر
  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    properties = await fetchProperties(); // جلب جميع العقارات
    filteredProperties = properties; // عرض جميع العقارات مبدئيًا
    isLoading = false;
    setState(() {});
  }

  // تنفيذ البحث
   // تنفيذ البحث
  void applySearch() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredProperties = properties; // عرض جميع العقارات إذا كان البحث فارغًا
      } else {
        filteredProperties = properties.where((property) {
          final searchText = searchQuery.toLowerCase();

          final matchesLocation =
              property.location.toLowerCase().contains(searchText); // البحث في الموقع
          final matchesType =
              property.type.toLowerCase().contains(searchText); // البحث في النوع
          final matchesPrice = property.price
              .toString()
              .contains(searchText); // البحث في السعر كنص

          return matchesLocation || matchesType || matchesPrice;
        }).toList();
      }
    });
  }
}

// ويدجت التصميم للأقسام
Widget _buildCategoryPill(String text, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 7),
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
    decoration: BoxDecoration(
      color: isSelected ? const Color(0xff052659) : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: isSelected ? const Color(0xff052659) : Colors.grey[300]!),
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
