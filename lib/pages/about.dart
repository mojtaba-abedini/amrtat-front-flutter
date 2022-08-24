import 'package:amertat/pages/paper_price.dart';
import 'package:amertat/pages/services_price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطلاعات پایه'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  textAlign: TextAlign.center,
                  """
برند آمرتات در سال 1388 فعالیت خود را در صنعت چاپ و بسته بندی در زمینه تولید ساک دستی و پاکت های تبلیغاتی با هدف رضایت مندی مشتریان آغاز نمود. از برتری های شرکت ما نسبت به سایر رغیب ها میتوان به تخصصی کار کردن در یک محصول اشاره کرد که این کار خود باعث سرعت بیشتر در پیشرفت مجموعه گردیده تا جایی که امروزه به عنوان برندی آشنا با کیفیتی بالا و قیمت مناسب از ما یاد میکنند.

ما بر این باور هستیم که میتوانیم جایگاه والاتری در بازار داشته باشیم استفاده از مواد اولیه استاندارد و تجزیه پذیر از سیاست های اولیه آمرتات میباشداز آنجایی که عزم راسخ و صادقانه شرکت رضایت عمومی از محصولات خویش میباشد لذا با بهره گیری از نیروهای متخصص و متعهد در بخش کنترل کیفی سعی در بالاتر نگهداشتن سطح کیفیت و همگام شدن با استاندارد ها را داریم از جمله فعالیت های این شرکت برای رسیدن به این اهداف میتوان به استفاده از ماشین آلات و مواد اولیه مرغوب و قابل بازیافت اشاره نمود.

ما در شرکت خود تلاش شبانه روزی،نیرو های متخصص،تکنولوژی پیشرفته همه و همه را یکجا گرد هم آورده ایم تا محصولی ایرانی را با کیفیتی جهانی برای جلب رضایت خریداران محترم تولید کنیم.
                """,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
