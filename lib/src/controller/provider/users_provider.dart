import 'package:flutter/material.dart';

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/models/repository/users_repository.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> _usersList = [];
  final UsersRepository _usersRepository = UsersRepository();

  bool _isLoadings = true;

  List<UserModel> get userList => _usersList;

  bool get isLoading => _isLoadings;

  // link between model and controller
  void getUsersList() async {
    _usersList = await _usersRepository.readUsersFromApi();
    _isLoadings = false;
    notifyListeners();
  }

  Future<void> createNewUser(UserModel newUser) async {
    await _usersRepository.createUserOnApi(newUser);
    notifyListeners();
  }

  Future<void> updateUser({
    required String userId,
    required UserModel updatedUser,
  }) async {
    await _usersRepository.updateUserOnApi(userId, updatedUser);
    notifyListeners();
  }

  Future<void> deleteUser(String userId) async {
    await _usersRepository.deleteUserFromApi(userId);
    notifyListeners();
  }
}
