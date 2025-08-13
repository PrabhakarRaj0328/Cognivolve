import 'package:cognivolve/screens/auth_screen.dart';
import 'package:cognivolve/screens/edit_screen.dart';
import 'package:cognivolve/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>> _getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userData = userDoc.data() ?? {};

    final gamesCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .get();

    int gamesPlayed = gamesCollection.docs.length;
    int totalScore = 0;

    for (var gameDoc in gamesCollection.docs) {
      final gameData = gameDoc.data();
      totalScore += (gameData['finalScore'] ?? 0) as int;
    }

    double averageScore =
        gamesPlayed > 0 ? totalScore / gamesPlayed : 0.0;

    return {
      'name': userData['name'] ?? 'Unknown',
      'email': userData['email'] ?? '',
      'country': userData['country'] ?? '-',
      'state': userData['state'] ?? '-',
      'city': userData['city'] ?? '-',
      'profileImageUrl': userData['profileImageUrl'] ?? '',
      'gamesPlayed': gamesPlayed,
      'averageScore': averageScore,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authservice = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("User data not found."));
          }

          final data = snapshot.data!;
          final String name = data['name'];
          final String email = data['email'];
          final String country = data['country'];
          final String state = data['state'];
          final String city = data['city'];
          final String profileImageUrl = data['profileImageUrl'];
          final int gamesPlayed = data['gamesPlayed'];
          final double averageScore = data['averageScore'];

          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            profileImageUrl.isNotEmpty ? NetworkImage(profileImageUrl) : null,
                        child: profileImageUrl.isEmpty
                            ? Center(
                                child: Text(
                                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                                  style: const TextStyle(fontSize: 40),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(email, style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text(
                        "$city, $state, $country",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Stats section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("Games Played", gamesPlayed.toString()),
                          _buildStatItem("Avg. Score", averageScore.toStringAsFixed(1)),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit, color: Colors.deepPurple),
                        title: const Text("Edit Profile"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.pushNamed(context, EditProfilePage.routeName);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text("Logout"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () async {
                          await _authservice.signOut();
                          Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(builder: (_) => const AuthScreen()),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
