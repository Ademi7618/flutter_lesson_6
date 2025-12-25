import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram Drawer',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2AABEE),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: HomePage(
        isDark: isDark,
        onThemeChanged: (value) {
          setState(() => isDark = value);
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telegram Drawer '), elevation: 0),
      drawer: AppDrawer(isDark: isDark, onThemeChanged: onThemeChanged),
      body: const TelegramCallsSplitScreen(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const AppDrawer({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF2AABEE)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF2AABEE)),
                ),
                SizedBox(height: 10),
                Text(
                  'Темиржанова Адеми',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  '+996 702 567 297',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          drawerItem(
            context,
            icon: Icons.chat,
            title: 'Чаты',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          drawerItem(
            context,
            icon: Icons.call,
            title: 'Звонки',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallPage()),
              );
            },
          ),
          drawerItem(
            context,
            icon: Icons.person_2,
            title: 'Контакты',
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Тёмная тема'),
            secondary: const Icon(Icons.dark_mode),
            value: isDark,
            onChanged: onThemeChanged,
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}

class TelegramCallsSplitScreen extends StatelessWidget {
  const TelegramCallsSplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), elevation: 0),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Telegram',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: const [
                ChatTile(name: 'Мама', message: 'Позвони мне', time: '13:58'),
                ChatTile(name: 'Папа', message: 'Чай поставьте', time: '13:53'),
                ChatTile(
                  name: 'Гулля',
                  message: 'Привет! Как дела?',
                  time: '20:30',
                ),
                ChatTile(
                  name: 'Telegram',
                  message: 'Обновление приложения',
                  time: 'Вчера',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CallTile extends StatelessWidget {
  final String name;
  final String time;
  final bool isIncoming;

  const CallTile({
    super.key,
    required this.name,
    required this.time,
    required this.isIncoming,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade200,
        child: Text(name[0]),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time),
      trailing: Icon(
        isIncoming ? Icons.call_received : Icons.call_made,
        color: isIncoming ? Colors.green : Colors.red,
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade200,
        child: Text(name[0]),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Звонки'), elevation: 0),
      body: ListView(
        children: const [
          CallTile(name: 'Мама', time: 'Только что', isIncoming: true),
          CallTile(name: 'Папа', time: '5 мин назат', isIncoming: false),
          CallTile(name: 'Гулля', time: '20 мая', isIncoming: true),
        ],
      ),
    );
  }
}
