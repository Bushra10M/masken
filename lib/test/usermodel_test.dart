import 'package:flutter_test/flutter_test.dart';
import 'package:masken/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('UserModel constructor initializes correctly', () {
      final user = UserModel(
        userId: '123',
        email: 'test@example.com',
        location: 'Tripoli',
        name: 'Bushra ',
        phoneNumber: '09123456',
      );

      expect(user.userId, '123');
      expect(user.email, 'test@example.com');
      expect(user.location, 'Tripoli');
      expect(user.name, 'Bushra');
      expect(user.phoneNumber, '09123456');
    });

    test('UserModel.fromJson initializes correctly from JSON', () {
      final json = {
        'userId': '123',
        'email': 'test@example.com',
        'name': 'Bushra',
        'location': 'Tripoli',
        'phoneNumber': '09123456',
      };

      final user = UserModel.fromJson(json);

      expect(user.userId, '123');
      expect(user.email, 'test@example.com');
      expect(user.location, 'Tripoli');
      expect(user.name, 'Bushra');
      expect(user.phoneNumber, '09123456');
    });

    test('UserModel.toJson converts correctly to JSON', () {
      final user = UserModel(
        userId: '123',
        email: 'test@example.com',
        location: 'New York',
        name: 'John Doe',
        phoneNumber: '1234567890',
      );

      final json = user.toJson();

      expect(json['userId'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['location'], 'New York');
      expect(json['name'], 'John Doe');
      expect(json['phoneNumber'], '1234567890');
    });

    test('UserModel.fromJson handles missing keys with default values', () {
      final json = {
        'userId': '123',
        'email': 'test@example.com',
        // missing location, name, phoneNumber
      };

      final user = UserModel.fromJson(json);

      expect(user.userId, '123');
      expect(user.email, 'test@example.com');
      expect(user.location, ''); // القيمة الافتراضية للحقل المفقود
      expect(user.name, ''); // القيمة الافتراضية للحقل المفقود
      expect(user.phoneNumber, ''); // القيمة الافتراضية للحقل المفقود
    });
  });
}
