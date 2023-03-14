import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/loading_ui_component.dart';
import '../models/api_models.dart';

class EditUserForm extends StatefulWidget {
  final UserRequestModel? userRequestModel;
  const EditUserForm({required this.userRequestModel, super.key});
  static const routeName = '/editUserForm';

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  UserRequestModel addUserRequestModel = UserRequestModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  UserRequestModel? user;

  @override
  void initState() {
    super.initState();
    user = widget.userRequestModel;
    debugPrint(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('UPDATE USER DETAILS'),
        ),
        body: (isAPICallProcess)
            ? const Center(
                child: LoadingUIComponent(
                  message: 'Updating user...',
                ),
              )
            : GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    currentFocus.focusedChild?.unfocus();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 40,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  initialValue: user!.name!,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a suitable name.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    addUserRequestModel.name = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  initialValue: user!.age!.toString(),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Age',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a  proper age.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    addUserRequestModel.age =
                                        int.tryParse(value!);
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  initialValue: user!.city!,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a proper city name.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    addUserRequestModel.city = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'CANCEL',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _submitCommand();
                              },
                              child: const Text(
                                'SAVE',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<bool> _submitCommand() async {
    final form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        setState(() {
          isAPICallProcess = true;
        });

        final docUser = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.id); //will update for that specific id
        debugPrint(addUserRequestModel.toJson().toString());
        await docUser.update(addUserRequestModel.toJson()).then((_) {
          setState(() {
            isAPICallProcess = false;
          });
          Navigator.pop(context);
          SnackBar snackBar = const SnackBar(
            content: Text('User updated successfully.'),
          );
          ScaffoldMessenger.of(scaffoldKey.currentContext!)
              .showSnackBar(snackBar);
        });

        return true;
      }
    }
    debugPrint('Form is null');
    return false;
  }
}
