import 'package:device_preview/device_preview.dart'; 
import 'package:flutter/foundation.dart'; //kReleaseMode değişkeni için-uyg. hangi modda çalıştığı
import 'package:flutter/material.dart'; //widgetler - temel kullanıcı arayüzü
import 'pages/home_page.dart'; //ana sayfayı import etmek için


void main() {
  runApp(
    DevicePreview( //widget
      enabled: !kReleaseMode, //önizlemeyi aktifleştir
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { //sınıf
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { //build methodunda materialApp döndürür
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      

      home: HomePage(), //uyg. giriş sayfasını HomePage widgetine atamak için
    );
  }
}