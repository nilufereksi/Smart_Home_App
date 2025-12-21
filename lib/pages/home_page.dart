import 'package:flutter/material.dart';
import 'package:random/pages/control_page.dart';
import 'package:random/util/smart_device_box.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Padding sabitleri
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  
  // Drawer (Yan Menü) için Anahtar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Akıllı cihazların listesi
  List mySmartDevices = [
    // [smartDeviceName, iconPath, powerStatus]
    ["Işıklandırma", "assets/icons/light-bulb.png", true],
    ["Klima", "assets/icons/air-conditioner.png", false],
    ["TV", "assets/icons/smart-tv.png", false],
    ["Alarm", "assets/icons/alarm.png", false],
  ];

  // Güç tuşu basıldı
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  // Profil Diyaloğunu Gösteren Fonksiyon
  void showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 15),
            Text("Nilüfer", style: GoogleFonts.bebasNeue(fontSize: 30, letterSpacing: 2)),
            const Text("Yazılım Mühendisliği Öğrencisi", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Divider(height: 30, thickness: 1),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("nilufer@university.edu"),
              dense: true,
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("+90 555 000 00 00"),
              dense: true,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () => Navigator.pop(context),
              child: const Text("Kapat", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Menüyü açmak için gerekli anahtar
      backgroundColor: Colors.grey[300],
      
      // --- YAN MENÜ (DRAWER) ---
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 60),
                    const SizedBox(height: 10),
                    Text("N İ L Ü F E R", style: GoogleFonts.bebasNeue(fontSize: 30)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("A N A  S A Y F A"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.devices),
              title: const Text("C İ H A Z L A R"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("A Y A R L A R"),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Ç I K I Ş", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Özel Uygulama Çubuğu (AppBar) ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menu ikonu (Drawer'ı tetikler)
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'lib/icons/menu.png',
                      height: 45,
                      color: Colors.grey[800],
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.menu, size: 45, color: Colors.grey[800]),
                    ),
                  ),

                  // Hesap ikonu (Profili açar)
                  GestureDetector(
                    onTap: showProfileDialog,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Eve Hoşgeldin ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Eve Hoşgeldin,",
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  Text(
                    "Nilüfer :)",
                    style: GoogleFonts.bebasNeue(fontSize: 56),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const Divider(color: Colors.grey, thickness: 1),
            ),

            const SizedBox(height: 25),

            // --- Grid View Header ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Akıllı Cihazlar,",
                style: GoogleFonts.bebasNeue(
                  fontWeight: FontWeight.bold,
                  fontSize: 44,
                  color: Colors.grey[800],
                ),
              ),
            ),
            
            const SizedBox(height: 10),

            // --- Grid View (Kutular) ---
            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => powerSwitchChanged(value, index),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ControlPage(
                            deviceName: mySmartDevices[index][0],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}