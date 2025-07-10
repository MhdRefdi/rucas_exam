import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';

class PromotionDetail extends StatefulWidget {
  final Promotion promotion;

  const PromotionDetail({super.key, required this.promotion});

  @override
  State<PromotionDetail> createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  bool _showBanner = true;
  bool _isBookmarked = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulasikan loading data
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Memuat detail promo...',
                style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          // Enhanced App Bar with Hero Animation
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            backgroundColor: theme.primaryColor,
            elevation: 0,
            stretch: true,
            leading: _buildBackButton(context),
            leadingWidth: 45,
            actions: [
              IconButton(
                onPressed: _toggleBookmark,
                icon: Icon(
                  _isBookmarked ? Icons.bookmark_add : Icons.bookmark_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: _handleMenuSelection,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                offset: const Offset(0, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                color: Colors.white,
                itemBuilder:
                    (BuildContext context) => [
                      _buildPopupMenuItem(
                        'copy',
                        Icons.content_copy_outlined,
                        'Salin Kode Promo',
                        'Salin ${widget.promotion.promoCode}',
                        Colors.blue.shade600,
                      ),
                      const PopupMenuDivider(height: 8),
                      _buildPopupMenuItem(
                        'reminder',
                        Icons.schedule_outlined,
                        'Atur Pengingat',
                        'Ingatkan sebelum promo berakhir',
                        Colors.orange.shade600,
                      ),
                      const PopupMenuDivider(height: 8),
                      _buildPopupMenuItem(
                        'how_to_use',
                        Icons.help_outline,
                        'Panduan Penggunaan',
                        'Lihat cara menggunakan promo',
                        Colors.green.shade600,
                      ),
                      const PopupMenuDivider(height: 8),
                      _buildPopupMenuItem(
                        'feedback_submit',
                        Icons.feedback_outlined,
                        'Saran dan Kritik',
                        'Berikan saran dan kritik terkait promo',
                        Colors.purple.shade600,
                      ),
                    ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'promo-${widget.promotion.id}',
                child: Image.asset(
                  widget.promotion.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),

          // Banner with smooth dismiss animation
          if (_showBanner)
            SliverToBoxAdapter(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _PromoBanner(
                  onDismiss: () => setState(() => _showBanner = false),
                ),
              ),
            ),

          // Main content with improved spacing
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promotion header with better visual hierarchy
                  _PromotionHeader(
                    promotion: widget.promotion,
                    theme: theme,
                    isBookmarked: _isBookmarked,
                  ),

                  const SizedBox(height: 12),

                  // Stats in card with shadow
                  _PromotionStatsCard(
                    theme: theme,
                    promotion: widget.promotion,
                  ),

                  const SizedBox(height: 24),

                  // About section with better typography
                  _AboutPromotionSection(
                    promotion: widget.promotion,
                    theme: theme,
                  ),

                  const SizedBox(height: 24),

                  // Related promotions with horizontal scroll
                  _RelatedPromotionsSection(
                    theme: theme,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Terms and conditions with expandable sections
                  _TermsAndConditionsSection(
                    promotion: widget.promotion,
                    theme: theme,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      // Sticky CTA button at bottom
      bottomNavigationBar: _ClaimButton(
        promotion: widget.promotion,
        theme: theme,
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String title,
    String subtitle,
    Color iconColor, {
    bool isDestructive = false,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 64,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isDestructive
                              ? Colors.red.shade700
                              : Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Material(
        shape: const CircleBorder(),
        color: Colors.white,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', // route tujuan
              (Route<dynamic> route) =>
                  false, // menghapus semua route sebelumnya
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
          ),
        ),
      ),
    );
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    _showSnackBar(
      _isBookmarked
          ? 'Promo ditambahkan ke favorit'
          : 'Promo dihapus dari favorit',
    );
  }

  void _handleMenuSelection(String value) async {
    switch (value) {
      case 'copy':
        await _copyPromoCode();
        break;
      case 'reminder':
        _setReminder();
        break;
      case 'how_to_use':
        _showHowToUseGuide();
        break;
      case 'feedback_submit':
        _showFeedbackDialog();
        break;
    }
  }

  void _showHowToUseGuide() {
    final theme = AppTheme();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.help_outline,
                          color: theme.primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Panduan Penggunaan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ikuti langkah berikut untuk menggunakan promo',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Steps
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildStep(
                          1,
                          'Salin Kode Promo',
                          'Salin kode "${widget.promotion.promoCode}" atau langsung klik tombol "Klaim Promo"',
                          Icons.content_copy,
                          Colors.blue,
                        ),
                        _buildStep(
                          2,
                          'Buka Aplikasi Ruangguru',
                          'Pilih produk atau layanan yang ingin Anda beli dari katalog yang tersedia',
                          Icons.phone_android,
                          Colors.green,
                        ),
                        _buildStep(
                          3,
                          'Masukkan Kode Promo',
                          'Pada halaman pembayaran, temukan kolom "Kode Promo" dan masukkan kode yang telah disalin',
                          Icons.payment,
                          Colors.orange,
                        ),
                        _buildStep(
                          4,
                          'Verifikasi Diskon',
                          'Pastikan diskon sudah terapkan dengan benar sebelum menyelesaikan pembayaran',
                          Icons.verified,
                          Colors.purple,
                          isLast: true,
                        ),

                        const SizedBox(height: 24),

                        // Important note
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber.shade200),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.amber.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tips Penting',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Promo berlaku hingga ${_formatDate(widget.promotion.validUntil)}. Pastikan menggunakan sebelum masa berlaku habis.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.amber.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // Bottom actions
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Tutup',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await _copyPromoCode();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Salin Kode',
                            style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildStep(
    int number,
    String title,
    String description,
    IconData icon,
    Color color, {
    bool isLast = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step indicator with line
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 16),
                    Text(
                      number.toString(),
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    final theme = AppTheme();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        elevation: 2,
        backgroundColor: theme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _copyPromoCode() async {
    await Clipboard.setData(ClipboardData(text: widget.promotion.promoCode));
    if (mounted) {
      _showSnackBar('Kode promo berhasil disalin');
    }
  }

  Future<void> _setReminder() async {
    final now = DateTime.now();
    final timeLeft = widget.promotion.validUntil.difference(now);

    final theme = AppTheme();

    if (timeLeft.inDays <= 0) {
      if (mounted) {
        _showSnackBar('Promosi sudah berakhir');
      }
      return;
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header dengan icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      size: 32,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    'Atur Pengingat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Kapan Anda ingin diingatkan tentang promosi ini?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),

                  // Reminder options
                  Column(
                    children: [
                      _buildReminderCard(
                        icon: Icons.today,
                        title: '1 hari sebelum berakhir',
                        subtitle: _formatDate(
                          widget.promotion.validUntil.subtract(
                            const Duration(days: 1),
                          ),
                        ),
                        color: Colors.orange,
                        onTap:
                            () => _confirmReminder(
                              widget.promotion.validUntil.subtract(
                                const Duration(days: 1),
                              ),
                            ),
                      ),
                      const SizedBox(height: 12),
                      _buildReminderCard(
                        icon: Icons.calendar_today,
                        title: '3 hari sebelum berakhir',
                        subtitle: _formatDate(
                          widget.promotion.validUntil.subtract(
                            const Duration(days: 3),
                          ),
                        ),
                        color: Colors.blue,
                        onTap:
                            () => _confirmReminder(
                              widget.promotion.validUntil.subtract(
                                const Duration(days: 3),
                              ),
                            ),
                      ),
                      const SizedBox(height: 12),
                      _buildReminderCard(
                        icon: Icons.date_range,
                        title: '1 minggu sebelum berakhir',
                        subtitle: _formatDate(
                          widget.promotion.validUntil.subtract(
                            const Duration(days: 7),
                          ),
                        ),
                        color: theme.primaryColor,
                        onTap:
                            () => _confirmReminder(
                              widget.promotion.validUntil.subtract(
                                const Duration(days: 7),
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Cancel button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildReminderCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReminder(DateTime date) {
    final theme = AppTheme();

    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success icon with animation effect
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 48,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Success title
                  Text(
                    'Pengingat Berhasil Diatur!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Details card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 20,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Waktu Pengingat:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(date),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              size: 20,
                              color: Colors.orange.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Tentang Promo:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.promotion.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // OK button
                  // OK button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog terlebih dahulu
                      _showSnackBar(
                        'Pengingat berhasil disetel untuk ${_formatDate(date)}',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Mengerti',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showFeedbackDialog() {
    String selectedFeedbackType = '';
    String customFeedback = '';
    double rating = 0.0; // 0 means no rating yet
    final TextEditingController _controller = TextEditingController();
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.feedback_rounded,
                          color: Colors.blue.shade600,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Beri Masukan untuk Promo Ini',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSubmitting) ...[
                          const SizedBox(height: 20),
                          const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xFF39AAE0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              'Mengirim masukan...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ] else ...[
                          // Rating Slider Section
                          const Text(
                            'Bagaimana penilaian Anda tentang promo ini?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.sentiment_very_dissatisfied,
                                color:
                                    rating < 1
                                        ? Colors.grey
                                        : _getRatingColor(rating),
                                size: 28,
                              ),
                              Expanded(
                                child: Slider(
                                  value: rating,
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  label:
                                      rating > 0
                                          ? rating.toStringAsFixed(1)
                                          : '0 (Belum dinilai)',
                                  onChanged: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                  activeColor: _getRatingColor(rating),
                                  inactiveColor: Colors.grey.shade300,
                                ),
                              ),
                              Icon(
                                Icons.sentiment_very_satisfied,
                                color:
                                    rating < 1
                                        ? Colors.grey
                                        : _getRatingColor(rating),
                                size: 28,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              rating > 0
                                  ? _getRatingText(rating)
                                  : 'Geser slider untuk memberi rating',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    rating > 0
                                        ? _getRatingColor(rating)
                                        : Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Apa yang ingin Anda sampaikan tentang promo ini? (Opsional)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Feedback options
                          _FeedbackOption(
                            title: 'Saran perbaikan',
                            subtitle: 'Ada yang bisa diperbaiki dari promo ini',
                            icon: Icons.construction_rounded,
                            value: 'improvement',
                            groupValue: selectedFeedbackType,
                            onChanged:
                                (value) => setState(
                                  () => selectedFeedbackType = value!,
                                ),
                          ),

                          _FeedbackOption(
                            title: 'Kesalahan informasi',
                            subtitle:
                                'Ada informasi yang tidak sesuai/tidak akurat',
                            icon: Icons.info_outline_rounded,
                            value: 'incorrect_info',
                            groupValue: selectedFeedbackType,
                            onChanged:
                                (value) => setState(
                                  () => selectedFeedbackType = value!,
                                ),
                          ),

                          _FeedbackOption(
                            title: 'Permintaan fitur',
                            subtitle: 'Saya ingin ada fitur/tawaran tertentu',
                            icon: Icons.lightbulb_outline_rounded,
                            value: 'feature_request',
                            groupValue: selectedFeedbackType,
                            onChanged:
                                (value) => setState(
                                  () => selectedFeedbackType = value!,
                                ),
                          ),

                          _FeedbackOption(
                            title: 'Pengalaman pengguna',
                            subtitle:
                                'Saya mengalami kesulitan saat menggunakan promo',
                            icon: Icons.accessibility_rounded,
                            value: 'user_experience',
                            groupValue: selectedFeedbackType,
                            onChanged:
                                (value) => setState(
                                  () => selectedFeedbackType = value!,
                                ),
                          ),

                          _FeedbackOption(
                            title: 'Lainnya',
                            subtitle: 'Masukan lain yang ingin disampaikan',
                            icon: Icons.more_horiz_rounded,
                            value: 'other',
                            groupValue: selectedFeedbackType,
                            onChanged:
                                (value) => setState(
                                  () => selectedFeedbackType = value!,
                                ),
                          ),

                          // Custom feedback text field
                          if (selectedFeedbackType.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              selectedFeedbackType == 'other'
                                  ? 'Tuliskan masukan Anda:'
                                  : 'Jelaskan lebih detail:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Tuliskan penjelasan detail...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppTheme().primaryColor,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                              maxLines: 4,
                              maxLength: 500,
                              onChanged: (value) => customFeedback = value,
                            ),
                          ],

                          const SizedBox(height: 16),

                          // Appreciation notice
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF39AAE0)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.thumb_up_rounded,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Terima kasih atas masukannya! Masukan Anda membantu kami meningkatkan kualitas promo dan layanan.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade800,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  actions:
                      isSubmitting
                          ? []
                          : [
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      _controller.dispose();
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      side: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Nanti Saja',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed:
                                        rating == 0
                                            ? null
                                            : () async {
                                              setState(
                                                () => isSubmitting = true,
                                              );

                                              // Simulate network delay
                                              await Future.delayed(
                                                const Duration(seconds: 1),
                                              );

                                              _controller.dispose();
                                              Navigator.pop(context);

                                              // Show success snackbar
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check_circle,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      const Expanded(
                                                        child: Text(
                                                          'Terima kasih! Masukan Anda telah kami terima.',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  duration: const Duration(
                                                    seconds: 3,
                                                  ),
                                                  margin: const EdgeInsets.all(
                                                    16,
                                                  ),
                                                ),
                                              );
                                            },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          rating == 0
                                              ? Colors.grey.shade300
                                              : Colors.blue.shade600,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: rating == 0 ? 0 : 2,
                                    ),
                                    child: const Text(
                                      'Kirim Masukan',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                ),
          ),
    );
  }

  // Helper function to get color based on rating
  Color _getRatingColor(double rating) {
    if (rating < 2) return Colors.red;
    if (rating < 3) return Colors.orange;
    if (rating < 4) return Colors.yellow.shade700;
    return Colors.green;
  }

  // Helper function to get text based on rating
  String _getRatingText(double rating) {
    if (rating < 1.5) return 'Tidak Puas';
    if (rating < 2.5) return 'Kurang Puas';
    if (rating < 3.5) return 'Cukup Puas';
    if (rating < 4.5) return 'Puas';
    return 'Sangat Puas';
  }
}

class _FeedbackOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _FeedbackOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(value),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.blue.shade600,
            ),
            const SizedBox(width: 8),
            Icon(icon, color: Colors.blue.shade600, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
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

class _ReminderOption extends StatelessWidget {
  final String title;
  final DateTime value;
  final DateTime? groupValue;
  final ValueChanged<DateTime> onSelected;

  const _ReminderOption({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();
    return InkWell(
      onTap: () => onSelected(value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.notifications_none, color: theme.primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(value),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
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

class _ReportOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _ReportOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppTheme().primaryColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        color: isSelected ? AppTheme().primaryColor.withOpacity(0.05) : null,
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppTheme().primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        title: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  isSelected ? AppTheme().primaryColor : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected
                              ? AppTheme().primaryColor
                              : Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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

class _PromoBanner extends StatelessWidget {
  final VoidCallback onDismiss;

  const _PromoBanner({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.local_fire_department,
              color: Colors.orange.shade700,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Promo Terbatas!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dapatkan diskon hingga 70% untuk paket pembelajaran premium',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, size: 18, color: Colors.orange.shade700),
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}

// Promotion Header Section
class _PromotionHeader extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;
  final bool isBookmarked;

  const _PromotionHeader({
    required this.promotion,
    required this.theme,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.school, color: theme.primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Kode: ${promotion.promoCode} • Valid hingga ${_formatDate(promotion.validUntil)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Badges row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _generatePromoBadges(promotion, isBookmarked),
          ),
        ],
      ),
    );
  }

  List<Widget> _generatePromoBadges(Promotion promotion, bool isBookmarked) {
    List<Widget> badges = [];

    // Badge berdasarkan tanggal expired
    final now = DateTime.now();
    final daysLeft = promotion.validUntil.difference(now).inDays;

    if (daysLeft <= 0) {
      badges.add(
        _PromoBadge(
          icon: Icons.timelapse_rounded,
          label: 'Promo Sudah Kadaluarsa',
          color: Colors.red,
        ),
      );
    }

    if (isBookmarked) {
      badges.add(
        _PromoBadge(
          icon: Icons.bookmark_rounded,
          label: 'Ditandai',
          color: Colors.green,
        ),
      );
    }

    if (daysLeft <= 7 && daysLeft > 0) {
      badges.add(
        _PromoBadge(
          icon: Icons.timelapse_rounded,
          label: 'Berakhir $daysLeft hari',
          color: Colors.red,
        ),
      );
    } else if (daysLeft > 0) {
      badges.add(
        _PromoBadge(
          icon: Icons.timelapse_rounded,
          label: 'Tawaran Terbatas',
          color: Colors.orange,
        ),
      );
    }

    // Badge berdasarkan terms & conditions
    if (promotion.termsConditions.any(
      (term) => term.toLowerCase().contains('garansi'),
    )) {
      badges.add(
        _PromoBadge(
          icon: Icons.verified_rounded,
          label: 'Bergaransi',
          color: Colors.green,
        ),
      );
    }

    if (promotion.termsConditions.any(
      (term) => term.toLowerCase().contains('gratis'),
    )) {
      badges.add(
        _PromoBadge(
          icon: Icons.star_rounded,
          label: 'Bonus Gratis',
          color: Colors.blue,
        ),
      );
    }

    if (promotion.termsConditions.any(
      (term) => term.toLowerCase().contains('cicilan'),
    )) {
      badges.add(
        _PromoBadge(
          icon: Icons.credit_card,
          label: 'Cicilan 0%',
          color: Colors.purple,
        ),
      );
    }

    // Default badge jika tidak ada yang cocok
    if (badges.isEmpty) {
      badges.add(
        _PromoBadge(
          icon: Icons.local_offer,
          label: 'Promo Aktif',
          color: Colors.blue,
        ),
      );
    }

    return badges;
  }
}

String _formatDate(DateTime date) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Oct',
    'Nov',
    'Des',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

// Promo Badge Component
class _PromoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _PromoBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Stats Card Component
class _PromotionStatsCard extends StatelessWidget {
  final AppTheme theme;
  final Promotion promotion;

  const _PromotionStatsCard({required this.theme, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final validUntil = promotion.validUntil;
    final currentDate = DateTime.now();
    final remainingDays = validUntil.difference(currentDate).inDays;
    final totalDuration = validUntil.difference(promotion.validFrom).inDays;
    
    // Hitung hari yang sudah berlalu
    final elapsedDays = totalDuration - remainingDays;
    
    // Hitung progress (pastikan tidak ada pembagian dengan 0)
    final progress = totalDuration > 0 
        ? (elapsedDays / totalDuration).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Berlaku hingga: ${_formatDate(promotion.validUntil)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    remainingDays > 0
                        ? '$remainingDays hari tersisa'
                        : 'Promo berakhir',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getRemainingDaysColor(remainingDays),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(progress),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: Icons.verified_user_rounded,
                value: '94%',
                label: 'Terverifikasi',
                color: Colors.green,
              ),
              Container(
                height: 40,
                width: 1,
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
              _StatItem(
                icon: Icons.people_alt_rounded,
                value: '500+',
                label: 'Pengguna',
                color: Colors.blue,
              ),
              Container(
                height: 40,
                width: 1,
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
              _StatItem(
                icon: Icons.thumb_up_alt_rounded,
                value: '96%',
                label: 'Sukses',
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress > 0.5) return Colors.green;
    if (progress > 0.25) return Colors.orange;
    return Colors.red;
  }

  Color _getRemainingDaysColor(int days) {
    if (days <= 0) return Colors.red;
    if (days > 7) return Colors.green;
    if (days > 3) return Colors.orange;
    return Colors.red;
  }
}

// Stat Item Component
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

// About Promotion Section
class _AboutPromotionSection extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const _AboutPromotionSection({required this.promotion, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang Promosi Ini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            promotion.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// Related Promotions Section
class _RelatedPromotionsSection extends StatelessWidget {
  final AppTheme theme;
  final bool isLoading;

  const _RelatedPromotionsSection({
    required this.theme,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Promo Lainnya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: promotions.length > 4 ? 4 : promotions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final promo = promotions[index];
                      return _RelatedPromoCard(promotion: promo);
                    },
                  ),
        ),
      ],
    );
  }
}

// Related Promo Card
class _RelatedPromoCard extends StatelessWidget {
  final Promotion promotion;

  const _RelatedPromoCard({required this.promotion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromotionDetail(promotion: promotion),
          ),
        );
      },
      child: SizedBox(
        width: 200,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    promotion.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[100],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotion.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.verified, size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            'Terverifikasi',
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Terms and Conditions Section
class _TermsAndConditionsSection extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const _TermsAndConditionsSection({
    required this.promotion,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: theme.primaryColor),
              const SizedBox(width: 8),
              Text(
                'Syarat & Ketentuan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Terms list with expandable items
          Column(
            children:
                promotion.termsConditions.asMap().entries.map((entry) {
                  int index = entry.key;
                  String term = entry.value;

                  return Column(
                    children: [
                      _TermItem(
                        title: term,
                        description: _getTermDescription(term),
                      ),
                      if (index < promotion.termsConditions.length - 1)
                        const Divider(height: 24, thickness: 0.5),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  String _getTermDescription(String term) {
    // Buat mapping sederhana berdasarkan kata kunci
    if (term.toLowerCase().contains('berlaku')) {
      return 'Ketentuan waktu berlaku untuk promosi ini';
    } else if (term.toLowerCase().contains('minimal') ||
        term.toLowerCase().contains('transaksi')) {
      return 'Syarat minimum transaksi yang harus dipenuhi';
    } else if (term.toLowerCase().contains('maksimal') ||
        term.toLowerCase().contains('diskon')) {
      return 'Batas maksimal potongan yang bisa didapatkan';
    } else if (term.toLowerCase().contains('tidak dapat') ||
        term.toLowerCase().contains('digabung')) {
      return 'Tidak bisa dikombinasikan dengan promo lainnya';
    } else if (term.toLowerCase().contains('kuota') ||
        term.toLowerCase().contains('terbatas')) {
      return 'Jumlah pengguna yang bisa menggunakan promo ini terbatas';
    } else if (term.toLowerCase().contains('cicilan') ||
        term.toLowerCase().contains('bunga')) {
      return 'Tersedia opsi pembayaran dengan cicilan';
    } else if (term.toLowerCase().contains('garansi')) {
      return 'Jaminan yang diberikan untuk produk/layanan';
    } else {
      return 'Ketentuan tambahan yang berlaku untuk promosi ini';
    }
  }
}

// Term Item Component
class _TermItem extends StatefulWidget {
  final String title;
  final String description;

  const _TermItem({required this.title, required this.description});

  @override
  State<_TermItem> createState() => _TermItemState();
}

class _TermItemState extends State<_TermItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Icon(Icons.check_circle_rounded, size: 18, color: Colors.green),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// Claim Button Component
class _ClaimButton extends StatelessWidget {
  final Promotion promotion;
  final AppTheme theme;

  const _ClaimButton({required this.promotion, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () => _showSuccessDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_offer_rounded, size: 20),
              SizedBox(width: 8),
              Text(
                'KLAIM PROMO SEKARANG',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 36, color: Colors.green),
              ),
              const SizedBox(height: 16),
              Text(
                'Promo Berhasil Diklaim!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kode promo telah disimpan di akun Anda',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'KODE PROMO',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      promotion.promoCode, // Ganti dari 'RUANGGURU2024'
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Berlaku hingga ${_formatDate(promotion.validUntil)}', // Ganti dari 'Berlaku hingga 31 Des 2024'
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: theme.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Tutup',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Promo berhasil digunakan'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: theme.primaryColor,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Gunakan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
