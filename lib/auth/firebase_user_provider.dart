import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CoreFirebaseUser {
  CoreFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

CoreFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CoreFirebaseUser> coreFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CoreFirebaseUser>((user) => currentUser = CoreFirebaseUser(user));
