import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';
import 'package:rucas_exam_project/widgets/inbox/inbox_tab.dart';

class InboxScreen extends StatefulWidget {
  final AppTheme theme = AppTheme();

  InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessageProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text('Kotak Masuk Saya'),
          actions: [
            Row(
              children: [
                Text(
                  provider.selectionMode ? 'Close' : 'Pilih di sini',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    provider.selectionMode ? Icons.close : Icons.check_box,
                  ),
                  onPressed: () => provider.toggleSelectionMode(),
                ),
              ],
            ),
          ],

          bottom: TabBar(
            labelColor: widget.theme.primaryColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Peringatan'),
                    SizedBox(width: 4),
                    Badge(count: provider.countByCategory('Peringatan')),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Kiat'),
                    SizedBox(width: 4),
                    Badge(count: provider.countByCategory('Kiat')),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tawaran'),
                    SizedBox(width: 4),
                    Badge(count: provider.countByCategory('Tawaran')),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InboxTab(category: 'Peringatan'),
            InboxTab(category: 'Kiat'),
            InboxTab(category: 'Tawaran'),
          ],
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final int count;

  const Badge({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFFF6B81),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
