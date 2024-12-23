class propertyModel {
  final String title;
  final String location;
  final String type;
  final String price;
  final String status;
  final String description;
  final String agencyname;

  propertyModel({
    required this.title,
    required this.location,
    required this.type,
    required this.price,
    required this.status,
    required this.description,
    required this.agencyname,
  });
 propertyModel.fromJson(Map<String, dynamic> data)
      : title = data['title'] ?? '',
        location = data['location'] ?? '',
        type = data['type'] ?? '',
        price = data['price'] ?? '',
        status = data['status'] ?? '',
        description = data['description'] ?? '',
        agencyname = data['agencyname'] ?? '';
        


  Map<String, dynamic> toJson() => {
    'title' : title,
    'location': location,
    'type': type,
    'price' : price,
     'status': status,
    'description': description,
    'agencyname' : agencyname,

  };


}
