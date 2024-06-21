import 'package:flutter/material.dart'; //import package flutter

class ConfirmationPage extends StatelessWidget { //buat class konfirmasi bayar
  final Map<String, String> event;

  ConfirmationPage({required this.event});

  @override
  Widget build(BuildContext context) { //build membangun ui dari widget
    return Scaffold(
      appBar: AppBar( //app bar dengan nama konfirmasi
        title: Text('Konfirmasi', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF112C5A),
        iconTheme: IconThemeData(color: Colors.white), // Menetapkan warna ikon kembali menjadi putih
      ),
      body: Padding( //style app bar
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ticket.png', // Gambar barcode/tiket
              width: 250,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Pendaftaran Berhasil!', //menampilkan text pendaftaran berhasil
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Anda telah berhasil mendaftar untuk event ${event['name']} dengan harga ${event['price']}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/eventDetail'));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF112C5A)),
              ),
              child: Text('Kembali ke Detail Event', style: TextStyle(color: Colors.white)), //button untuk kembali ke beranda
            ),
          ],
        ),
      ),
    );
  }
}