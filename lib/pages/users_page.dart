import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/api_models.dart';
import 'package:flutter/material.dart';

import '../forms/add_user_form.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FIREBASE CRUD',
        ),
        actions: [
          IconButton(
            onPressed: () {
              final name = nameController.text;
              addToFirebase(name);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, AddUserForm.routeName);
        },
        label: const Text('Add a User'),
      ),
    );
  }

  addToFirebase(String name) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    //using JSON
    // final json = {
    //   'name': name,
    //   'age': 24,
    //   'birthday': DateTime(1998, 10, 17),
    // };
    // await docUser.set(json);

    //Using request model
    // final user = AddUserRequestModel(
    //     id: docUser.id, name: name, age: 21, birthday: DateTime(2017, 9, 7));
    // await docUser.set(user.toJson());
  }
}
