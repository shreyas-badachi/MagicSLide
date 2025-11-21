import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/constants/constants.dart';


class SupabaseService {
  static late final SupabaseClient client;


  static Future<void> init() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
    client = Supabase.instance.client;
  }


  static Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(email: email, password: password);
  }


  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }


  static Future<void> signOut() async {
    await client.auth.signOut();
  }
}