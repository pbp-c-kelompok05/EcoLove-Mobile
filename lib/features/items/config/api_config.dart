import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  static const String pwsUrl = 'https://qanita-syafika-ecolove.pws.cs.ui.ac.id';

  static String get baseUrl {
    if (pwsUrl.isNotEmpty) {
      return pwsUrl;
    }
    // Jika dijalankan di Chrome/Web pakai 127.0.0.1, jika di Emulator Android pakai 10.0.2.2
    return kIsWeb ? 'http://127.0.0.1:8000' : 'http://10.0.2.2:8000';
  }
}