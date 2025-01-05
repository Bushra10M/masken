import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masken/models/user_model.dart';

Future<String?> getCurrentUserId() async {
  try {
    User? user = FirebaseAuth.instance.currentUser; // الحصول على المستخدم الحالي
    return user?.uid; // إرجاع الـ UID إذا كان المستخدم مسجل الدخول
  } catch (e) {
    print('Error getting current user: $e');
    return null;
  }
}
Future<UserModel?> getUserData() async {
  try {
    String? userId = await getCurrentUserId(); // جلب userId من FirebaseAuth
    if (userId == null) {
      return null; // إذا لم يكن المستخدم مسجل الدخول
    }

    // جلب بيانات المستخدم من Firestore باستخدام userId
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('clients') // اسم المجموعة
        .doc(userId) // معرف المستخدم
        .get();

    if (userDoc.exists) {
      return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } else {
      return null; // إذا لم يتم العثور على بيانات للمستخدم
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
