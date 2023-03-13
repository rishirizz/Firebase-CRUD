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
      body: StreamBuilder<QuerySnapshot>(
        stream: getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            AddUserRequestModel data = document.data()! as AddUserRequestModel;
            return ListTile(
              title: Text(data.name!),
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

  Stream<QuerySnapshot> getAllUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}

//Stream builder for real time changes or else use Future builder.
