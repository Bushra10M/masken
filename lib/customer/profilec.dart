import 'package:flutter/material.dart';
import 'package:masken/models/user_model.dart';
import 'package:masken/provider/user_provider.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'بيانات المستخدم',
          style: TextStyle(
            fontFamily: 'Cairo',
            color:  const Color(0xff052659),
            
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xff1A5F9F),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color:  Color(0xff052659),
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ أثناء جلب البيانات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color:  Color(0xff052659),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_off_outlined,
                    color: Colors.grey,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد بيانات للمستخدم',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color:Color(0xff052659),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          final user = snapshot.data!;

          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: const Color(0xff1A5F9F), // لون البطاقة
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff052659),
                            const Color(0xff1A5F9F),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    UserInfoRow(
                      icon: Icons.person_outline,
                      label: 'الاسم',
                      value: user.name,
                    ),
                    Divider(
                      height: 20, 
                      color: Colors.white.withOpacity(0.3),
                      indent: 20,
                      endIndent: 20,
                    ),
                    UserInfoRow(
                      icon: Icons.email_outlined,
                      label: 'البريد الإلكتروني',
                      value: user.email,
                    ),
                    Divider(
                      height: 20, 
                      color: Colors.white.withOpacity(0.3),
                      indent: 20,
                      endIndent: 20,
                    ),
                    UserInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'رقم الهاتف',
                      value: user.phoneNumber,
                    ),
                  ],
                ),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon, 
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}