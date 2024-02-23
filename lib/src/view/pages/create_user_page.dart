import 'package:flutter/material.dart';
import 'package:projeto_flutter/src/controller/provider/users_provider.dart';
import 'package:projeto_flutter/src/models/user_model.dart';
import 'package:provider/provider.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Usuário'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 30.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    label: Text("Usuário"),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("E-mail"),
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    label: Text("Telefone"),
                  ),
                ),
                TextFormField(
                  controller: _websiteController,
                  decoration: const InputDecoration(
                    label: Text("Website"),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: FilledButton(
                    child: const Text("Salvar Novo Usuário"),
                    onPressed: () {
                      final UserModel newUser = UserModel(
                        name: _nameController.text,
                        username: _emailController.text,
                        email: _emailController.text,
                        phone: _emailController.text,
                        website: _emailController.text,
                      );

                      Provider.of<UsersProvider>(context, listen: false)
                          .createNewUser(newUser)
                          .then(
                            (value) => {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:
                                      const Text("Usuário Criado com Sucesso"),
                                  actions: [
                                    TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        }),
                                  ],
                                ),
                              ),
                            },
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
