import 'package:flutter/material.dart';
import 'package:masken/models/property_model.dart';
import 'package:masken/models/user_model.dart';
import 'package:masken/provider/agency_provider.dart';

class PropertyDetails extends StatefulWidget {
  final PropertyModel propertyModel;

  const PropertyDetails({super.key, required this.propertyModel});

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  late UserModel agency;
 bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    _fetchAgencyDetails();
  }

  Future<void> _fetchAgencyDetails() async {
    agency = (await fetchAgencyDetails(widget.propertyModel.agencyid))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (agency == null) {
      return Scaffold(
        appBar: AppBar(
  title: const Text(
    "تفاصيل العقار",
    style: TextStyle(
      fontFamily: 'Cairo', // استخدام خط Cairo
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    textDirection: TextDirection.rtl, // محاذاة النص لليمين
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff052659),
          Color(0xff1A5F9F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),
      );
    }

    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "تفاصيل العقار",
    style: TextStyle(
      fontFamily: 'Cairo', 
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    textDirection: TextDirection.rtl, // محاذاة النص لليمين
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff052659),
          Color(0xff1A5F9F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // صورة العقار
            ClipRRect(
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
  child: Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        widget.propertyModel.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
      ),
      Container(
        decoration: BoxDecoration(
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
    ],
  ),),
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
                  ),]),),),
              const SizedBox(height: 20),

              // عنوان العقار
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Text(
                      widget.propertyModel.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color(0xff052659),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                 
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // وصف العقار
              Text(
                widget.propertyModel.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  color:  Color(0xff052659),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // السعر
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.propertyModel.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                    ),
                  ), 
                  const SizedBox(width: 8),
                  const Text(
                    ": السعر",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.attach_money, color:  Color(0xff052659), size: 22),
                  
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // الموقع
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.propertyModel.location,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    ": الموقع",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      color: Color(0xff052659),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.location_on, color:  Color(0xff052659), size: 22),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // حالة العقار
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.propertyModel.status,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    ": الحالة",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                    ),
                  ),
                  const SizedBox(width: 8),
                    const Icon(Icons.info_outline, color:  Color(0xff052659), size: 22),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // بيانات الوكالة
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff052659),
                      const Color(0xff1A5F9F),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      
                        Text(
                          agency.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                      
                        const SizedBox(width: 8),
                        const Text(
                          ": اسم الوكالة",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.business, color: Colors.white, size: 22),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.white54),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       
                        Text(
                          agency.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        const Text(
                          ": رقم هاتف الوكالة",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                         const Icon(Icons.phone, color: Colors.white, size: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
           ), ],
                ),
              ),
        ),
      )
    ;
  }
}
