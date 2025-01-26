import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/customer/propertycard.dart';
import 'package:masken/provider/property_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PropertyModel> properties = [];
  List<PropertyModel> filteredProperties = [];
  bool isLoading = true;
  String searchQuery = '';
  String selectedCategory = 'الكل';

  @override
  void initState() {
    // Set status bar style to match the design
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Subtle background color
      body: SafeArea(
        child: Column(
          children: [
            // Animated Header with Elevation Effect
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              decoration: BoxDecoration(),
              child: const Text(
                "ابحث عن العقار الذي يناسب احتياجاتك",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Color(0xff052659),
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Improved Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      applySearch();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'ابحث هنا',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle:
                        TextStyle(color: Colors.grey[500], fontFamily: 'Cairo'),
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: const Color(0xff052659).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category Selection
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

            // Property List
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xff052659).withOpacity(0.7),
                      ),
                    ),
                  )
                : filteredProperties.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            Text(
                              "لا توجد عقارات مطابقة للبحث",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: "Cairo",
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
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

  // Existing methods remain the same
  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    properties = await fetchProperties();
    applySearch();
    isLoading = false;
    setState(() {});
  }

  void applySearch() {
    setState(() {
      List<PropertyModel> filteredByCategory;
      if (selectedCategory == 'الكل') {
        filteredByCategory = properties;
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

          final matchesLocation =
              property.location.toLowerCase().contains(searchText);
          final matchesStatus =
              property.status.toLowerCase().contains(searchText);
          final matchesPrice = property.price.toString().contains(searchText);

          return matchesLocation || matchesStatus || matchesPrice;
        }).toList();
      }
    });
  }

  // ويدجت التصميم للأقسام (unchanged)
  Widget _buildCategoryPill(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
          applySearch();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    const Color(0xff052659),
                    const Color(0xff1A5F9F),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
