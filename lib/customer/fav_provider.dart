import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteButton extends StatefulWidget {
  final String propertyId; // معرف العقار

  const FavoriteButton({Key? key, required this.propertyId}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // حالة المفضلة
  final userId = FirebaseAuth.instance.currentUser?.uid; // الحصول على ID المستخدم

  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // التحقق عند تحميل الأداة
  }

  // التحقق مما إذا كان العقار موجودًا في المفضلة
  void _checkIfFavorite() async {
    if (userId == null) return;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('clients') // مجموعة العملاء
        .doc(userId)
        .collection('favorites') // مجموعة المفضلة
        .doc(widget.propertyId) // معرف العقار
        .get();

    if (doc.exists) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  // إضافة أو إزالة العقار من المفضلة
 void _toggleFavorite() async {
  if (userId == null) return;

  try {
    final docRef = FirebaseFirestore.instance
        .collection('clients')
        .doc(userId)
        .collection('favorites')
        .doc(widget.propertyId);

    if (isFavorite) {
      await docRef.delete(); // حذف العقار من المفضلة
    } else {
      await docRef.set({
        'id': widget.propertyId, // استخدام 'id' بدلاً من 'propertyId'
        'timestamp': FieldValue.serverTimestamp(), // وقت الإضافة
      }); // إضافة العقار للمفضلة
    }

    setState(() {
      isFavorite = !isFavorite; // تحديث الحالة
    });
  } catch (e) {
    print("Error toggling favorite: $e"); // طباعة الخطأ في الكونسول
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("حدث خطأ أثناء إضافة أو إزالة المفضلة")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 15, // العلامة في الجهة العلوية اليسرى
      child: Container(
        width: 25, // حجم الدائرة
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5), // تقليل الشفافية
          shape: BoxShape.circle,
        ),
        child: IconButton(
          padding: EdgeInsets.zero, // إزالة المسافات حول الأيقونة
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border, // تغيير الأيقونة
            color: isFavorite ? Colors.red : const Color(0xff052659), // تغيير اللون
            size: 16, // حجم الأيقونة
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }
}
