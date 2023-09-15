import 'package:flutter/material.dart';
import 'package:mobile_cv/details_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  final Map<String, Object> detailsForm;
  const EditPage({super.key, required this.detailsForm});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  late String name;
  late String slack;
  late String github;
  late String bio;

  @override
  void initState() {
    super.initState();

    // Assign the detailsForm map
    name = widget.detailsForm["fullName"]?.toString() ?? "";
    slack = widget.detailsForm["slack"]?.toString() ?? "";
    github = widget.detailsForm["github"]?.toString() ?? "";
    bio = widget.detailsForm["bio"]?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FULL NAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your full name",
                    ),
                    initialValue: name,
                    // validator
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "SLACK USERNAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your slack username",
                    ),
                    initialValue: slack,
                    // validator
                    onChanged: (value) {
                      setState(() {
                        slack = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "GITHUB HANDLE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your github handle",
                    ),
                    initialValue: github,
                    // validator
                    onChanged: (value) {
                      setState(() {
                        github = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PERSONAL BIO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your personal bio",
                    ),
                    initialValue: bio,
                    // validator`
                    onChanged: (value) {
                      setState(() {
                        bio = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (name.isNotEmpty &&
                      slack.isNotEmpty &&
                      github.isNotEmpty &&
                      bio.isNotEmpty) {
                    Provider.of<DetailProvider>(context, listen: false)
                        .updateDetails(
                      {
                        "fullName": name,
                        "slack": slack,
                        "github": github,
                        "bio": bio,
                      },
                    );

                    writeIntToSharedPreferences() async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("fullName", name);
                      prefs.setString("slack", slack);
                      prefs.setString("github", github);
                      prefs.setString("bio", bio);
                    }

                    writeIntToSharedPreferences();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Details updated successfully!"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All fields are required!"),
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
