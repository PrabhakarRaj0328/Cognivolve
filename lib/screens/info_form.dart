import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognivolve/utils/global_variables.dart';
import 'package:flutter/material.dart';

class UserInfoForm extends StatefulWidget {
  final String uid;
  final String email;
  final String displayName;
  const UserInfoForm({
    super.key,
    required this.uid,
    required this.email,
    required this.displayName,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _name;
  int? _age;
  String? _gender;
  String? _country;
  String? _state;
  String? _city;
  String? _educationLevel;
  String? _nativeLanguage;
  int? _sleepHours;

  final List<String> _genders = [
    "Male",
    "Female",
    "Non-binary",
    "Prefer not to say",
  ];
  final List<String> _educationLevels = [
    "High School",
    "Undergraduate",
    "Postgraduate",
    "Doctorate",
    "Other",
  ];
  final List<String> _languages = [
    "English",
    "Spanish",
    "Mandarin",
    "Hindi",
    "Other",
  ];
  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
        'name': _name ?? widget.displayName,
        'email': widget.email,
        'age': _age,
        'gender': _gender,
        'country': _country,
        'state': _state,
        'city': _city,
        'educationLevel': _educationLevel,
        'nativeLanguage': _nativeLanguage,
        'sleepHours': _sleepHours,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if(mounted) {
        Navigator.pushReplacementNamed(context, '/landingpage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Participant Information"),
        centerTitle: true,
        backgroundColor: GlobalVariables.gameColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Please fill in your details for research purposes.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onSaved: (value) => _name = value,
                  ),
                  const SizedBox(height: 15),

                  // Age
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your age";
                      }
                      if (int.tryParse(value) == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                    onSaved: (value) => _age = int.tryParse(value!),
                  ),
                  const SizedBox(height: 15),

                  // Gender
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Gender",
                      prefixIcon: Icon(Icons.wc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    items:
                        _genders.map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                    onChanged: (value) => _gender = value,
                  ),
                  const SizedBox(height: 15),

                  // Country
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Country of Residence",
                      prefixIcon: Icon(Icons.flag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onSaved: (value) => _country = value,
                  ),
                  const SizedBox(height: 15),

                  // State
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "State / Province",
                      prefixIcon: Icon(Icons.map),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onSaved: (value) => _state = value,
                  ),
                  const SizedBox(height: 15),

                  // City
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "City",
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onSaved: (value) => _city = value,
                  ),
                  const SizedBox(height: 15),

                  // Education Level
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Education Level",
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    items:
                        _educationLevels.map((edu) {
                          return DropdownMenuItem(value: edu, child: Text(edu));
                        }).toList(),
                    onChanged: (value) => _educationLevel = value,
                  ),
                  const SizedBox(height: 15),

                  // Native Language
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Native Language",
                      prefixIcon: Icon(Icons.language),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    items:
                        _languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang),
                          );
                        }).toList(),
                    onChanged: (value) => _nativeLanguage = value,
                  ),
                  const SizedBox(height: 15),

                  // Sleep Hours
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Average Sleep Hours (per night)",
                      prefixIcon: Icon(Icons.bed),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _sleepHours = int.tryParse(value!),
                  ),
                  const SizedBox(height: 25),

                  // Submit Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.gameColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Form Submitted Successfully"),
                          ),
                        );
                        onSubmit();
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
