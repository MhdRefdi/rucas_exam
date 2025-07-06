import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // Buka pub.dev
  Future<void> _launchPubDev() async {
    final url = Uri.parse('https://pub.dev/packages/url_launcher');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }

  // WhatsApp
  Future<void> _launchWhatsApp() async {
    final url = Uri.parse(
      'https://wa.me/6285358186244?text=Halo,%20saya%20membutuhkan%20bantuan%20terkait%20aplikasi%20ini.',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Tidak dapat membuka WhatsApp.');
    }
  }

  // SMS
  Future<void> _launchSMS() async {
    final url = Uri.parse(
      'sms:085358186244?body=Halo,%20saya%20membutuhkan%20bantuan%20terkait%20aplikasi%20ini.',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Tidak dapat membuka SMS.');
    }
  }

  // Telepon
  Future<void> _launchPhone() async {
    final url = Uri.parse('tel:085358186244');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Tidak dapat melakukan panggilan telepon.');
    }
  }

  // Email
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'febiantonurihsan@gmail.com',
      queryParameters: {
        'subject': 'Butuh Bantuan',
        'body': 'Halo, saya membutuhkan bantuan terkait aplikasi ini.',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback: pakai Gmail via browser
      final gmailUrl = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1&to=febiantonurihsan@gmail.com&su=Butuh%20Bantuan&body=Halo,%20saya%20membutuhkan%20bantuan%20terkait%20aplikasi%20ini.',
      );

      if (await canLaunchUrl(gmailUrl)) {
        await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Tidak dapat membuka aplikasi email.');
      }
    }
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Bantuan & Dukungan'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[100]!, Colors.blue[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.support_agent, size: 48, color: Colors.blue[600]),
                  const SizedBox(height: 12),
                  const Text(
                    'Butuh Bantuan?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tim support kami siap membantu kamu 24/7. Pilih cara yang paling mudah untuk menghubungi kami.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Hubungi Kami Melalui:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Contact Options
            _buildContactCard(
              icon: Icons.chat_bubble,
              title: 'WhatsApp',
              subtitle: 'Chat langsung dengan tim support',
              onTap: _launchWhatsApp,
              iconColor: Colors.green,
            ),

            _buildContactCard(
              icon: Icons.phone,
              title: 'Telepon',
              subtitle: 'Hubungi langsung untuk bantuan cepat',
              onTap: _launchPhone,
              iconColor: Colors.blue,
            ),

            _buildContactCard(
              icon: Icons.sms,
              title: 'SMS',
              subtitle: 'Kirim pesan singkat ke nomor support',
              onTap: _launchSMS,
              iconColor: Colors.orange,
            ),

            _buildContactCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'Kirim pertanyaan detail via email',
              onTap: _launchEmail,
              iconColor: Colors.red,
            ),

            const SizedBox(height: 24),

            // Info Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                border: Border.all(color: Colors.amber[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.amber[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Respon terbaik dalam 1-24 jam di hari kerja',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
