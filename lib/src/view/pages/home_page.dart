import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:projeto_flutter/src/controller/provider/users_provider.dart';
import 'package:projeto_flutter/src/view/pages/create_user_page.dart';
import 'package:projeto_flutter/src/view/pages/update_user_page.dart';

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
                UserModel user = usersProvider.userList[index];
                return ListTile(
                  tileColor: index.isEven
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
                      : Colors.transparent,
                  leading: CircleAvatar(
                    child: Text(
                      user.id.toString(),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email),
                      Text(
                        user.phone,
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => UpdateUserPage(
                              user: user,
                            )),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Atenção!"),
                        content: Text(
                            "Tem certeza que deseja deletar o usuário ${user.name}?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Sim, eu quero deletar!"),
                            onPressed: () {
                              Provider.of<UsersProvider>(context, listen: false)
                                  .deleteUser(user.id.toString())
                                  .then((_) => Navigator.of(context).pop());
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateUserPage(),
            ),
          );
        },
      ),
    );
  }
}
