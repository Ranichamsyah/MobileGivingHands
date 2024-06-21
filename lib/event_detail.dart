import 'package:flutter/material.dart'; //import material flutter
import 'pendaftaran.dart'; // Import file pendaftaran.dart

final Color customBlue = Color(0xFF112C5A); // Define customBlue

class EventDetailPage extends StatefulWidget { //definisi class even detail
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> //subclass
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, String> event;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() { //Metode ini dipanggil setiap kali dependencies dari widget berubah. Ini bisa terjadi ketika widget yang bergantung pada InheritedWidget mengalami perubahan.
    super.didChangeDependencies();
    event = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
  }

  @override
  void dispose() { // Metode ini dipanggil ketika objek state akan dihancurkan dan dihapus dari widget tree. 
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { //membangun build
    return Scaffold(
      body: Column(
        children: [
          // Image at the top
          Stack(
            children: [
              Image.asset(
                event['image']!,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 30.0,
                left: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: customBlue.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // TabBar below the image
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Deskripsi'),
              Tab(text: 'Beli Tiket'),
            ],
          ),
          // Event Name below the TabBar
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              event['name']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Default color for the text
              ),
            ),
          ),
          // TabBarView below the Event Name
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDescriptionTab(),
                _buildTicketTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() { //membangun widget deskripsi tab
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Default color for the text
              ),
            ),
            SizedBox(height: 10),
            Text(
              event['longDescription']!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Default color for the text
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Syarat & Ketentuan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Default color for the text
              ),
            ),
            SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Mengisi formulir pendaftaran',
                  style: TextStyle(color: Colors.black), // Default color for the text
                ),
                Text(
                  '• Memberikan kontribusi sebesar ${event['price']}',
                  style: TextStyle(color: Colors.black), // Default color for the text
                ),
                Text(
                  '• Menjaga lingkungan sekitar',
                  style: TextStyle(color: Colors.black), // Default color for the text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketTab() { //membangun widget tiket tab
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beli Tiket:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Harga: ${event['price']}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Redirect to registration page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(event: event),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart, color: Colors.white), // Set icon color to white
                  label: Text(
                    'Beli Tiket',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(customBlue), // Warna latar belakang tombol
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Atur sudut tombol
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}