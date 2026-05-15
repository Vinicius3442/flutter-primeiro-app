import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = SupabaseService.client.auth.currentUser;
    SupabaseService.client.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
      notifyListeners();
    });
  }

  Future<String?> updateProfileImage(File image) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = _user!.id;
      final fileExtension = image.path.split('.').last;
      final fileName = '$userId.${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      final path = 'avatars/$fileName';

      await SupabaseService.client.storage.from('avatars').upload(
        path,
        image,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
      );

      final imageUrl = SupabaseService.client.storage.from('avatars').getPublicUrl(path);

      await SupabaseService.client.auth.updateUser(
        UserAttributes(data: {'avatar_url': imageUrl}),
      );

      return null;
    } on StorageException catch (e) {
      return e.message;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await SupabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await SupabaseService.client.auth.signOut();
  }
}
