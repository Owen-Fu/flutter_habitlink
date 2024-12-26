import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthStrategy {
  Future<void> signIn();

  Future<void> signOut();
}

class GoogleAuthStrategy implements AuthStrategy {
  @override
  Future<void> signIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Google Sign-In canceled');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();
}

class AppleAuthStrategy implements AuthStrategy {
  @override
  Future<void> signIn() async {
    // Step 1: 使用 SignInWithApple 插件獲取 Apple ID 憑證
    final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.example.flutterHabitlink.auth',
        redirectUri: Uri.parse(
          'https://ubiquitous-splendid-preface.glitch.me/callbacks/sign_in_with_apple',
          // 'https://flutter-habitlink.firebaseapp.com/__/auth/handler', // 替換為 Firebase 的回調 URI
        ),
      ),
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Step 2: 將 Apple ID 憑證轉換為 Firebase Credential
    final OAuthCredential firebaseCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken, // Apple 提供的身份驗證令牌
      accessToken: appleCredential.authorizationCode, // 授權碼
    );

    // Step 3: 使用 Firebase 進行登入
    await FirebaseAuth.instance.signInWithCredential(firebaseCredential);
  }

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();
}

class AuthContext {
  final AuthStrategy authStrategy;

  AuthContext(this.authStrategy);

  Future<void> signIn() {
    return authStrategy.signIn();
  }
}
