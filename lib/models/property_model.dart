class PropertyModel {
 // معرف العقار
  final String title;
  final String location;
  final String type;
  final String price;
  final String status;
  final String description;
  final String agencyid;
  final String imageUrl;

  PropertyModel({
   
    required this.title,
    required this.location,
    required this.type,
    required this.price,
    required this.status,
    required this.description,
    required this.agencyid,
    required this.imageUrl,
  });

  PropertyModel.fromJson(Map<String, dynamic> data)
      : 
        title = data['title'] ?? '',
        location = data['location'] ?? '',
        type = data['type'] ?? '',
        price = data['price'] ?? '',
        status = data['status'] ?? '',
        description = data['description'] ?? '',
        agencyid = data['agencyid'] ?? '',
        imageUrl = data['imageUrl'] ?? '';

  Map<String, dynamic> toJson() => {
   
        'title': title,
        'location': location,
        'type': type,
        'price': price,
        'status': status,
        'description': description,
        'agencyId': agencyid,
        'imageUrl': imageUrl,
      };
}
