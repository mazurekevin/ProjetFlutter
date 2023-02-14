import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:projet_flutter/models/user.dart';
import 'package:projet_flutter/service/service_user.dart';
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
  bool _isLoaded = false;
  bool _isLoggedUser = false;

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
    getUser();
  }

  getUser() async {
    //_user = await ServiceUser().getUser(widget.userId);
    _user = User(
        id: 1,
        firstname: "Jean-Luc",
        lastname: "LYS",
        email: "jlys@gmail.com",
        password: "123456789");
    if (_user != null) {
      setState(() {
        _isLoaded = true;
        _isLoggedUser = _user?.id == globals.user?.id;
      });
    }
  }

  changeProfilePicture(BuildContext context, Offset offset) {
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
        // code à effectuer si galerie sélectionné
      } else if (selectedValue == "Picture") {
        // code à effectuer si photo sélectionné
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xff033976);
    const purple = Color(0xff6d07c5);
    return Scaffold(
      body: Visibility(
        visible: _isLoaded,
        child: Column(
          children: [
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_isLoggedUser) {
                        RenderBox renderBox = context.findRenderObject() as RenderBox;
                        var offset = renderBox.localToGlobal(Offset.zero);
                        changeProfilePicture(context, offset);
                      }
                    },
                    child: ProfilePicture(
                      name: '${_user?.firstname} ${_user?.lastname}',
                      radius: 50,
                      fontsize: 21,
                      random: true,
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
                              Container(
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
                              Container(
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
                              Container(
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
                              Container(
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
                              Container(
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
                              Container(
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
