import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? "";
  static final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? "";
  static final String magicSlidesEndpoint = dotenv.env['MAGICSLIDES_ENDPOINT'] ?? "";
  static final String magicSlidesAccessId = dotenv.env['MAGICSLIDES_ACCESS_ID'] ?? "";
}
