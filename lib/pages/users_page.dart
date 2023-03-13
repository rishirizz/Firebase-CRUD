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
}
