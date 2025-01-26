import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/models/property_model.dart';

Future<List<PropertyModel>> fetchagencyProperties(String agencyid) async {
  List<PropertyModel> properties = [];
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('properties')
        .where('agencyid', isEqualTo: agencyid)
        .get();

    properties = snapshot.docs
        .map((doc) => PropertyModel.fromJson(doc.data(), )) // تمرير doc.id
        .toList();
  } catch (e) {
    print('Error fetching properties: $e');
  }
  return properties;
}
