import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forntend/model/user.dart';

// create a class who extends with stateNotifier(access) a object also in null conditions
class UserProvider extends StateNotifier<User?> {
  // CREATE CONSTRUCTOR WITH EMTPY OBJECT
  UserProvider()
      : super(User(
          id: '',
          email: '',
          password: '',
          fullname: '',
          state: '',
          city: '',
          locality: '',
          token: '',
        ));
  // CREATE A GETTER WHO ACCESS THE CURRENT OBJECT STORED IN RIVERPOD
  User? get user => state;
  // CREATE A SETTER CONVERT JSON TO OBJECT FORMAT
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }
}

// MAKE ABLE TO ACCESS WHOLE THE APP
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
