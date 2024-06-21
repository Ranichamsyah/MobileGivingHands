import 'package:flutter/material.dart';
import 'chat_page.dart';

//warna utama aplikasi
final Color customBlue = Color(0xFF112C5A);


class ChatCategoryPage extends StatelessWidget {//menampilkan daftar kategori obrolan 
  final List<Map<String, dynamic>> _categories = [
    {//kategori berisi nama kategori dan icon
      'title': 'Volunteer Pecinta Alam',
      'icon': Icons.eco,
    },
    {
      'title': 'Volunteer Pecinta Anak-anak',
      'icon': Icons.child_friendly,
    },
    {
      'title': 'Volunteer Bantuan Medis',
      'icon': Icons.local_hospital,
    },
    {
      'title': 'Volunteer Kebersihan Lingkungan',
      'icon': Icons.cleaning_services,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(//struktur halaman chat
      appBar: AppBar(
          title: Text('Chat Community', style: TextStyle(color: Colors.white)), // Menambahkan properti warna putih di sini
        backgroundColor: customBlue,
      ),
      body: ListView.builder(//membuat daftar kategori obrolan berdasarkan item yang ada di daftar
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(//menavigasi kedalam room chat yang sesuai dengan kategori
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(chatRoomName: _categories[index]['title']),
                ),
              );
            },
            child: Card(//menampilkan item daftar dengan card
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color: customBlue,
              child: ListTile(//menampilkan icon dan nama kategori
                leading: Icon(_categories[index]['icon'], size: 40, color: Colors.white),
                title: Text(
                  _categories[index]['title'],
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}