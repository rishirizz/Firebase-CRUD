import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/components/loading_ui_component.dart';
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
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FIREBASE CRUD',
        ),
      ),
      body: StreamBuilder<List<AddUserRequestModel>>(
        stream: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<AddUserRequestModel> users =
                snapshot.data as List<AddUserRequestModel>;
            return ListView(
                children: users.map((user) {
              return ListTile(
                leading: CircleAvatar(child: Text('${user.age}')),
                title: Text(user.name!),
                subtitle: Text(user.city!),
              );
            }).toList());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Something went wrong.'));
          } else {
            return const LoadingUIComponent(message: 'Loading Users...');
          }
        },
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

  Stream<List<AddUserRequestModel>> getAllUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapshot) => snapshot.docs
            .map<AddUserRequestModel>(
                (doc) => AddUserRequestModel.fromJson(doc.data()))
            .toList());
  }
}

//Stream builder for real time changes or else use Future builder.
