import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data_app/core/utils.dart';
import 'package:user_data_app/providers/user_data_provider.dart';

import '../Login/login_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDataProvider>(context).loggedInUser;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Id : ${user!.id}'),
                Text('Name : ${user.fullName}'),
                Text('E-Mail : ${user.email}'),
                Text('Phone No. : ${user.phoneNo}'),
                Text('Date of Birth : ${user.dob}'),
                Text('User Type : ${user.userType}'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Favourite color : "),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: myHexToColor(user.favouriteColor),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<UserDataProvider>(context, listen: false).logOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
