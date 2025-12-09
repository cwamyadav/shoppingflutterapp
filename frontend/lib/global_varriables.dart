import 'package:flutter_dotenv/flutter_dotenv.dart';
final String uri = dotenv.env['API_URL'] ?? 'http://localhost:3000';
