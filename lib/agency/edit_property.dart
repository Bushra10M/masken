import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/components/mytextfield.dart';

class EditPropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  _EditPropertyScreenState createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // تعبئة الحقول بالبيانات الحالية
    titleController.text = widget.property.title;
    locationController.text = widget.property.location;
    priceController.text = widget.property.price;
    descriptionController.text = widget.property.description;
    typeController.text = widget.property.type;
    statusController.text = widget.property.status;
  }

  Future<void> updateProperty(String propertyId) async {
  try {
    if (propertyId.isEmpty) {
      _showErrorSnackBar('معرف العقار غير صالح');
      return;
    }

    if (_validateInputs()) {
      await FirebaseFirestore.instance.collection('properties').doc(propertyId).update({
        'title': titleController.text,
        'location': locationController.text,
        'price': priceController.text,
        'description': descriptionController.text,
        'type': typeController.text,
        'status': statusController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _showSuccessSnackBar('تم تعديل العقار بنجاح');
      Navigator.pop(context); // الرجوع بعد التحديث
    }
  } catch (e) {
    _showErrorSnackBar('خطأ أثناء تعديل العقار: $e');
  }
}
  bool _validateInputs() {
    if (titleController.text.isEmpty ||
        locationController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        typeController.text.isEmpty ||
        statusController.text.isEmpty) {
      _showErrorSnackBar('يرجى ملء جميع الحقول');
      return false;
    }
    return true;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            _buildSubmitButton(propertyId: widget.property.id),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton({required String propertyId}) {
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
        
       onPressed: () {
              // التحقق من أن المعرف ليس فارغًا
              if (widget.property.id.isNotEmpty) {
                updateProperty(widget.property.id);
              } else {
                _showErrorSnackBar('معرف العقار غير صالح');
              }
            },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'حفظ التعديلات',
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
