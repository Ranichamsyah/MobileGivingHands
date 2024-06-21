import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  Map<String, List<Map<dynamic, dynamic>>> _eventRegistrations = {};
  List<Map<String, String>> _events = [];
  final TextEditingController _eventNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRegistrations();
    _fetchEvents();
  }

  Future<void> _fetchRegistrations() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('pendaftaran');
      DatabaseEvent event = await ref.once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        setState(() {
          _eventRegistrations.clear();
          if (dataSnapshot.value is List) {
            List<dynamic> registrationsList = dataSnapshot.value as List<dynamic>;
            for (var value in registrationsList) {
              if (value != null) {
                Map<dynamic, dynamic> registration = Map<dynamic, dynamic>.from(value);
                String eventName = registration['event_name'];
                if (!_eventRegistrations.containsKey(eventName)) {
                  _eventRegistrations[eventName] = [];
                }
                _eventRegistrations[eventName]!.add(registration);
              }
            }
          } else {
            Map<dynamic, dynamic> registrationsMap = dataSnapshot.value as Map<dynamic, dynamic>;
            registrationsMap.forEach((key, value) {
              Map<dynamic, dynamic> registration = Map<dynamic, dynamic>.from(value);
              String eventName = registration['event_name'];
              if (!_eventRegistrations.containsKey(eventName)) {
                _eventRegistrations[eventName] = [];
              }
              _eventRegistrations[eventName]!.add(registration);
            });
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to fetch registrations: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _fetchEvents() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('events');
      DatabaseEvent event = await ref.once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        setState(() {
          _events.clear();
          if (dataSnapshot.value is Map) {
            Map<dynamic, dynamic> eventsMap = dataSnapshot.value as Map<dynamic, dynamic>;
            eventsMap.forEach((key, value) {
              _events.add({'id': key, 'name': value['name']});
            });
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to fetch events: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildViewDataTab() {
    return _eventRegistrations.isEmpty
        ? Center(
            child: Text(
              'Belum ada pendaftaran',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          )
        : ListView(
            padding: EdgeInsets.all(16.0),
            children: _eventRegistrations.entries.map((entry) {
              String eventName = entry.key;
              List<Map<dynamic, dynamic>> registrations = entry.value;
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ExpansionTile(
                  title: Text(
                    eventName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF112C5A),
                    ),
                  ),
                  children: registrations.map((registration) {
                    return ListTile(
                      title: Text(
                        'Nama: ${registration['nama']}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Email: ${registration['email']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
  }

  Widget _buildInputEventTab() { //membangun widget untuk tambah event
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tambah Event Baru',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF112C5A),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _eventNameController,
            decoration: InputDecoration(
              labelText: 'Nama Event',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.event),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton( //aksi jika event ditambah
              onPressed: () async {
                if (_eventNameController.text.isNotEmpty) {
                  await _addEvent(_eventNameController.text);
                  Fluttertoast.showToast(
                    msg: "Event berhasil ditambahkan",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  _eventNameController.clear();
                  _fetchEvents();
                } else {
                  Fluttertoast.showToast( //aksi jika event tdk diisi tp disubmit
                    msg: "Nama event tidak boleh kosong",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF112C5A),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Tambah Event',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Daftar Event',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF112C5A),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      _events[index]['name']!,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showEditEventDialog(_events[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteEvent(_events[index]['id']!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addEvent(String eventName) async { //method tambah event dan masuk firebase
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('events');
    DatabaseReference newEventRef = ref.push();

    await newEventRef.set({
      'id': newEventRef.key,
      'name': eventName,
    });
  }

  Future<void> _deleteEvent(String eventId) async { //method menghapus event
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('events').child(eventId);
      await ref.remove();
      Fluttertoast.showToast(
        msg: "Event berhasil dihapus",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _fetchEvents(); // Refresh the list of events
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to delete event: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _showEditEventDialog(Map<String, String> event) { //method mengedit nama event
    TextEditingController editController = TextEditingController(text: event['name']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Nama Event',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  DatabaseReference ref = FirebaseDatabase.instance.ref().child('events').child(event['id']!);
                  await ref.update({'name': editController.text});
                  Fluttertoast.showToast(
                    msg: "Event berhasil diperbarui",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Navigator.pop(context);
                  _fetchEvents();
                } else {
                  Fluttertoast.showToast(
                    msg: "Nama event tidak boleh kosong",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) { //membangun widget halaman admin
    List<Widget> _widgetOptions = <Widget>[
      _buildViewDataTab(),
      _buildInputEventTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: Color(0xFF112C5A),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              bool confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi Logout'),
                    content: Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Ya'),
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) { //konfrim jika logout
                await FirebaseAuth.instance.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Input Event',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF112C5A),
        onTap: _onItemTapped,
      ),
    );
  }
}
