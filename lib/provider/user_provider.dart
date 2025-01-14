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

    // جلب البيانات من المجموعتين
    // المحاولة الأولى: clients
    DocumentSnapshot clientDoc = await FirebaseFirestore.instance
        .collection('clients')
        .doc(userId)
        .get();

    if (clientDoc.exists) {
      // إذا تم العثور على المستخدم في clients
      return UserModel.fromJson(clientDoc.data() as Map<String, dynamic>);
    }

    // المحاولة الثانية: agencies
    DocumentSnapshot agencyDoc = await FirebaseFirestore.instance
        .collection('agency')
        .doc(userId)
        .get();

    if (agencyDoc.exists) {
      // إذا تم العثور على المستخدم في agencies
      return UserModel.fromJson(agencyDoc.data() as Map<String, dynamic>);
    }

    // إذا لم يتم العثور على المستخدم في أي من المجموعتين
    return null;
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
