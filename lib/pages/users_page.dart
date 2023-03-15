import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/components/loading_ui_component.dart';
import 'package:firebase_crud/models/api_models.dart';
import 'package:flutter/material.dart';

import '../forms/add_user_form.dart';
import '../forms/edit_user_form.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingUIComponent(
                message: 'Loading Users...',
              ),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            UserRequestModel user = UserRequestModel.fromJson(
                document.data()! as Map<String, dynamic>);
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  EditUserForm.routeName,
                  arguments: user,
                );
              },
              child: ListTile(
                leading: CircleAvatar(child: Text('${user.age}')),
                title: Text(user.name!),
                subtitle: Text(user.city!),
                trailing: IconButton(
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.id);
                    docUser.delete();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          }).toList());
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

  // Stream<List<AddUserRequestModel>> getAllUsers() {
  //   return FirebaseFirestore.instance.collection('users').snapshots().map(
  //       (snapshot) => snapshot.docs
  //           .map<AddUserRequestModel>(
  //               (doc) => AddUserRequestModel.fromJson(doc.data()))
  //           .toList());
  // }

  Stream<QuerySnapshot> getAllUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}

//Stream builder for real time changes or else use Future builder.
