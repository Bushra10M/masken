import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/agency/edit_property.dart';
import 'package:masken/customer/fav_provider.dart';
import 'package:masken/customer/propertydetail.dart';
import 'package:masken/models/property_model.dart';

class Propertycard extends StatefulWidget {
  final PropertyModel propertyModel;

  const Propertycard({super.key, required this.propertyModel});

  @override
  _PropertycardState createState() => _PropertycardState();
}

class _PropertycardState extends State<Propertycard> {
  bool isFavorite = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool isOwner = user != null && widget.propertyModel.agencyid == user!.uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PropertyDetails(propertyModel: widget.propertyModel),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      // صورة العقار
                     Container(
  height: 250,
  child: Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        widget.propertyModel.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
      ),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    ],
  ),
),
FavoriteButton(propertyId: widget.propertyModel.id),
                      // زر تعديل وحذف (يظهر فقط لصاحب العقار)
                      if (isOwner)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPropertyScreen(
                                        property: widget.propertyModel),
                                  ),
                                );
                              } else if (value == 'delete') {
                                _deleteProperty(context,widget.propertyModel.id);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('تعديل',style: TextStyle(fontFamily: 'Cairo'),textDirection: TextDirection.rtl,),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('حذف',style: TextStyle(fontFamily: 'Cairo'),textDirection: TextDirection.rtl,),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                          ),
                        ),
                    ],
                  ),

                  // معلومات العقار
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.propertyModel.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Color(0xff052659),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.propertyModel.price,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                color: Colors.green,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.propertyModel.location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // حذف العقار
  Future<void> _deleteProperty(BuildContext context, String propertyId) async {
    // عرض Dialog للتأكيد قبل الحذف
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف',style: TextStyle(fontFamily: 'Cairo'),textDirection: TextDirection.rtl,),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا العقار؟',style: TextStyle(fontFamily: 'Cairo'),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // إغلاق Dialog دون حذف
              },
              child: const Text('إلغاء',style: TextStyle(fontFamily: 'Cairo'),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // إغلاق Dialog مع تأكيد الحذف
              },
              child: const Text('تأكيد',style: TextStyle(fontFamily: 'Cairo'),),
            ),
          ],
        );
      },
    );

    // إذا قام المستخدم بتأكيد الحذف
    if (confirmDelete == true) {
      try {
        await FirebaseFirestore.instance
            .collection('properties')
            .doc(propertyId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حذف العقار بنجاح',style: TextStyle(fontFamily: 'Cairo'),)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ أثناء الحذف: $e',style: TextStyle(fontFamily: 'Cairo'),)),
        );
      }
    }
  }
}
