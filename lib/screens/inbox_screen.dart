import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';
import 'package:rucas_exam_project/widgets/inbox/inbox_tab.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessageProvider>(context);

    final Color primaryBlue = const Color.fromARGB(255, 27, 135, 236);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120), // tinggi custom
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/icon-background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent, // supaya gambar kelihatan
              elevation: 0,
              leading: const BackButton(color: Colors.white),
              title: const Text(
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
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => provider.toggleSelectionMode(),
                  ),
              ],
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                indicatorWeight: 3.0,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(
                    child: FittedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, size: 20),
                          const SizedBox(width: 6),
                          const Text('Peringatan'),
                          const SizedBox(width: 4),
                          BadgeCounter(
                            count: provider.countByCategory('Peringatan'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, size: 20),
                          const SizedBox(width: 6),
                          const Text('Kiat'),
                          const SizedBox(width: 4),
                          BadgeCounter(count: provider.countByCategory('Kiat')),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer_outlined, size: 20),
                          const SizedBox(width: 6),
                          const Text('Tawaran'),
                          const SizedBox(width: 4),
                          BadgeCounter(
                            count: provider.countByCategory('Tawaran'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: const TabBarView(
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
    if (count == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
