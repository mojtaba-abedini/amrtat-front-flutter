
import 'package:flutter/foundation.dart' show kIsWeb;


const baseUrl = kIsWeb ? 'http://localhost:8000/api' : 'http://10.0.2.2:8000/api';

const getAllJens = '${baseUrl}/jens';
const getAllSize = '${baseUrl}/sizes';
const getAllVahed = '${baseUrl}/vahed';
const createVahed = '${baseUrl}/vahed';
const editVahed = '${baseUrl}/vahed';
const deleteVahed = '${baseUrl}/vahed';



const getAllBank = '${baseUrl}/banks';
const createBank = '${baseUrl}/banks';
const editBank = '${baseUrl}/banks';
const deleteBank = '${baseUrl}/banks';