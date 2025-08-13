import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  static const routeName = '/edit_profile';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool _loading = true;
  Map<String, dynamic> _userData = {};

  // Form fields
  String? _name;
  String? _country;
  String? _state;
  String? _city;
  String? _educationLevel;
  String? _nativeLanguage;
  int? _sleepHours;

  final List<String> _educationLevels = [
    "High School",
    "Undergraduate",
    "Postgraduate",
    "Doctorate",
    "Other"
  ];
  final List<String> _languages = ["English", "Spanish", "Mandarin", "Hindi", "Other"];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final uid = _auth.currentUser!.uid;
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          _userData = doc.data()!;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      final uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).update({
        'name': _name ?? _userData['name'],
        'country': _country ?? _userData['country'],
        'state': _state ?? _userData['state'],
        'city': _city ?? _userData['city'],
        'educationLevel': _educationLevel ?? _userData['educationLevel'],
        'nativeLanguage': _nativeLanguage ?? _userData['nativeLanguage'],
        'sleepHours': _sleepHours ?? _userData['sleepHours'],
      });

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );

      Navigator.pop(context);
       }
    } catch (e) {
      debugPrint("Error updating profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
       backgroundColor: GlobalVariables.gameColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                initialValue: _userData['name'],
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
                onSaved: (val) => _name = val,
              ),
              const SizedBox(height: 15),

              // Country
              TextFormField(
                initialValue: _userData['country'],
                decoration: const InputDecoration(
                  labelText: "Country",
                  prefixIcon: Icon(Icons.flag),
                ),
                onSaved: (val) => _country = val,
              ),
              const SizedBox(height: 15),

              // State
              TextFormField(
                initialValue: _userData['state'],
                decoration: const InputDecoration(
                  labelText: "State",
                  prefixIcon: Icon(Icons.map),
                ),
                onSaved: (val) => _state = val,
              ),
              const SizedBox(height: 15),

              // City
              TextFormField(
                initialValue: _userData['city'],
                decoration: const InputDecoration(
                  labelText: "City",
                  prefixIcon: Icon(Icons.location_city),
                ),
                onSaved: (val) => _city = val,
              ),
              const SizedBox(height: 15),

              // Education Level
              DropdownButtonFormField<String>(
                value: _userData['educationLevel'],
                decoration: const InputDecoration(
                  labelText: "Education Level",
                  prefixIcon: Icon(Icons.school),
                ),
                items: _educationLevels.map((edu) {
                  return DropdownMenuItem(value: edu, child: Text(edu));
                }).toList(),
                onChanged: (val) => _educationLevel = val,
              ),
              const SizedBox(height: 15),

              // Native Language
              DropdownButtonFormField<String>(
                value: _userData['nativeLanguage'],
                decoration: const InputDecoration(
                  labelText: "Native Language",
                  prefixIcon: Icon(Icons.language),
                ),
                items: _languages.map((lang) {
                  return DropdownMenuItem(value: lang, child: Text(lang));
                }).toList(),
                onChanged: (val) => _nativeLanguage = val,
              ),
              const SizedBox(height: 15),

              // Sleep Hours
              TextFormField(
                initialValue: _userData['sleepHours']?.toString(),
                decoration: const InputDecoration(
                  labelText: "Average Sleep Hours",
                  prefixIcon: Icon(Icons.bed),
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => _sleepHours = int.tryParse(val ?? ""),
              ),
              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.gameColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _saveProfile,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
