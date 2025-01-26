import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController agencyNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  Future<void> addProperty() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('المستخدم غير مسجل الدخول');
        return;
      }

      if (_validateInputs()) {
        String agencyId = user.uid;

        await FirebaseFirestore.instance.collection('properties').add({
          'title': titleController.text,
          'location': locationController.text,
          'price': priceController.text,
          'description': descriptionController.text,
          'agencyName': agencyNameController.text,
          'type': typeController.text,
          'status': statusController.text,
          'userId': user.uid,
          'agencyId': agencyId,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _showSuccessSnackBar('تم إضافة العقار بنجاح');
        _clearControllers();
      }
    } catch (e) {
      _showErrorSnackBar('خطأ أثناء إضافة العقار: $e');
    }
  }

  bool _validateInputs() {
    if (titleController.text.isEmpty ||
        locationController.text.isEmpty ||
        priceController.text.isEmpty) {
      _showErrorSnackBar('يرجى ملء الحقول الإلزامية');
      return false;
    }
    return true;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff052659),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearControllers() {
    titleController.clear();
    locationController.clear();
    priceController.clear();
    descriptionController.clear();
    agencyNameController.clear();
    typeController.clear();
    statusController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff052659),
              const Color(0xff1A5F9F),
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.2, 0.2, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'إضافة عقار جديد',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Text Fields
                        _buildTextField(
                          controller: titleController,
                          hintText: 'عنوان العقار *',
                          icon: Icons.title,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: locationController,
                          hintText: 'الموقع *',
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: typeController,
                          hintText: 'نوع العقار',
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: priceController,
                          hintText: 'السعر *',
                          icon: Icons.attach_money,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: statusController,
                          hintText: 'حالة العقار',
                          icon: Icons.check_circle_outline,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          controller: descriptionController,
                          hintText: 'الوصف',
                          icon: Icons.description,
                          maxLines: 3,
                        ),

                        const SizedBox(height: 30),

                        // Submit Button
                        _buildSubmitButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field with Modern Design
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'Cairo',
          color: const Color(0xff052659),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.grey[500],
          ),
          suffixIcon: Icon(
            icon,
            color: const Color(0xff052659).withOpacity(0.7),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // Submit Button
  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff052659),
            const Color(0xff1A5F9F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: addProperty,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'إضافة العقار',
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}