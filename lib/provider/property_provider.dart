import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masken/models/property_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<PropertyModel>> fetchProperties() async {
  try {
    QuerySnapshot querySnapshot =
        await _firestore.collection('properties').get();
    List<PropertyModel> properties = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return PropertyModel(
        id: doc.id,
        title: data['title'] ?? '',
        location: data['location'] ?? '',
        type: data['type'] ?? '',
        price: data['price'] ?? '',
        status: data['status'] ?? '',
        description: data['description'] ?? '',
        agencyid: data['agencyid'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
      );
    }).toList();

    return properties;
  } catch (error) {
    print('Error fetching properties: $error');
    return [];
  }
}
