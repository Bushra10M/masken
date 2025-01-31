import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/models/user_model.dart';

Future<UserModel?> fetchAgencyDetails(String agencyid) async {
  try {
    // جلب مستند الوكالة باستخدام agencyId من مجموعة agencies
    DocumentSnapshot agencyDoc = await FirebaseFirestore.instance
        .collection('agency') // تأكد من أن اسم المجموعة هنا هو 'agency'
        .doc(agencyid)
        .get();

    if (agencyDoc.exists) {
      // إذا تم العثور على الوكالة
      return UserModel.fromJson(agencyDoc.data() as Map<String, dynamic>);
    }

    // إذا لم يتم العثور على الوكالة في المجموعة
    return null;
  } catch (e) {
    print('Error fetching agency data: $e');
    return null;
  }
}
