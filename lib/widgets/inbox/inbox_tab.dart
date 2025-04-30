import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rucas_exam_project/provider/message_provider.dart';

class InboxTab extends StatelessWidget {
  final String category;

  const InboxTab({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessageProvider>(context);
    final messages = provider.getMessagesByCategory(category);
    final selectionMode = provider.selectionMode;

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/mailbox.png', height: 180),
            SizedBox(height: 20),
            Text(
              'Selesai! Anda tidak memiliki pesan baru.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return ListTile(
                leading:
                    selectionMode
                        ? Checkbox(
                          value: message.isChecked,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (_) {
                            provider.toggleCheck(message);
                          },
                        )
                        : null,
                title: Text(
                  message.content,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              );
            },
          ),
        ),
        if (selectionMode)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${provider.getCheckedCount()} dipilih'),
                ElevatedButton.icon(
                  onPressed:
                      provider.getCheckedCount() > 0
                          ? () => provider.deleteCheckedMessages()
                          : null,
                  icon: Icon(Icons.delete),
                  label: Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6B81),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
