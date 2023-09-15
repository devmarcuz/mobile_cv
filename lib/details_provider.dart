import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProvider extends ChangeNotifier {
  Map<String, Object> _details = {
    "fullName": "",
    "slack": "",
    "github": "",
    "bio": "",
  };

  Map<String, Object> get details => _details;

  // Constructor to initialize _details with data from readFullName()
  DetailProvider() {
    _details = {
      "fullName": "",
      "slack": "",
      "github": "",
      "bio": "",
    };
    readFullName().then((data) {
      if (data['fullName'].toString().isNotEmpty) {
        _details = data;
        notifyListeners();
      } else {
        _details = {
          "fullName": "Ademola Otunba-Marcus",
          "slack": "marcuz",
          "github": "devmarcuz",
          "bio":
              "I am a highly productive Software Developer with a solid background in frontend, backend and Mobile development with over three years of experience, possessing proficient knowledge in multiple programming languages, databases and frameworks. My passion is to provide excellent user experiences and strive for performance and scalability. I am a valuable asset to any team and I tend to deliver top-quality results.",
        };
        notifyListeners();
      }
      // Notify listeners when data is loaded
    });
  }

  Future<Map<String, Object>> readFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "fullName": prefs.getString("fullName") ?? "",
      "slack": prefs.getString("slack") ?? "",
      "github": prefs.getString("github") ?? "",
      "bio": prefs.getString("bio") ?? "",
    };
  }

  Future<void> updateDetails(Map<String, String> map) async {
    // print(map);
    _details = {
      "fullName": map["fullName"] as String,
      "slack": map["slack"] as String,
      "github": map["github"] as String,
      "bio": map["bio"] as String,
    };
    notifyListeners();
  }
}
