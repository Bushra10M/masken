import 'package:flutter/material.dart';
import 'package:masken/components/mytextfield.dart';
class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle image picking logic
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_rounded,color:Colors.grey)
                        ,Text(
                        'إضافة صورة',
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),]
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: titleController,
                hintText: 'عنوان العقار',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: locationController,
                hintText: 'الموقع',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: typeController,
                hintText: 'نوع العقار',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: priceController,
                hintText: 'السعر',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: statusController,
                hintText: 'حالة العقار',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: descriptionController,
                hintText: 'الوصف',
                obscureText: false,
              ),
             
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Color(0xff052659),
                ),
                child: const Text(
                  'إضافة العقار',
                  style: TextStyle(fontFamily: "Cairo", fontSize: 18,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
