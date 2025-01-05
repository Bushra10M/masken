class UserModel {
   final String userId; 
  final String email;
  final String location;
  final String name;
  final String phoneNumber;

  UserModel(
      {
      required this.userId,
      required this.email,
      required this.location,
      required this.name,
      required this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> data)
      :
      userId = data['userId'] ?? '',
       email = data['email'] ?? '',
        name = data['name'] ?? '',
        location = data['location'] ?? '',
        phoneNumber = data['phoneNumber'] ?? '';

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email' : email,
    'name': name,
    'location': location,
    'phoneNumber' : phoneNumber,
  };
}
