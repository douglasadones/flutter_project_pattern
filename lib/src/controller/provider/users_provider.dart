import 'package:flutter/material.dart';

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/repository/users_repository.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> _usersList = [];
  final UsersRepository _usersRepository = UsersRepository();

  bool _isLoadings = true;

  List<UserModel> get userList => _usersList;

  bool get isLoading => _isLoadings;

  // link between model and controller
  void getUsersList() async {
    _usersList = await _usersRepository.getUsersFromApi();
    _isLoadings = false;
    notifyListeners();
  }
}
