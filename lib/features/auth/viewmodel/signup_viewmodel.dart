import 'package:flutter/material.dart';
import 'package:magicslide/core/services/supabase_service.dart';


class SignupViewModel extends ChangeNotifier {
  bool loading = false;
  String? error;


  Future<bool> signup(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();


    try {
      final res = await SupabaseService.signUp(email, password);
      loading = false;
      notifyListeners();


      return res.user != null || res.session != null;
    } catch (_) {
      loading = false;
      error = "Signup failed";
      notifyListeners();
      return false;
    }
  }
}