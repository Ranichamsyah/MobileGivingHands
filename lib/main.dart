import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'event_detail.dart';
import 'profil.dart';
import 'pendaftaran.dart';
import 'pembayaran.dart';
import 'konfrimbayar.dart';
import 'chat_page.dart';
import 'categorychat.dart';
import 'news.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(//inisialisasi firebase
    options: FirebaseOptions(apiKey: "AIzaSyA8ku793yEBtSAr6BmGZQPw7tSVnI5YlBQ", appId: "1:208792188550:android:d54b342ee2db3c6fafc307", projectId: "uaspemob-1132b", databaseURL: "https://uaspemob-1132b-default-rtdb.asia-southeast1.firebasedatabase.app", storageBucket:"uaspemob-1132b.appspot.com", messagingSenderId: "208792188550")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//menghilangkan banner merah di ujung window run
      title: 'Volunteer App',//judul tab chrome
      theme: ThemeData(
        primaryColor: Color(0xFF112C5A),
        scaffoldBackgroundColor: Color.fromARGB(255, 235, 238, 243),
        appBarTheme: AppBarTheme(
          color: Color(0xFF112C5A),
        iconTheme: IconThemeData(color:Color(0xFF112C5A)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF112C5A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: LoginPage(),//tampilan awal run
      routes: {//rute page
        '/eventDetail': (context) => EventDetailPage(),
        '/profil': (context) => ProfilPage(),
        '/registration': (context) => RegistrationPage(event: {}),
        '/payment': (context) => PaymentPage(event: {}),
        '/confirmation': (context) => ConfirmationPage(event: {}),
        '/chat': (context) => ChatPage(chatRoomName: ''),
        '/chatCategory': (context) => ChatCategoryPage(),
        '/news': (context) => NewsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [//nav bar
    HomeContent(),
    ChatCategoryPage(),
    NewsPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: Text(
                'Giving Hands', // Judul AppBar
                style: TextStyle(
                  color: Colors.white, // Warna teks putih
                  fontWeight: FontWeight.bold, // Teks tebal
                ),
              ),
            )
          : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color(0xFF112C5A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.chat),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.article),
            ),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.person),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> _carouselImages = [
    'assets/gambar1.jpg',
    'assets/gambar2.jpg',
    'assets/gambar3.jpg',
  ];

  final List<Map<String, String>> _events = [//mengisi data event yang ditampilkan di home page
    {
      'name': 'Konservasi Pandan Laut',
      'image': 'assets/gambar4.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Givinghands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Pantai Pelangi, Kab, Bantul dan menjadi relawan Konservasi Pandan Laut dan Patroli Penyu di Pantai Pelangi. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Menanam Pandan Laut dan Bersih Pantai Patroli Penyu di Pantai Pelangi. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': 'Rp 100.000'
    },
    {
      'name': 'Berkreasi Menghias Tumpeng',
      'image': 'assets/gambar5.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Givinghands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Gedung Karang Taruna Soboman, Kab. Bantul dan menjadi relawan Berkreasi Menghias Tumpeng bersama Penyitas ODGJ. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Berkreasi menghias tumpeng, Bermain dan berbagi ceria bersama penyintas ODGJ. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': 'Rp 200.000'
    },
    {
      'name': 'Piknik ke Candi Prambanan',
      'image': 'assets/gambar6.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Givinghands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Kawasan Candi Prambanan Lapangan Garuda Mandala, Kab. Klaten dan menjadi relawan Piknik ke Candi Prambanan Bersama Teman Netra. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Jalan-Jalan Bersama ke Candi Prambanan bersama Teman Netra, Berbagi ceria bersama Teman Netra. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '150.000'
    },
    {
      'name': 'Bermain dan Melukis Bersama Oma di Panti Lansia',
      'image': 'assets/gambar15.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Panti Werdha Harapan Ibu, Gondoriyo, Kota Semarang dan menjadi relawan Bermain dan Melukis Bersama Oma di Panti Lansia. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Melukis bersama Oma di Panti Lansia, Mendampingi Oma selama kegiatan, Berbagi kebahagiaan bersama Oma. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '50.000'
    },
    {
      'name': 'Jeep Tracking & Tanam Pohon di Konservasi Jurang Jero',
      'image': 'assets/gambar14.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke OWA Jurangjero, Srumbung, Magelang dan menjadi relawan Camping dan Menanam Pohon di Konservasi Jurang Jero. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Menanam Bibit Pohon dan donasi bibit, Camping di Konservasi Jurang Jero, Wisata Jeep Jurangjero. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '200.000'
    },
    {
      'name': 'Edukasi & Menanam Mangrove di Ekowisata',
      'image': 'assets/gambar13.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Ekowisata Mangrove Batu Lumbang, Serangan, Denpasar, Bali dan menjadi relawan Edukasi dan Menanam Mangrove di Ekowisata Mangrove Batu Lumbang. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Menanam 300 bibit Mangrove, Bersih-bersih kawasan Mangrove. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '80.000'
    },
    {
      'name': 'One Fine Day Jalan-Jalan Bersama Adik Binaan',
      'image': 'assets/gambar16.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Indonesia Science Center (PP-IPTEK), Kec. Cipayung, Jakarta Timur dan menjadi relawan One Fine Day Jalan-Jalan Bersama Adik Binaan. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Mengunjungi Indonesia Science Center bersama Adik Binaan, Bermain dan Jalan-jalan bersama Adik Binaan, Menjaga Adik Binaan selama kegiatan. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '70.000'
    },
    {
      'name': 'Bermain dan Jajan Bareng Bersama Anak Panti',
      'image': 'assets/gambar19.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Panti Asuhan An-Nisa, Kota Palembang dan menjadi relawan Bermain dan Jajan Bareng Bersama Anak Panti. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Jajan bersama Anak Panti, Berbagi bersama Anak Panti,Bermain dan berbagi ceria bersama Anak Panti. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '150.000'
    },
    {
      'name': 'Bermain Games dan Berbagi Daging Kurban Untuk Warga',
      'image': 'assets/gambar17.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke Kumpeh/Tanjabtim/Sarang Elang, Kota Jambi dan menjadi relawan Bermain Games & Berbagi Daging Qurban untuk Warga. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Berbagi daging kurban untuk Warga-Warga, Bermain games bersama Warga-Warga. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '100.000'
    },
    {
      'name': 'Outbound & Fun Tubing Bersama Adek Panti',
      'image': 'assets/gambar18.jpg',
      'shortDescription': 'Join us',
      'longDescription': 'Ada banyak cara untuk berbagi dan memberikan dampak baik untuk lingkungan sekitarmu, salah satunya dengan menjadi relawan. Selain bisa membawa manfaat yang luar biasa untuk lingkunganmu, kamu juga bisa mendapatkan pengalaman dan menambah makna untuk hari-harimu. Giving Hands hadir sebagai wadah untuk kamu yang ingin mendapatkan pengalaman menjadi relawan dalam berbagai misi kebaikan. Kali ini Giving Hands akan berkunjung ke New Rivermoon, Kab. Klaten dan menjadi relawan Outbond dan Fun Tubing Bersama Adik Panti. Kamu bisa ikut terlibat dalam berbagai kegiatan berikut : Outbond dan Fun Tubing bersama Adik Panti, Bermain dan berbagi ceria bersama Adik Panti. Dengan ikut menjadi peserta Giving Hands, kamu sudah ikut menjadi bagian dalam misi kebaikan untuk berbagi kepada sesama makhluk hidup dan mendapat perlindungan dari Asuransi Kitabisa selama kegiatan. Yuk, daftar sekarang!',
      'price': '250.000'
    },
  ];

  List<Map<String, String>> _filteredEvents = [];//fitur pencarian
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredEvents = _events;
    _searchController.addListener(_filterEvents);
  }

  void _filterEvents() {//memfilter event sesuai yang diketik
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredEvents = _events.where((event) {
        final name = event['name']!.toLowerCase();
        final description = event['shortDescription']!.toLowerCase();
        return name.contains(query) || description.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {//menghapus tampilan event ketika pada kolom pencarian dihapus keyword nya
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {//mengatur UI
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ),
          if (!_isSearching) ...[//carouselslider hanya saat tidak dalam kondisi mencari
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CarouselSlider(//gambar bergeser otomatis
                items: _carouselImages.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2 / 1,
                  enlargeCenterPage: true,
                ),
              ),
            ),
          ],
          ListView.builder(//menampilkan event berdasarkan keyword yang dicari
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _filteredEvents.length,
            itemBuilder: (context, index) {
              return GestureDetector(//membungkus dan memindah ke halaman detail ketika ditekan
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/eventDetail',
                    arguments: _filteredEvents[index],
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF112C5A),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          _filteredEvents[index]['image']!,
                          width: 300,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _filteredEvents[index]['name']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _filteredEvents[index]['shortDescription']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _filteredEvents[index]['price']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}