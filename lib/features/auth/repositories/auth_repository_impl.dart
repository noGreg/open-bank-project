import 'auth_repository.dart';

/// Repository which manages user authentication.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  // Stream<User> get user {
  //   return _firebaseAuth.userChanges().map((firebaseUser) {
  //     final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
  //     return user;
  //   });
  // }

  /// Creates a new user with the provided [name], [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  @override
  Future<void> logInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  /// Delete account of the current user
  ///
  /// Throws a [DeleteAcouuntFailure] if an exception occurs.
  ///
  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  /// Delete account of the current user
  ///
  /// Throws a [DeleteAcouuntFailure] if an exception occurs.
  ///
  @override
  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
