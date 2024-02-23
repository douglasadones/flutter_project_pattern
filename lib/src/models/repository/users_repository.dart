import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/utils/api_constants.dart';

class UsersRepository {
  // Aqui será criado o nosso CRUD

    Future<void> createUserOnApi(UserModel newUser) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users);

      // Note que agora é post e tbm estamos utilizando o toJson.
      final response = await http.post(
        uri,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: newUser.toJson(),
      );

      // statusCode == 201 indica  sucesso na criação.
      if (response.statusCode == 201) {
        log(response.body);
      } else {
        throw ("Erro ao criar novo usuário, status code: ${response.statusCode}");
      }
    } catch (error, stack) {
      log(
        'Não foi possível criar um novo usuário.',
        error: error,
        stackTrace: stack,
      );
    }
  }

  Future<List<UserModel>> readUsersFromApi() async {
    try {
      /// READ/GET/LER uma lista de usuario da API
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Iterable dataDecode = jsonDecode(response.body);

        final List<UserModel> userList =
            dataDecode.map((userJson) => UserModel.fromMap(userJson)).toList();

        return userList;
      } else {}
    } catch (error, stack) {
      log(
        'Ocorreu um erro ao RESGATAR LISTAGEM de usuários',
        error: error,
        stackTrace: stack,
      );
    }
    return [];
  }

  Future<void> updateUserOnApi(String userId, UserModel updatedUser) async {
    try {
      final uri = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.users + userId,
      );

      final response = await http.put(
        uri,
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: updatedUser.toJson(),
      );

      if (response.statusCode == 200) {
        log(response.body);
      } else {
        throw ("Ocorreu um erro ao tentar atualizar o usuário");
      }
    } catch (error, stack) {
      log(
        'Não foi possível atualizar o usuário.',
        error: error,
        stackTrace: stack,
      );
    }
  }

  Future<void> deleteUserFromApi(String userId) async {
    try {
      final uri = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.users + userId,
      );
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        log("Usuário de ID número: $userId deletado com sucesso");
      } else {
        throw ("Erro ao deletar usuário");
      }
    } catch (error, stack) {
      log(
        'Não foi possível deletar o usuário.',
        error: error,
        stackTrace: stack,
      );
    }
  }
}
