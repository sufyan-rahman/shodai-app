import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserProfile() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: const Text('Profile'),
          backgroundColor: Color(0xFFFFFFFF),
          // toolbarHeight: 70.0,
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(4.0),
          //   child: Container(
          //     color: Colors.grey,
          //     height: 1.0,
          //   ),
          // ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('User data not found.'));
          }

          var userData = snapshot.data!.data();
          if (userData == null) {
            return const Center(child: Text('User data not found.'));
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items evenly
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: user.photoURL != null
                              ? NetworkImage(user.photoURL!)
                              : null,
                          child: user.photoURL == null
                              ? const Icon(Icons.account_circle, size: 100)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.displayName ?? 'No name provided',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          user.email ?? 'No email provided',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Phone',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          userData['phone'] ?? 'No phone number provided',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align items to the end (right side)
                      children: [
                        Align(
                          alignment: Alignment.topRight, // Align to the top right corner
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfilePage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(top: 16),
                color: Colors.white,
                child: Row(
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Password',
                            style: TextStyle(fontSize: 16, color: Colors.grey),))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
