import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'providers/provider_service.dart';

class FirebaseDatasource implements AuthDatasource {
  final FirebaseAuth firebaseAuth;
  final ProviderService provider;

  FirebaseDatasource({this.provider, this.firebaseAuth});

  @override
  Future<LoggedUser> getLoggedUser() async {
    final user = firebaseAuth?.currentUser;

    if (user == null) {
      return null;
    }

    return _userFactory(
      FirebaseAuth.instance.currentUser,
      _getProviderLogin(user.providerData),
    );
  }

  List<ProviderLogin> _getProviderLogin(List<UserInfo> userInfos) {
    return userInfos.map((userInfo) {
      if (userInfo.providerId == 'google.com') {
        ProviderLogin.google.name = userInfo.displayName;
        ProviderLogin.google.email = userInfo.email;
        return ProviderLogin.google;
      } else if (userInfo.providerId == 'facebook.com') {
        ProviderLogin.facebook.name = userInfo.displayName;
        ProviderLogin.facebook.email = userInfo.email;
        return ProviderLogin.facebook;
      } else if (userInfo.providerId == 'apple.com') {
        ProviderLogin.appleId.name = userInfo.displayName;
        ProviderLogin.appleId.email = userInfo.email;
        return ProviderLogin.appleId;
      } else {
        return null;
      }
    }).toList();
  }

  @override
  Future<LoggedUser> loginWithAppleId() async {
    AuthorizationCredentialAppleID credenctial;
    try {
      credenctial = await provider.appleAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }
    var oAuthProvider = OAuthProvider('apple.com');
    var cred = oAuthProvider.credential(
      idToken: credenctial.identityToken,
      accessToken: credenctial.authorizationCode,
    );

    var result = await firebaseAuth.signInWithCredential(cred);

    result = await result.user.reauthenticateWithCredential(cred);

    if (credenctial.email != null && credenctial.givenName != null) {
      await result.user.updateEmail(credenctial.email);
      await result.user.updateProfile(
          displayName: '${credenctial.givenName} ${credenctial.familyName}');

      return LoggedUser(
        name: '${credenctial.givenName} ${credenctial.familyName}',
        email: result.user.email,
        providers: [ProviderLogin.appleId],
        token: await result.user.getIdToken(true),
      );
    }

    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  @override
  Future<LoggedUser> loginWithFacebook() async {
    FacebookAuthCredential credenctial;
    try {
      credenctial = await provider.facebookAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }
    await provider.facebookSignIn.logOut();
    var result = await FirebaseAuth.instance.signInWithCredential(credenctial);
    result = await result.user.reauthenticateWithCredential(credenctial);
    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  @override
  Future<LoggedUser> loginWithGoogle() async {
    GoogleSignInAuthentication credenctial;
    try {
      credenctial = await provider.googleAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: credenctial.accessToken,
      idToken: credenctial.idToken,
    );

    await provider.googleSignIn.signOut();
    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    result = await result.user.reauthenticateWithCredential(credential);
    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  Future<LoggedUser> _userFactory(
      User firebaseUser, List<ProviderLogin> providers) async {
    final token = await firebaseUser.getIdToken(true);
    return LoggedUser(
      email: firebaseUser?.email,
      name: firebaseUser?.displayName,
      urlPhoto: firebaseUser?.photoURL,
      token: token,
      providers: providers,
    );
  }

  @override
  Future<int> logout() async {
    await firebaseAuth.signOut();
    return 0;
  }

  @override
  Future<LoggedUser> unlinkAccount(ProviderLogin provider) async {
    var user = firebaseAuth.currentUser;
    if (user == null) {
      throw NotUserLogged();
    }
    switch (provider) {
      case ProviderLogin.google:
        user = await user.unlink('google.com');
        break;
      case ProviderLogin.facebook:
        user = await user.unlink('facebook.com');
        break;
      case ProviderLogin.appleId:
        user = await user.unlink('apple.com');
        break;
      default:
        return null;
    }

    return _userFactory(user, _getProviderLogin(user.providerData));
  }

  @override
  Future<LoggedUser> linkAccount(ProviderLogin providerLogin) {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw NotUserLogged();
    }

    switch (providerLogin) {
      case ProviderLogin.google:
        return _linkGoogle(user);
      case ProviderLogin.facebook:
        return _linkFacebook(user);
      case ProviderLogin.appleId:
        return _linkAppleId(user);
      default:
        return null;
    }
  }

  Future<LoggedUser> _linkGoogle(User user) async {
    GoogleSignInAuthentication credenctial;
    try {
      credenctial = await provider.googleAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: credenctial.accessToken,
      idToken: credenctial.idToken,
    );

    await provider.googleSignIn.signOut();
    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e?.code == 'credential-already-in-use') {
        throw DuplicatedAccountProviderError(
            message: 'firebaseDatasource.ErrorCredentialsMessage');
      }
      throw Exception();
    }

    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  Future<LoggedUser> _linkFacebook(User user) async {
    FacebookAuthCredential credential;
    try {
      credential = await provider.facebookAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }
    await provider.facebookSignIn.logOut();
    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e?.code == 'credential-already-in-use') {
        throw DuplicatedAccountProviderError(
            message: 'firebaseDatasource.ErrorCredentialsMessage');
      }
      throw Exception();
    }

    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  Future<LoggedUser> _linkAppleId(User user) async {
    AuthorizationCredentialAppleID credenctial;
    try {
      credenctial = await provider.appleAuth();
    } catch (e) {
      throw CredentialsError(message: 'firebaseDatasource.credentialError');
    }

    var oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: credenctial.identityToken,
      accessToken: credenctial.authorizationCode,
    );

    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e?.code == 'credential-already-in-use') {
        throw DuplicatedAccountProviderError(
            message: 'firebaseDatasource.ErrorCredentialsMessage');
      }
      throw Exception();
    }

    return _userFactory(
        result.user, _getProviderLogin(result.user.providerData));
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await firebaseAuth.currentUser.delete();
    } catch (e) {
      if (e?.code == 'requires-recent-login') {
        throw DeleteAccountError(
            message: 'firebaseDatasource.requiresRecentLogin');
      }
      rethrow;
    }
  }
}
