import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  Map<String, Object> _details = {
    "fullName": "Ademola Otunba-Marcus",
    "slack_username": "marcuz",
    "github_handle": "devmarcuz",
    "bio":
        "I am a highly productive Software Developer with a solid background in frontend, backend and Mobile development with over three years of experience, possessing proficient knowledge in multiple programming languages, databases and frameworks. My passion is to provide excellent user experiences and strive for performance and scalability. I am a valuable asset to any team and I tend to deliver top-quality results.",
  };

  Map<String, Object> get details => _details;

  void updateDetails(Map<String, Object> updatedDetails) {
    _details = updatedDetails;
    notifyListeners();
  }
}
