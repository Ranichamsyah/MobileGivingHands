
import 'package:flutter/material.dart'; //import package flutter
import 'package:shared_preferences/shared_preferences.dart'; // Mengimpor paket shared_preferences yang memungkinkan penyimpanan data sederhana 
import 'user_model.dart'; //import halaman user
import 'login.dart'; // Import halaman login
import 'biodata_page.dart'; // Import halaman biodata

class ProfilPage extends StatelessWidget { //mendefinisikan kelas profil 
  Future<UserModel> _getUserData() async { //method get user
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? 'User';
    final email = prefs.getString('userEmail') ?? 'user@gmail.com';
    return UserModel(name: name, email: email);
  }

  Future<void> _logout(BuildContext context) async { //memanggil method logout
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _showLogoutDialog(BuildContext context) { //method menampilkan pesan untuk konfrimasi logout
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logout(context);
            },
            child: Text('Iya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {  //membangun widget
    return Scaffold(
      appBar: AppBar( //membuat app bar
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF112C5A),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<UserModel>(
        future: _getUserData(), //memanggil method getuser untuk menampilkan user
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data available'));
          }

          final user = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('gambar9.png'),
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      'gambar12.jpg',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  user.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    user.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    '+62 812 3456 7890',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ProfilCard( //card untuk developer
                  nama: 'Syuraini Noor Chamsyah',
                  npm: '22082010033',
                  programStudi: 'Sistem Informasi',
                  email: '22082010033@student.upnjatim.ac.id',
                  noTelp: '+62 857 4854 1139',
                  imagePath: 'gambar9.png',
                  onTap: () {
                    Navigator.push( //jika diklik maka akan beralih kehalaman biodata lengkap
                      context,
                      MaterialPageRoute( 
                        builder: (context) => BiodataPage(
                          nama: 'Syuraini Noor Chamsyah',
                          npm: '22082010033',
                          programStudi: 'Sistem Informasi',
                          email: '22082010033@student.upnjatim.ac.id',
                          noTelp: '+62 857 4854 1139',
                          imagePath: 'gambar9.png',
                          alamat: 'Kendang Sari Gg XI No 4a, Surabaya', // Data tambahan
                          tanggalLahir: '25 Februari 2004', // Data tambahan
                          jenisKelamin: 'Perempuan', // Data tambahan
                        ),
                      ),
                    );
                  },
                ),
                ProfilCard( //card untuk developer
                  nama: 'Rifda Nasywatul Affah',
                  npm: '22082010009',
                  programStudi: 'Sistem Informasi',
                  email: '22082010009@student.upnjatim.ac.id',
                  noTelp: '+62 857 4871 3615',
                  imagePath: 'gambar11.jpg',
                  onTap: () {
                    Navigator.push( //jika diklik akan ke halaman biodata
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiodataPage( 
                          nama: 'Rifda Nasywatul Affah',
                          npm: '22082010009',
                          programStudi: 'Sistem Informasi',
                          email: '22082010009@student.upnjatim.ac.id',
                          noTelp: '+62 857 4871 3615',
                          imagePath: 'gambar11.jpg',
                          alamat: 'Ds. Simongagrok Kab. Mojokerto', // Data tambahan
                          tanggalLahir: '27 Agustus 2004', // Data tambahan
                          jenisKelamin: 'Perempuan', // Data tambahan
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfilCard extends StatelessWidget {
  final String nama;
  final String npm;
  final String programStudi;
  final String email;
  final String noTelp;
  final String imagePath;
  final VoidCallback onTap; // Tambahkan parameter onTap

  const ProfilCard({
    required this.nama,
    required this.npm,
    required this.programStudi,
    required this.email,
    required this.noTelp,
    required this.imagePath,
    required this.onTap, // Tambahkan parameter onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Panggil onTap saat card diklik
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Color(0xFF112C5A),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        email,
                        style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        noTelp,
                        style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'NPM: $npm',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Program Studi: $programStudi',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
