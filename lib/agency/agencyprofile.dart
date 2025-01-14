import 'package:flutter/material.dart';
import 'package:masken/models/user_model.dart';
import 'package:masken/provider/user_provider.dart';
class Agencyprofile extends StatelessWidget {
  const Agencyprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'بيانات المستخدم',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel?>(
          future: getUserData(), // دالة لجلب بيانات المستخدم
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // أثناء تحميل البيانات
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // إذا حدث خطأ أثناء جلب البيانات
              return const Center(child: Text('حدث خطأ أثناء جلب البيانات'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              // إذا لم يتم العثور على بيانات للمستخدم
              return const Center(child: Text('لا توجد بيانات للمستخدم'));
            }

            // عرض البيانات إذا كانت متوفرة
            final user = snapshot.data!;

            return Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xff052659),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    UserInfoRow(
                      icon: Icons.person_outline,
                      label: 'الاسم',
                      value: user.name ,
                    ),
                     UserInfoRow(
                      icon: Icons.email_outlined,
                      label: 'البريد الإلكتروني',
                      value: user.email,
                    ),
                     UserInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'رقم الهاتف',
                      value: user.phoneNumber,
                    ),
                      UserInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'موقع المكتب ',
                      value: user.location,
                    ),
                  ],
                ),
              ),
            );
          },
          ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const UserInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Icon(icon, color: const Color(0xff052659)),
        ],
      ),
    );
  }
}
