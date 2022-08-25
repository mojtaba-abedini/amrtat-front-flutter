
import 'package:flutter/foundation.dart' show kIsWeb;


const baseUrl = kIsWeb ? 'http://localhost:8000/api' : 'http://10.0.2.2:8000/api';

const getAllJens = '${baseUrl}/jens';
const getAllSize = '${baseUrl}/sizes';