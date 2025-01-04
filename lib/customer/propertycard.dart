import 'package:flutter/material.dart';
import 'package:masken/models/property_model.dart';

class Propertycard extends StatelessWidget {
  final PropertyModel propertyModel;

  const Propertycard({super.key, required this.propertyModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color:Colors.white
         , boxShadow: [
            BoxShadow(
           color: Colors.grey.shade200,
           spreadRadius: 2,
           blurRadius: 5,
           offset: const Offset(0, 3)
          ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
                // image: const DecorationImage(
                //   image: NetworkImage(''),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Row(
             // crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  propertyModel.title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Color(0xff052659),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  propertyModel.location,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  propertyModel.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
