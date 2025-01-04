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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3)),
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
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    color: Color(0xff052659),
                    Icons.favorite_border,
                    size: 30,
                  ),
                  Text(
                    propertyModel.title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Color(0xff052659),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo'),
                  ),],
              ),
            ),
              //  const SizedBox(height: 10),
                Padding(
                   padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    propertyModel.price,
                     textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          color: Color(0xff052659),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    ),
                      Row(
                        children: [
                          Text(
                            propertyModel.location,
                             textDirection: TextDirection.rtl,
                          style: const TextStyle(
                              color: Color(0xff052659),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo'),
                          ),
                          SizedBox(width: 8,),
                            Icon(Icons.location_on_outlined,color: Color(0xff052659),size: 20,),
                        ],
                      ),
                  
                  
                              ],
                  ),
                ),  
          ],
        ),
      ),
    );
  }
}
