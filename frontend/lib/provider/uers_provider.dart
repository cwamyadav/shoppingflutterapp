import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/user.dart';

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

  void signout() {
    state = null;
  }

  // method to recrreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id,
        email: this.state!.email,
        password: this.state!.password,
        fullname: this.state!.fullname,
        state: state,
        city: city,
        locality: locality,
        token: this.state!.token,
      );
    }
  }
}

// MAKE ABLE TO ACCESS WHOLE THE APP
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
