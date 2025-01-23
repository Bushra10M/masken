import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/models/property_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<List<PropertyModel>> fetchagencyProperties(String agencyid) async {
  List<PropertyModel> properties = [];
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('properties') // اسم المجموعة في فايربيز
        .where('agencyid', isEqualTo: agencyid) // تصفية بناءً على agencyId
        .get();

    properties = snapshot.docs
        .map((doc) => PropertyModel.fromJson(doc.data()))
        .toList();
  } catch (e) {
    print('Error fetching properties: $e');
  }
  return properties;
}
