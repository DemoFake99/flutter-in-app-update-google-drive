import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/user_data_model.dart';

class UserDataProvider extends ChangeNotifier {
  final uuid = const Uuid();
  // ignore: prefer_final_fields
  List<UserDataModel> _users = [
    UserDataModel(
      id: '2254051d-0d28-4428-b2a6-aba4dcd830b3',
      fullName: 'Admin',
      email: 'admin@gmail.com',
      phoneNo: '8888888888',
      dob: '2000-12-12',
      favouriteColor: 'h3dfw3',
      password: 'admin1234',
      userType: 'admin',
    )
  ];
  UserDataModel? _loggedInUser;

  List<UserDataModel> get users => _users;
  UserDataModel? get loggedInUser => _loggedInUser;

  void registerUser(
    String fullName,
    String email,
    String phoneNo,
    String dob,
    String favouriteColor,
    String password,
    String userType,
  ) {
    _users.add(
      UserDataModel(
        id: uuid.v4(),
        fullName: fullName,
        email: email,
        phoneNo: phoneNo,
        dob: dob,
        favouriteColor: favouriteColor,
        password: password,
        userType: userType,
      ),
    );
    notifyListeners();
  }

  bool login(
    String email,
    String password,
  ) {
    var user = _users.firstWhere(
      (user) =>
          user.email == email && user.password == password,
    );
    _loggedInUser = user;
    notifyListeners();
    return true;
  }

  void logOut() {
    _loggedInUser = null;
    notifyListeners();
  }
}
