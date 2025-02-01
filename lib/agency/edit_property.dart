import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/models/property_model.dart';

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
      appBar: AppBar(title: Text('تعديل العقار')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'العنوان')),
            TextField(controller: locationController, decoration: InputDecoration(labelText: 'الموقع')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'السعر')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'الوصف')),
            TextField(controller: typeController, decoration: InputDecoration(labelText: 'النوع')),
            TextField(controller: statusController, decoration: InputDecoration(labelText: 'الحالة')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => updateProperty(widget.property.id),
              child: const Text('حفظ التعديلات'),
            ),
          ],
        ),
      ),
    );
  }
}
