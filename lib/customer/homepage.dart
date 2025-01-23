import 'package:flutter/material.dart';
// استيراد النموذج الخاص بالعقار
import 'package:masken/models/property_model.dart';
// استيراد الويدجت الخاص ببطاقة العقار
import 'package:masken/customer/propertycard.dart';
// استيراد البروفايدر لجلب البيانات
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
  String selectedCategory = 'الكل'; // الفئة المختارة (الكل، للبيع، للإيجار)

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
                  _buildCategoryPill('للبيع', selectedCategory == 'للبيع'),
                  _buildCategoryPill('للإيجار', selectedCategory == 'للإيجار'),
                  _buildCategoryPill('الكل', selectedCategory == 'الكل'),
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
    applySearch(); // تصفية العقارات بناءً على البحث والفئة
    isLoading = false;
    setState(() {});
  }

  // تنفيذ البحث والتصفية بناءً على الفئة
  void applySearch() {
    setState(() {
      List<PropertyModel> filteredByCategory;
      if (selectedCategory == 'الكل') {
        filteredByCategory = properties; // عرض الجميع
      } else {
        filteredByCategory = properties
            .where((property) => property.status == selectedCategory)
            .toList();
      }

      if (searchQuery.isEmpty) {
        filteredProperties = filteredByCategory;
      } else {
        filteredProperties = filteredByCategory.where((property) {
          final searchText = searchQuery.toLowerCase();

          final matchesLocation = property.location
              .toLowerCase()
              .contains(searchText); // البحث في الموقع
          final matchesStatus = property.status
              .toLowerCase()
              .contains(searchText); // البحث في الحالة
          final matchesPrice = property.price
              .toString()
              .contains(searchText); // البحث في السعر كنص

          return matchesLocation || matchesStatus || matchesPrice;
        }).toList();
      }
    });
  }

  // ويدجت التصميم للأقسام
  Widget _buildCategoryPill(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text; // تحديث الفئة المختارة
          applySearch(); // تطبيق الفلترة
        });
      },
      child: Container(
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
      ),
    );
  }
}
