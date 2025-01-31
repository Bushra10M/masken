import 'package:flutter/material.dart';
import 'package:masken/customer/favorite.dart';
import 'package:masken/customer/propertydetail.dart';

import 'package:masken/models/property_model.dart';

class Propertycard extends StatefulWidget {
  final PropertyModel propertyModel;

  const Propertycard({super.key, required this.propertyModel});

  @override
  _PropertycardState createState() => _PropertycardState();
}

class _PropertycardState extends State<Propertycard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
         onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetails(propertyModel: widget.propertyModel),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image with gradient and favorite button
                  Stack(
                    children: [
                      // Property Image with Gradient
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            // image: NetworkImage(widget.propertyModel.imageUrl),
                            //fit: BoxFit.cover,
                            // ),
                            ),
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Favorite Button
                      Positioned(
                        top: 16,
                        right: 16,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : const Color(0xff052659),
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Property Details
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.propertyModel.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Color(0xff052659),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.propertyModel.price,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                color: Colors.green,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.propertyModel.location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
