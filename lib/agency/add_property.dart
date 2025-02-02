import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:masken/components/mytextfield.dart';

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
        String agencyid = user.uid;
        String propertyId =
            FirebaseFirestore.instance.collection('properties').doc().id;

        await FirebaseFirestore.instance
            .collection('properties')
            .doc(propertyId)
            .set({
          'id': propertyId, // تخزين الـ ID داخل المستند
          'title': titleController.text,
          'location': locationController.text,
          'price': '${priceController.text} د.ل',
          'description': descriptionController.text,
          'type': typeController.text,
          'status': statusController.text,
          'userId': user.uid,
          'agencyid': agencyid,
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
        priceController.text.isEmpty ||
        statusController.text.isEmpty) {
      _showErrorSnackBar('يرجى ملء الحقول الإلزامية');
      return false;
    }
    return true;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.right,  style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),),
        backgroundColor: const Color(0xff052659),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.right,  style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),),
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
    typeController.clear();
    statusController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageUploader(), // هنا إضافة العنصر
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            MyTextField(
                controller: titleController,
                hintText: ' * عنوان العقار',
                icon: Icons.title,
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[ء-يa-zA-Z\s]'))
                ]),

            const SizedBox(height: 15),
            MyTextField(
                controller: locationController,
                hintText: '* الموقع',
                icon: Icons.location_on,
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[ء-يa-zA-Z\s]'))
                ]),
            const SizedBox(height: 15),
            MyTextField(
                controller: typeController,
                hintText: 'نوع العقار',
                icon: Icons.home,
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[ء-يa-zA-Z\s]'))
                ]),
            const SizedBox(height: 15),
            MyTextField(
                controller: priceController,
                hintText: '* السعر',
                icon: Icons.attach_money,
                obscureText: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            const SizedBox(height: 15),
            MyTextField(
                controller: statusController,
                hintText: '* حالة العقار ( للإيجار ام للبيع )',
                icon: Icons.check_circle_outline,
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[ء-يa-zA-Z\s]'))
                ]),
            const SizedBox(height: 15),
            MyTextField(
                controller: descriptionController,
                hintText: 'الوصف',
                icon: Icons.description,
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[ء-يa-zA-Z\s]'))
                ]),

            const SizedBox(height: 30),

            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff052659), Color(0xff1A5F9F)],
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
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}

Widget _buildImageUploader() {
  return GestureDetector(
    onTap: () {
      // يمكنك إضافة وظيفة اختيار الصورة هنا لاحقًا
    },
    child: Container(
      height: 200,
      width: double.infinity,
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
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo_outlined,
            size: 50,
            color: Colors.white.withOpacity(0.8),
          ),
          const SizedBox(height: 15),
          Text(
            'إضافة صورة',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
