import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/models/users.dart';
import 'package:skivvy_app/providers/user.dart';
import 'package:skivvy_app/theme.dart';

class MatesScreen extends StatefulWidget {
  static const routeName = '/mates';
  MatesScreen() : super();

  @override
  _MatesScreenState createState() => _MatesScreenState();
}

class _MatesScreenState extends State<MatesScreen> {
  List<UserElement> _users;
  Users usersData;
  bool isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(Duration.zero).then((_) async {
      _users = await Provider.of<User>(context, listen: false).fetchUsers();
      print("_users: $_users");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Mates',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: null == _users ? 0 : _users.length,
              itemBuilder: (context, index) {
                UserElement user = _users[index];
                return ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: skivvySecondaryColor,
                  ),
                  hoverColor: skivvyBaseLightColor,
                  selectedTileColor: skivvyBaseColor,
                  title: Text(
                    user.firstName,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold)),
                  ),
                  subtitle: Text(
                    user.email,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: textColorLight)),
                  ),
                  onTap: () {},
                );
              })),
    );
  }
}
