import 'package:flutter/material.dart';
import 'package:magicslide/core/services/supabase_service.dart';


class LoginViewModel extends ChangeNotifier {
  bool loading = false;
  String? error;


  Future<bool> login(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();


    try {
      final res = await SupabaseService.signIn(email, password);
      loading = false;
      notifyListeners();


      return res.session != null;
    } catch (_) {
      loading = false;
      error = "Login failed";
      notifyListeners();
      return false;
    }
  }
}