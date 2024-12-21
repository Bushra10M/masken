import 'package:flutter/material.dart';

class Propertydetail extends StatelessWidget {
  final String title;
  final String location;
  final String type;
  final String price;
  final String status;
  final String description;
  final String agencyname;

  const Propertydetail({
Key?key,
required this.title,
required this.location,
required this.type,
required this.price,
required this.status,
required this.description,
required this.agencyname,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
