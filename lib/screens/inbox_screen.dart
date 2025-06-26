import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';
import 'package:rucas_exam_project/widgets/inbox/inbox_tab.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessageProvider>(context);

    // Warna utama biru muda
    final Color primaryBlue = Color.fromARGB(255, 27, 135, 236); // Biru muda
    final Color accentBlue = Color(0xFF03A9F4); // Aksen biru muda

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0, // Menghilangkan bayangan
          backgroundColor: primaryBlue, // App bar warna biru
          leading: BackButton(color: Colors.white),
          title: Text(
            'Kotak Masuk Saya',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            if (provider.selectionMode)
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => provider.toggleSelectionMode(),
              ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 20),
                    SizedBox(width: 6),
                    Text('Peringatan'),
                    SizedBox(width: 4),
                    BadgeCounter(count: provider.countByCategory('Peringatan')),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb_outline, size: 20),
                    SizedBox(width: 6),
                    Text('Kiat'),
                    SizedBox(width: 4),
                    BadgeCounter(count: provider.countByCategory('Kiat')),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_offer_outlined, size: 20),
                    SizedBox(width: 6),
                    Text('Tawaran'),
                    SizedBox(width: 4),
                    BadgeCounter(count: provider.countByCategory('Tawaran')),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryBlue.withOpacity(0.05), Colors.white],
              stops: [0.0, 0.3],
            ),
          ),
          child: TabBarView(
            children: [
              InboxTab(category: 'Peringatan'),
              InboxTab(category: 'Kiat'),
              InboxTab(category: 'Tawaran'),
            ],
          ),
        ),
      ),
    );
  }
}

class BadgeCounter extends StatelessWidget {
  final int count;

  const BadgeCounter({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
