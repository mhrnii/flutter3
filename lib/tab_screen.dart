import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SMK Negeri 4 - Mobile Apps'),
        ),
        body: TabBarView(
          children: [
            DashboardTab(),
            StudentsTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.dashboard), text: 'beranda'),
            Tab(icon: Icon(Icons.people), text: 'siswa'),
            Tab(icon: Icon(Icons.account_circle), text: 'profil'),
          ],
          labelColor: Color(0xFF8F8A8A),
          unselectedLabelColor: Color(0xFF8F8A8A),
          indicatorColor: Color.fromARGB(255, 139, 171, 235),
        ),
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.school, 'label': 'profil sekolah'},
    {'icon': Icons.cast_for_education, 'label': 'Program Keahlian'},
    {'icon': Icons.map_outlined, 'label': 'Rute Sekolah'},
    {'icon': Icons.today, 'label': 'Jadwal Masuk'},
    {'icon': Icons.emoji_events, 'label': 'Penghargaan'},
    {'icon': Icons.corporate_fare, 'label': 'Jadwal Pelajaran'},
    {'icon': Icons.book, 'label': 'Event'},
    {'icon': Icons.photo_camera, 'label': 'album sekolah'},
    {'icon': Icons.local_library, 'label': 'Perpustakaan'},
    {'icon': Icons.info, 'label': 'Bantuan'},
    {'icon': Icons.phone, 'label': 'Kontak'},
    {'icon': Icons.chat, 'label': 'Masukan dan Kritik'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 99, 121, 219)!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  print('${item['label']} tapped');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'],
                        size: 50.0, color: Color.fromARGB(255, 141, 160, 224)),
                    SizedBox(height: 8.0),
                    Text(
                      item['label'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Color.fromARGB(221, 70, 64, 64)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StudentsTab extends StatelessWidget {
  Future<List<User>> fetchUsers() async {
    // Sample data; replace with actual API call if needed
    return [
      User(
          firstName: 'Jaehyun', email: 'Jaehyun12@gmail.com', className: '11 tkr 2'),
      User(
          firstName: 'Mowi', email: 'Mowi17@gmail.com', className: '12 pplg 1'),
      User(
          firstName: 'Sultan', email: 'Sultan8@gmail.com', className: '10 tjkt 3'),
      User(
        firstName: 'nopal', email: 'nopal@gmail.com', className: '13 tpfl 1')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName[0]),
                    ),
                    title: Text(user.firstName),
                    subtitle:
                        Text('Kelas: ${user.className}\nEmail: ${user.email}'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Path gambar profil
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Prima ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Email:prima12@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Biodata',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Nama Lengkap'),
            subtitle: Text('Prima Nuina'),
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text('Tempat Tinggal'),
            subtitle: Text('Ciputat'),
          ),
        ],
      ),
    );
  }
}

class User {
  final String firstName;
  final String email;
  final String className; // Added className field

  User({required this.firstName, required this.email, required this.className});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      email: json['email'],
      className:
          json['class_name'], // Ensure the API response includes this field
    );
  }
}
