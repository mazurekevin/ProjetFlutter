import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:projet_flutter/models/language.dart';
import 'package:projet_flutter/models/user.dart';
import 'package:projet_flutter/service/service_language.dart';
import 'package:image_picker/image_picker.dart';
import '../service/service_user.dart';
import '/globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  List<Language> _languages = [];
  bool _isLoaded = false;
  bool _isLoggedUser = false;
  String _selectedItem = "";

  File? _image;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  final List<PopupMenuEntry<String>> items = [
    const PopupMenuItem(
      value: "Gallery",
      child: Text("Open gallery"),
    ),
    const PopupMenuItem(
      value: "Picture",
      child: Text("Take a picture"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    _user = await ServiceUser().getUser(widget.userId);
    if (_user != null) {
      _languages += (await ServiceLanguage().getLanguages())!;
      if (_languages.isNotEmpty) {
        setState(() {
          _isLoaded = true;
          _isLoggedUser = _user?.id == globals.user?.id;
          _selectedItem = _user!.languageIso;
        });
      }
    }
  }

  _changeProfilePicture(BuildContext context, Offset offset) {
    final selectedValue = showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx,
        offset.dy,
      ),
      items: items,
    );
    if (selectedValue != null) {
      if (selectedValue == "Gallery") {
        getImage(ImageSource.gallery);
      } else if (selectedValue == "Picture") {
        getImage(ImageSource.camera);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xff6d07c5);
    return Scaffold(
      body: Visibility(
        visible: _isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_isLoggedUser) {
                        RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        var offset = renderBox.localToGlobal(Offset.zero);
                        _changeProfilePicture(context, offset);
                      }
                    },
                    child: _image == null
                        ? ProfilePicture(
                            name: '${_user?.firstname} ${_user?.lastname}',
                            radius: 50,
                            fontsize: 21,
                            random: true,
                          )
                        : Image.file(
                            _image!,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_user?.firstname} ${_user?.lastname}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: purple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'My informations',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'First name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${_user?.firstname}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Last name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${_user?.lastname}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Email address',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${_user?.email}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Language',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: _isLoggedUser
                                    ? DropdownButton<String>(
                                        value: _selectedItem,
                                        elevation: 16,
                                        style: const TextStyle(color: purple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedItem = newValue!;
                                          });
                                        },
                                        items: _languages
                                            .map<DropdownMenuItem<String>>(
                                                (Language value) {
                                          return DropdownMenuItem<String>(
                                            value: value.iso6391,
                                            child: Text(value.englishName),
                                          );
                                        }).toList(),
                                      )
                                    : Text("${_user?.languageName}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
