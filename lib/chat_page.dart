import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Future dan delay

final Color customBlue = Color(0xFF112C5A);

class ChatPage extends StatefulWidget {
  final String chatRoomName;

  ChatPage({required this.chatRoomName});//menappilkan roomchat

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _botHasReplied = false; // Menambahkan variabel untuk melacak balasan bot

  void _kirimPesan() {
    if (_controller.text.isNotEmpty) {//kondisi saat user mengirimkan pesan 
      setState(() {
        _messages.add({
          'text': _controller.text,
          'isMe': true,
        });
        _controller.clear();
      });
      if (!_botHasReplied) {
        _balasanOtomatis();
      }
    }
  }

  void _balasanOtomatis() {//balasan otomatis dari bot setelah user mengirim pesan
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': 'Selamat datang di chat komunitas, yuk bagi pengalamanmu disini!', // Balasan dari bot
          'isMe': false,
        });
        _botHasReplied = true; // Mengatur bahwa bot sudah membalas
      });
    });
  }

  Widget _bangunPesan(String pesan, bool isMe) {//bubble chat
    final warnaLatar = isMe ? customBlue : Color.fromARGB(255, 131, 140, 159);
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final iconAlign = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(//pesan
          margin: EdgeInsets.symmetric(vertical: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: warnaLatar,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            pesan,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
        Row(//ikon avatar pengguna
          mainAxisAlignment: iconAlign,
          children: [
            if (!isMe)
              CircleAvatar(
                backgroundColor: customBlue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            if (isMe)
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, color: Colors.black),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {//membangun UI
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatRoomName, style: TextStyle(color: Colors.white)),
        backgroundColor: customBlue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _bangunPesan(
                  _messages[index]['text'],
                  _messages[index]['isMe'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(//textfield ketik pesan dan button kirim pesan
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: customBlue),
                  onPressed: _kirimPesan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}