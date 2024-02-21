import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/controller/provider/users_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    usersProvider.getUsersList();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Lista de Usuários'),
        ),
      ),
      body: usersProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: usersProvider.userList.length,
              itemBuilder: (context, index) {
                UserModel users = usersProvider.userList[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(users.id.toString())),
                  title: Text(users.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(users.email),
                      Text(
                        users.phone,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
    );
  }
}
