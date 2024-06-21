import 'package:flutter/material.dart';

class BiodataPage extends StatelessWidget {
  final String nama;
  final String npm;
  final String programStudi;
  final String email;
  final String noTelp;
  final String imagePath;
  final String alamat;
  final String tanggalLahir;
  final String jenisKelamin;

  const BiodataPage({
    required this.nama,
    required this.npm,
    required this.programStudi,
    required this.email,
    required this.noTelp,
    required this.imagePath,
    required this.alamat,
    required this.tanggalLahir,
    required this.jenisKelamin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF112C5A),
        iconTheme: IconThemeData(color: Colors.white), // Set icon theme to white
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112C5A),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'UPN "Veteran" Jawa Timur',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildDetailCard(Icons.account_circle, 'NPM', npm),
            SizedBox(height: 10),
            _buildDetailCard(Icons.school, 'Program Studi', programStudi),
            SizedBox(height: 10),
            _buildDetailCard(Icons.email, 'Email', email),
            SizedBox(height: 10),
            _buildDetailCard(Icons.phone, 'Nomor Telepon', noTelp),
            SizedBox(height: 10),
            _buildDetailCard(Icons.home, 'Alamat', alamat),
            SizedBox(height: 10),
            _buildDetailCard(Icons.calendar_today, 'Tanggal Lahir', tanggalLahir),
            SizedBox(height: 10),
            _buildDetailCard(Icons.wc, 'Jenis Kelamin', jenisKelamin),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600]),
            SizedBox(width: 10),
            Text(
              '$label: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
