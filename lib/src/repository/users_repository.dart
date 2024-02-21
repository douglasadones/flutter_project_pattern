import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/utils/api_constants.dart';

class UsersRepository {
  Future<List<UserModel>> getUsersFromApi() async {
    try {
      /// READ/GET/LER uma lista de usuario da API
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Iterable dataDecode = jsonDecode(response.body);

        final List<UserModel> userList =
            dataDecode.map((userJson) => UserModel.fromMap(userJson)).toList();
            
        return userList;
      } else {
      }
    } catch (error, stack) {
      log(
        'Ocorreu um erro ao RESGATAR LISTAGEM de usuários',
        error: error,
        stackTrace: stack,
      );
    }
    return [];
  }
}
