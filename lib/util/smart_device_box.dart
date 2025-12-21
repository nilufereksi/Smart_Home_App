import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;
  final VoidCallback? onTap;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Dış boşluk ideal seviyeye çekildi
        child: Container(
          decoration: BoxDecoration(
            color: powerOn ? const Color.fromARGB(255, 217, 190, 215) : Colors.grey[200],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0), // İç dikey boşluk
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- İKON KISMI ---
                Expanded( // İkonu esnek alana aldık ki sığsın
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.contain, // Resmi oranını bozmadan sığdırır
                      // color: ...  <-- BU SATIRI SİLDİM, ARTIK ORİJİNAL RENKLER GÖZÜKECEK
                    ),
                  ),
                ),
                
                // --- YAZI VE SWITCH ---
                Padding(
                  padding: const EdgeInsets.only(top: 10.0), // İkon ile yazı arasına biraz boşluk
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: FittedBox( // Yazı taşmasın diye koruma
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              smartDeviceName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: powerOn ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Switch Butonu
                      Transform.rotate(
                        angle: pi / 2,
                        child: CupertinoSwitch(
                          value: powerOn,
                          onChanged: onChanged,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}