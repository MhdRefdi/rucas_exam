import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
      id: '1',
      content: 'Peringatan 1: Login mencurigakan terdeteksi.',
      category: 'Peringatan',
    ),
    Message(
      id: '2',
      content: 'Peringatan 2: Ubah kata sandi Anda segera.',
      category: 'Peringatan',
    ),
    Message(
      id: '3',
      content: 'Peringatan 3: Akun Anda hampir kadaluarsa.',
      category: 'Peringatan',
    ),
    Message(id: '4', content: 'Kiat Aman Belajar Online', category: 'Kiat'),
    Message(
      id: '5',
      content: 'Kiat: Selalu gunakan verifikasi dua langkah.',
      category: 'Kiat',
    ),
    Message(
      id: '6',
      content: 'Kiat: Jangan bagikan OTP kepada siapa pun.',
      category: 'Kiat',
    ),
    Message(
      id: '7',
      content: 'Tawaran: Diskon 50% belajar selama 1 bulan',
      category: 'Tawaran',
    ),
    Message(
      id: '8',
      content: 'Tawaran: Promo Buku hingga 10 ribu.',
      category: 'Tawaran',
    ),
    Message(
      id: '9',
      content: 'Tawaran: Cashback 20% untuk pengguna baru.',
      category: 'Tawaran',
    ),
    Message(
      id: '10',
      content: 'Tawaran: Beli 1 Bku Gratis 1 selama April!',
      category: 'Tawaran',
    ),
  ];

  bool _selectionMode = false;

  bool get selectionMode => _selectionMode;

  void toggleSelectionMode() {
    _selectionMode = !_selectionMode;
    if (!_selectionMode) {
      for (var msg in _messages) {
        msg.isChecked = false;
      }
    }
    notifyListeners();
  }

  List<Message> getMessagesByCategory(String category) {
    return _messages
        .where((msg) => msg.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  void toggleCheck(Message message) {
    message.isChecked = !message.isChecked;
    notifyListeners();
  }

  int getCheckedCount() {
    return _messages.where((msg) => msg.isChecked).length;
  }

  void deleteCheckedMessages() {
    _messages.removeWhere((msg) => msg.isChecked);
    _selectionMode = false;
    notifyListeners();
  }

  int countByCategory(String category) {
    return _messages
        .where((msg) => msg.category.toLowerCase() == category.toLowerCase())
        .length;
  }
}
