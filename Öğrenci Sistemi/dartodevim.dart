import 'package:flutter/material.dart';
import 'dart:async'; // Timer sınıfını kullanabilmek için ekledik

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Öğrenci Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Uygulama başlatıldığında LoginScreen gösterilecek
    );
  }
}

// Giriş ekranı widget'ı burada 
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String correctUsername = 'emirhan'; // Doğru kullanıcı adı
  final String correctPassword = 'atakan'; // Doğru şifre
  String enteredUsername = ''; // Kullanıcı tarafından girilen kullanıcı adı
  String enteredPassword = ''; // Kullanıcı tarafından girilen şifre

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                enteredUsername = value; // Kullanıcı adı değiştiğinde güncelle
              },
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                enteredPassword = value; // Şifre değiştiğinde güncelle
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kullanıcı adı ve şifre kontrolü
                if (enteredUsername == correctUsername && enteredPassword == correctPassword) {
                  // Doğruysa, öğrenci sistemine yönlendir
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentSystem(
                      username: 'Emirhan Atakan',
                      school: 'Örnek Okul',
                      department: 'Örnek Bölüm',
                    )),
                  );
                } else {
                  // Yanlışsa, hata mesajı göster
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Hata'),
                        content: Text('Kullanıcı adı veya şifre hatalı!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Giriş'),
            ),
          ],
        ),
      ),
    );
  }
}

// Öğrenci sistemi widget'ı
class StudentSystem extends StatefulWidget {
  final String username; // Kullanıcı adı
  final String school; // Okul adı
  final String department; // Bölüm adı

  const StudentSystem({
    Key? key,
    required this.username,
    required this.school,
    required this.department,
  }) : super(key: key);

  @override
  _StudentSystemState createState() => _StudentSystemState();
}

class _StudentSystemState extends State<StudentSystem> {
  int _selectedIndex = 0; // Seçilen ekranın indeksi

  // Ekran seçenekleri
  static List<Widget> _widgetOptions = <Widget>[
    WeeklyScheduleScreen(),
    LessonNotesScreen(),
    AttendanceScreen(),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Başarı, zorluklarla dolu bir yoldur,',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'ancak bu yolda yılmadan ilerleyenler,',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'sonunda hedeflerine ulaşırlar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    GradeCalculationScreen(),
    HomeworkScreen(),
    StudyTimeScreen(),
  ];

  // Alt menüdeki butona tıklanınca ekran değiştirme işlemi
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Sistemi'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Seçilen ekranı göster
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Ders Programı',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Ders Notları',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Devamsızlık',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Puan Hesapla',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notlarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Ders Saati',
          ),
        ],
        currentIndex: _selectedIndex, // Seçilen menü elemanının indeksi
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped, // Menü elemanına tıklanınca yapılacak işlem
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Haftalık ders programı ekranı
class WeeklyScheduleScreen extends StatefulWidget {
  @override
  _WeeklyScheduleScreenState createState() => _WeeklyScheduleScreenState();
}

class _WeeklyScheduleScreenState extends State<WeeklyScheduleScreen> {
  List<String> daysOfWeek = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'];
  Map<String, String> dailySchedule = {}; // Günlük ders programı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haftalık Ders Programı'),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = daysOfWeek[index];
          return ListTile(
            title: Text(day),
            subtitle: TextFormField(
              decoration: InputDecoration(
                hintText: 'Ders Adı ve Saati Girin',
              ),
              onChanged: (value) {
                setState(() {
                  dailySchedule[day] = value; // Günlük programı güncelle
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(dailySchedule); // Ders programını konsola yazdır
          // Burada günlük ders programını saklamak için yapılacak işlemler eklenebilir.
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

// Ders notları ekranı
class LessonNotesScreen extends StatefulWidget {
  @override
  _LessonNotesScreenState createState() => _LessonNotesScreenState();
}

class _LessonNotesScreenState extends State<LessonNotesScreen> {
  List<String> notes = []; // Notlar listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders Notları'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String tempNote = '';
              return AlertDialog(
                title: Text('Yeni Not Ekle'),
                content: TextField(
                  onChanged: (value) {
                    tempNote = value; // Yeni notu güncelle
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(tempNote); // Notu ekle ve dialogu kapat
                    },
                    child: Text('Ekle'),
                  ),
                ],
              );
            },
          );
          if (newNote != null && newNote.isNotEmpty) {
            setState(() {
              notes.add(newNote); // Yeni notu listeye ekle
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Devamsızlık ekranı
class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Map<String, int> attendance = {
   'İstemci Taraflı Programlama': 0,
    'Veri Tabanı': 0,
    'Veri Yapıları': 0,
    'Nesne Tabanlı Programlama': 0,
    'Mobil Programlama': 0,
  }; // Derslere göre devamsızlık sayıları

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devamsızlık'),
      ),
      body: ListView.builder(
        itemCount: attendance.keys.length,
        itemBuilder: (context, index) {
          final subject = attendance.keys.elementAt(index);
          final devamsizlikSayisi = attendance[subject]!;
          return ListTile(
            title: Text(subject),
            subtitle: Text('Devamsızlık Sayısı: $devamsizlikSayisi'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  // Devamsızlık sayısını artır ve eğer belirli bir sınırı aşıyorsa uyarı göster
                  if (attendance[subject]! < 4) {
                    attendance[subject] = devamsizlikSayisi + 1;
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Uyarı'),
                          content: Text('Bu dersten kaldınız!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}

// Not hesaplama ekranı
class GradeCalculationScreen extends StatefulWidget {
  @override
  _GradeCalculationScreenState createState() => _GradeCalculationScreenState();
}

class _GradeCalculationScreenState extends State<GradeCalculationScreen> {
  double exam1 = 0; // 1. sınav notu
  double exam2 = 0; // 2. sınav notu
  double butExam = 0; //  Büt sınavı notu
  double result = 0; // Hesaplanan sonuç

  // Not hesaplama fonksiyonu
  void calculateGrade() {
    setState(() {
      result = (exam1 * 0.4) + (exam2 * 0.6) + (butExam * 1.0); // Not hesaplama formülü
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Hesaplama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: '1. Sınav Notu'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                exam1 = double.tryParse(value) ?? 0; // 1. sınav notunu al
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: '2. Sınav Notu'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                exam2 = double.tryParse(value) ?? 0; // 2. sınav notunu al
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Büt Notu'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                butExam = double.tryParse(value) ?? 0; // Final notunu al
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateGrade, // Hesapla butonuna basıldığında not hesapla
              child: Text('Hesapla'),
            ),
            SizedBox(height: 20),
            Text('Sonuç: $result'), // Hesaplanan sonucu göster
          ],
        ),
      ),
    );
  }
}

// Ödevler ekranı
class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  List<String> homeworkList = []; // Ödevler listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödevlerim'),
      ),
      body: ListView.builder(
        itemCount: homeworkList.length,
        itemBuilder: (context, index) {
          final homework = homeworkList[index];
          return ListTile(
            title: Text(homework), // Ödevi listede göster
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHomework = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String tempHomework = '';
              return AlertDialog(
                title: Text('Yeni Ödev Ekle'),
                content: TextField(
                  onChanged: (value) {
                    tempHomework = value; // Yeni ödevi güncelle
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(tempHomework); // Ödevi ekle ve dialogu kapat
                    },
                    child: Text('Ekle'),
                  ),
                ],
              );
            },
          );
          if (newHomework != null && newHomework.isNotEmpty) {
            setState(() {
              homeworkList.add(newHomework); // Yeni ödevi listeye ekle
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Ders çalışma saati ekranı
class StudyTimeScreen extends StatefulWidget {
  @override
  _StudyTimeScreenState createState() => _StudyTimeScreenState();
}

class _StudyTimeScreenState extends State<StudyTimeScreen> {
  Timer? timer; // Zamanlayıcı
  int seconds = 0; // Geçen süre

  // Zamanlayıcıyı başlat
  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  // Zamanlayıcıyı durdur
  void stopTimer() {
    timer?.cancel();
  }

  // Zamanlayıcıyı sıfırla
  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders Saati'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Geçen Süre: $seconds saniye'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startTimer, // Başlat butonuna basıldığında zamanlayıcıyı başlat
                child: Text('Başlat'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: stopTimer, // Durdur butonuna basıldığında zamanlayıcıyı durdur
                child: Text('Durdur'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: resetTimer, // Sıfırla butonuna basıldığında zamanlayıcıyı sıfırla
                child: Text('Sıfırla'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}