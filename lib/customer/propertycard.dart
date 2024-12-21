import 'package:flutter/material.dart';

class Propertycard extends StatelessWidget {
  const Propertycard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff052659),
        ),
        child: Column(
          children: [
          Container( 
        height: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(''),
            fit: BoxFit.cover,
          ),
        ),
          ),
           Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "location",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("price",
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
