
import 'package:flutter/foundation.dart' show kIsWeb;


const baseUrl = kIsWeb ? 'http://localhost:8000/api' : 'http://10.0.2.2:8000/api';

const JensApi = '${baseUrl}/jens';

const SizeApi = '${baseUrl}/sizes';

const VahedApi = '${baseUrl}/vahed';

const BankApi = '${baseUrl}/banks';

const StoreApi = '${baseUrl}/store';

const GramApi = '${baseUrl}/gram';

const PaperPriceApi = '${baseUrl}/paperprice';

const ShitSizeApi= '${baseUrl}/shits';

const ServicePriceApi= '${baseUrl}/service';

const KarbariApi= '${baseUrl}/karbari';
