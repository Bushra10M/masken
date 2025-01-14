import "package:flutter/material.dart";
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // الحقول
  String? _title;
  String? _location;
  String? _type;
  String? _status;
  String? _description;
  double? _price;
  File? _imageFile;

  // القوائم المنسدلة
  final List<String> _types = ['شقة', 'فيلا', 'أرض', 'مكتب'];
  final List<String> _statuses = ['إيجار', 'بيع'];

  Future<void> _addProperty() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      _formKey.currentState!.save();

      try {
        // رفع الصورة إلى Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask =
            _storage.ref('property_images/$fileName').putFile(_imageFile!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // إضافة البيانات إلى Firestore
        await _firestore.collection('properties').add({
          'title': _title,
          'location': _location,
          'type': _type,
          'price': _price,
          'status': _status,
          'description': _description,
          'imageUrl': imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تمت إضافة العقار بنجاح!')),
        );

        // تفريغ الحقول بعد الإضافة
        _formKey.currentState!.reset();
        setState(() {
          _type = null;
          _status = null;
          _imageFile = null;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $error')),
        );
      }
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار صورة للعقار!')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة عقار جديد', style: TextStyle(fontFamily: 'Cairo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // صورة العقار
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                      image: _imageFile != null
                          ? DecorationImage(
                              image: FileImage(_imageFile!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imageFile == null
                        ? Center(
                            child: Text(
                              'اختر صورة العقار',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 16),

                // اسم العقار
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'اسم العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم العقار';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                SizedBox(height: 16),

                // موقع العقار
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'موقع العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال موقع العقار';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _location = value;
                  },
                ),
                SizedBox(height: 16),

                // نوع العقار
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'نوع العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  items: _types
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type, style: TextStyle(fontFamily: 'Cairo')),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                  value: _type,
                  validator: (value) =>
                      value == null ? 'يرجى اختيار نوع العقار' : null,
                ),
                SizedBox(height: 16),

                // حالة العقار
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'حالة العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  items: _statuses
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status, style: TextStyle(fontFamily: 'Cairo')),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                  value: _status,
                  validator: (value) =>
                      value == null ? 'يرجى اختيار حالة العقار' : null,
                ),
                SizedBox(height: 16),

                // السعر
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'سعر العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال سعر العقار';
                    }
                    if (double.tryParse(value) == null) {
                      return 'يرجى إدخال رقم صالح';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.tryParse(value!);
                  },
                ),
                SizedBox(height: 16),

                // الوصف
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'وصف العقار',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                  ),
                  maxLines: 3,
                  onSaved: (value) {
                    _description = value;
                  },
                ),
                SizedBox(height: 24),

                // زر الإضافة
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addProperty,
                    child: Text('إضافة العقار', style: TextStyle(fontFamily: 'Cairo')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





