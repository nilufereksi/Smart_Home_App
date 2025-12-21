import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ControlPage extends StatefulWidget {
  final String deviceName;

  const ControlPage({super.key, required this.deviceName});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  // --- ORTAK DEĞİŞKENLER ---
  double sliderValue = 24.0;

  // --- KLİMA DEĞİŞKENLERİ ---
  String acMode = "cool"; // cool, heat, fan
  int fanSpeed = 1; // 1, 2, 3

  // --- TV DEĞİŞKENLERİ ---
  String activeTvApp = ""; // "", "NETFLIX", "YOUTUBE"
  double volumeLevel = 15;

  // --- ALARM DEĞİŞKENLERİ ---
  bool isSystemArmed = true; // Ana Alarm Sistemi
  // Sensörlerin durumu (true: aktif/korumada, false: devre dışı)
  Map<String, bool> alarmSensors = {
    "Ön Kapı": true,
    "Arka Pencere": true,
    "Mutfak": false,
    "Garaj": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.deviceName == "Işıklandırma"
          ? Color.lerp(Colors.black, Colors.yellow[100], (sliderValue - 0) / 100)
          : Colors.grey[300],
      appBar: AppBar(
        title: Hero(
          tag: widget.deviceName,
          child: Material(
            color: Colors.transparent,
            child: Text(widget.deviceName, style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView( // İçerik uzarsa kayabilsin diye
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ----------------------------------------
            // SENARYO 1: KLİMA (Modlar + Fan Hızı)
            // ----------------------------------------
            if (widget.deviceName == "Klima") ...[
              // Derece Göstergesi
              Text(
                "${sliderValue.toInt()}°C",
                style: GoogleFonts.bebasNeue(fontSize: 90),
              ),
              Text(
                acMode == "cool" ? "Soğutma Modu" : (acMode == "heat" ? "Isıtma Modu" : "Fan Modu"),
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              ),
              
              const SizedBox(height: 30),

              // Sıcaklık Slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Slider(
                  value: sliderValue,
                  min: 16,
                  max: 30,
                  activeColor: acMode == "heat" ? Colors.red : (acMode == "cool" ? Colors.blue : Colors.grey),
                  onChanged: (val) => setState(() => sliderValue = val),
                ),
              ),

              const SizedBox(height: 30),

              // Mod Seçimi (Iconlar)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAcModeButton("cool", Icons.ac_unit, Colors.blue),
                  _buildAcModeButton("heat", Icons.local_fire_department, Colors.red),
                  _buildAcModeButton("fan", Icons.air, Colors.grey),
                ],
              ),

              const SizedBox(height: 30),

              // Fan Hızı Ayarı
              Text("Fan Hızı", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFanSpeedButton(1),
                  const SizedBox(width: 20),
                  _buildFanSpeedButton(2),
                  const SizedBox(width: 20),
                  _buildFanSpeedButton(3),
                ],
              ),
            ]

            // ----------------------------------------
            // SENARYO 2: IŞIKLANDIRMA 
            // ----------------------------------------
            else if (widget.deviceName == "Işıklandırma") ...[
              Icon(
                Icons.lightbulb,
                size: 100,
                color: Color.lerp(Colors.grey, Colors.orange, sliderValue / 100),
              ),
              const SizedBox(height: 20),
              Text(
                sliderValue < 20 ? "Karanlık" : (sliderValue > 80 ? "Çok Aydınlık" : "Loş"),
                style: GoogleFonts.bebasNeue(fontSize: 30),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Slider(
                  value: sliderValue.clamp(0, 100),
                  min: 0,
                  max: 100,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey[800],
                  onChanged: (val) => setState(() => sliderValue = val),
                ),
              ),
            ]

            // ----------------------------------------
            // SENARYO 3: TV (Kumanda + İçerik)
            // ----------------------------------------
            else if (widget.deviceName == "TV") ...[
              // TV Ekranı Temsili
              Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade800, width: 4)
                ),
                child: Center(
                  child: activeTvApp == "" 
                    ? const Icon(Icons.tv, color: Colors.grey, size: 50)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(activeTvApp, style: GoogleFonts.bebasNeue(color: activeTvApp == "NETFLIX" ? Colors.red : Colors.white, fontSize: 40)),
                          const Text("Yükleniyor...", style: TextStyle(color: Colors.white54, fontSize: 12))
                        ],
                      ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Ses Seviyesi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    const Icon(Icons.volume_down),
                    Expanded(
                      child: Slider(
                        value: volumeLevel,
                        max: 100,
                        activeColor: Colors.green,
                        onChanged: (val) => setState(() => volumeLevel = val),
                      ),
                    ),
                    const Icon(Icons.volume_up),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Yön Tuşları (D-Pad Simülasyonu)
              // (Burayı biraz sadeleştirdim yer kaplamaması için, istersen geri açabiliriz)
              // Kumanda Tuşları
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRemoteButton("NETFLIX", Colors.red[900]!),
                  const SizedBox(width: 15),
                  _buildRemoteButton("YOUTUBE", Colors.redAccent),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // --- EĞER NETFLIX SEÇİLİYSE ---
              if (activeTvApp == "NETFLIX") ...[
                 Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Align(alignment: Alignment.centerLeft, child: Text("Popüler Filmler", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                ),
                // Yükseklik hatasını çözmek için height artırıldı
                SizedBox(
                  height: 240, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: fakeMovies.length,
                    itemBuilder: (context, index) => _buildMovieCard(fakeMovies[index]),
                  ),
                ),
              ]
              // --- EĞER YOUTUBE SEÇİLİYSE ---
              else if (activeTvApp == "YOUTUBE") ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Align(alignment: Alignment.centerLeft, child: Text("Önerilen Kanallar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                ),
                SizedBox(
                  height: 180, // Yükseklik yeterli
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: fakeYoutubeChannels.length,
                    // BURASI ÖNEMLİ: YouTube listesi için doğru fonksiyonu çağırıyoruz
                    itemBuilder: (context, index) => _buildYoutubeCard(fakeYoutubeChannels[index]),
                  ),
                ),
              ]
            ]

            // ----------------------------------------
            // SENARYO 4: ALARM (Switchler ve Log)
            // ----------------------------------------
            else if (widget.deviceName == "Alarm") ...[
              // Ana Sistem Switch
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSystemArmed ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isSystemArmed ? "SİSTEM KORUMADA" : "SİSTEM DEVRE DIŞI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: isSystemArmed ? Colors.green[800] : Colors.red[800],
                        fontSize: 16
                      ),
                    ),
                    CupertinoSwitch(
                      value: isSystemArmed, 
                      onChanged: (val) => setState(() => isSystemArmed = val)
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
              
              // Sensör Listesi (Switch'li)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: alarmSensors.keys.map((sensorName) {
                    return Card(
                      child: SwitchListTile(
                        title: Text(sensorName),
                        secondary: Icon(Icons.sensor_window, color: Colors.grey[700]),
                        value: alarmSensors[sensorName]!,
                        onChanged: isSystemArmed ? (val) {
                          setState(() {
                            alarmSensors[sensorName] = val;
                          });
                        } : null, // Sistem kapalıysa switchler çalışmaz
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              
              // Log Kayıtları
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Güvenlik Kayıtları", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(),
                    _buildLogTile("14:45", "ALARM TETİKLENDİ! (Mutfak)", isWarning: true),
                    _buildLogTile("14:30", "Zil Çaldı (Kamera Kaydı)"),
                    _buildLogTile("12:15", "Sistem Kuruldu"),
                    _buildLogTile("08:00", "Ön Kapı Açıldı"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }

  // --- YARDIMCI WIDGET'LAR ---

  // Klima Mod Butonu
  Widget _buildAcModeButton(String mode, IconData icon, Color color) {
    bool isSelected = acMode == mode;
    return GestureDetector(
      onTap: () => setState(() => acMode = mode),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)]
        ),
        child: Icon(icon, color: isSelected ? Colors.white : Colors.grey, size: 30),
      ),
    );
  }

  // Fan Hızı Butonu
  Widget _buildFanSpeedButton(int speed) {
    bool isSelected = fanSpeed == speed;
    return GestureDetector(
      onTap: () => setState(() => fanSpeed = speed),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text("Hız $speed", style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }

  // TV Kumanda Butonu
  Widget _buildRemoteButton(String title, Color color) {
    return GestureDetector(
      onTap: () => setState(() => activeTvApp = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, offset: const Offset(2, 2))]
        ),
        child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Film Afişi Kartı (İNTERNET RESİMLİ)
  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        // DETAY SAYFASI
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Afiş (Büyük)
                      Container(
                        height: 150, width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          // İNTERNETTEN RESİM ÇEKİYORUZ:
                          image: DecorationImage(image: NetworkImage(movie.imageUrl), fit: BoxFit.cover, 
                          onError: (exception, stackTrace) {}) 
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie.title, style: GoogleFonts.bebasNeue(fontSize: 30)),
                            const SizedBox(height: 5),
                            Row(children: [const Icon(Icons.star, color: Colors.amber, size: 20), Text(" ${movie.rating}", style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 15), const Icon(Icons.access_time, size: 20, color: Colors.grey), Text(" ${movie.duration}") ]),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Özet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(movie.description, style: TextStyle(color: Colors.grey[600], height: 1.5)),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.all(15)),
                      onPressed: () {
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${movie.title} TV'ye yansıtılıyor...")));
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("TV'de Oynat"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 120, // Genişliği biraz artırdık
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170, // Resim alanını yükselttik
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15),
                 // İNTERNETTEN RESİM:
                 image: DecorationImage(image: NetworkImage(movie.imageUrl), fit: BoxFit.cover, 
                 onError: (a,b){}),
              ),
            ),
            const SizedBox(height: 8),
            Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(movie.rating, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // --- YOUTUBE KARTI (KANAL - YUVARLAK) ---
  Widget _buildYoutubeCard(YoutubeChannel channel) {
    return GestureDetector(
      onTap: () {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${channel.name} kanalı açılıyor...")));
      },
      child: Container(
        width: 120, margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              height: 100, width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                color: Colors.white,
                // İNTERNETTEN RESİM:
                image: DecorationImage(image: NetworkImage(channel.imageUrl), fit: BoxFit.cover), 
                border: Border.all(color: Colors.red, width: 2)
              ),
            ),
            const SizedBox(height: 10),
            Text(channel.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(channel.subscribers, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLogTile(String time, String message, {bool isWarning = false}) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(children: [Icon(isWarning ? Icons.warning : Icons.access_time, size: 16, color: isWarning ? Colors.red : Colors.grey), const SizedBox(width: 5), Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black)), const SizedBox(width: 10), Expanded(child: Text(message, style: TextStyle(color: isWarning ? Colors.red : Colors.black)))]));
  }
}

// --- DATA MODELLERİ (YENİ - URL DESTEKLİ) ---
class Movie {
  final String title;
  final String duration;
  final String rating;
  final String description;
  final String imageUrl; // Artık URL kullanıyoruz

  Movie(this.title, this.duration, this.rating, this.description, this.imageUrl);
}

class YoutubeChannel {
  final String name, subscribers, imageUrl;
  YoutubeChannel(this.name, this.subscribers, this.imageUrl);
}

// --- FAKE DATA (GERÇEK RESİM URL'LERİ) ---
// --- FAKE DATA (GÜNCELLENMİŞ LİNKLER) ---
List<Movie> fakeMovies = [
  Movie(
    "Interstellar", 
    "2s 49dk", 
    "IMDB: 8.7", 
    "İnsanlığın sonu yaklaşırken, bir grup astronot yaşanabilir başka gezegenler bulmak için bir solucan deliğinden geçerler.", 
    "https://image.tmdb.org/t/p/original/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg" // Yeni Link
  ),
  Movie(
    "Inception", 
    "2s 28dk", 
    "IMDB: 8.8", 
    "Dom Cobb, yetenekli bir hırsızdır. Uzmanlık alanı, zihnin en savunmasız olduğu rüya anında sırları çalmaktır.", 
    "https://image.tmdb.org/t/p/original/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg" // Yeni Link
  ),
  Movie(
    "The Matrix", 
    "2s 16dk", 
    "IMDB: 8.7", 
    "Bir bilgisayar korsanı, yaşadığı dünyanın aslında kötü niyetli bir siber zeka tarafından simüle edildiğini keşfeder.", 
    "https://image.tmdb.org/t/p/original/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg" // Çalışan Link
  ),
  Movie(
    "Joker", 
    "2s 2dk", 
    "IMDB: 8.4", 
    "Toplum tarafından dışlanan Arthur Fleck, yavaş yavaş deliliğin derinliklerine sürüklenir.", 
    "https://image.tmdb.org/t/p/original/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg" // Yeni Link
  ),
];

// ---FAKE DATA  (YOUTUBE KANALLARI) ---
List<YoutubeChannel> fakeYoutubeChannels = [
  YoutubeChannel(
    "Flutter Dev", 
    "550K Abone", 
    "https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png" // Resmi Flutter Logosu
  ),
  YoutubeChannel(
    "Yazılım Günlüğü", 
    "1.2M Abone", 
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&h=200" // Gözlüklü Yazılımcı Fotosu
  ),
  YoutubeChannel(
    "Teknoloji Evreni", 
    "850K Abone", 
    "https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?auto=format&fit=crop&w=200&h=200" // Kodlama Ekranı
  ),
  YoutubeChannel(
    "Doğa Gezgini", 
    "2.5M Abone", 
    "https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=200&h=200" // Gezgin Fotosu
  ),
];



