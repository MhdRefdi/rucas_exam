import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/spacing_constans.dart';
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

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: _handleMenuSelection,
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share, size: 20),
                        SizedBox(width: 12),
                        Text('Bagikan'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'report',
                    child: Row(
                      children: [
                        Icon(Icons.flag, size: 20),
                        SizedBox(width: 12),
                        Text('Laporkan'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

                child: Text(
                  widget.promotion.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Hero(
                tag: 'promo-${widget.promotion.id}',
                child: Image.asset(
                  widget.promotion.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
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
                  _PromotionHeader(promotion: widget.promotion, theme: theme),
                  
                  const SizedBox(height: 16),
                  
                  // Stats in card with shadow
                  _PromotionStatsCard(theme: theme),
                  
                  const SizedBox(height: 24),
                  
                  // About section with better typography
                  _AboutPromotionSection(promotion: widget.promotion, theme: theme),
                  
                  const SizedBox(height: 24),
                  
                  // Related promotions with horizontal scroll
                  _RelatedPromotionsSection(theme: theme),
                  
                  const SizedBox(height: 24),
                  
                  // Terms and conditions with expandable sections
                  _TermsAndConditionsSection(promotion: widget.promotion, theme: theme),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Sticky CTA button at bottom
      bottomNavigationBar: _ClaimButton(promotion: widget.promotion, theme: theme),
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
          onTap: () => Navigator.of(context).pop(),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? 'Ditambahkan ke bookmark' : 'Dihapus dari bookmark'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'share':
        _showSnackBar('Fitur berbagi akan segera hadir');
        break;
      case 'report':
        _showReportDialog();
        break;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Laporkan Promosi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Apa masalah dengan promosi ini?'),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Jelaskan masalahnya...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Laporan telah dikirim. Terima kasih!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme().primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}

// Banner Widget with improved design
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
            Icon(Icons.local_fire_department, color: Colors.orange.shade700, size: 28),
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

  const _PromotionHeader({required this.promotion, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      'Tawaran Khusus Ruangguru',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${promotion.id} • 500+ Digunakan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Badges row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PromoBadge(
                icon: Icons.timelapse_rounded,
                label: 'Tawaran Terbatas',
                color: Colors.orange,
              ),
              _PromoBadge(
                icon: Icons.verified_rounded,
                label: 'Terverifikasi',
                color: Colors.green,
              ),
              _PromoBadge(
                icon: Icons.star_rounded,
                label: 'Populer',
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
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

  const _PromotionStatsCard({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.verified_user_rounded,
            value: '100%',
            label: 'Terverifikasi',
            color: Colors.green,
          ),
          _StatItem(
            icon: Icons.people_alt_rounded,
            value: '500+',
            label: 'Pengguna',
            color: Colors.blue,
          ),
          _StatItem(
            icon: Icons.thumb_up_alt_rounded,
            value: '95%',
            label: 'Sukses',
            color: Colors.orange,
          ),
        ],
      ),
    );
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

  const _RelatedPromotionsSection({required this.theme});

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
          child: ListView.separated(
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
// Related Promo Card with navigation
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
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
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
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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

  const _TermsAndConditionsSection({required this.promotion, required this.theme});

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
            children: [
              _TermItem(
                title: 'Berlaku hingga akhir bulan',
                description: 'Promo ini berlaku sampai tanggal 31 Desember 2024',
              ),
              const Divider(height: 24, thickness: 0.5),
              _TermItem(
                title: 'Tidak dapat digabungkan',
                description: 'Tidak bisa digabungkan dengan promosi lainnya',
              ),
              const Divider(height: 24, thickness: 0.5),
              _TermItem(
                title: 'Berlaku untuk semua pengguna',
                description: 'Baik pengguna baru maupun lama bisa menggunakan promo ini',
              ),
              const Divider(height: 24, thickness: 0.5),
              _TermItem(
                title: 'Terbatas satu penggunaan',
                description: 'Hanya bisa digunakan sekali per akun',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Term Item Component
class _TermItem extends StatefulWidget {
  final String title;
  final String description;

  const _TermItem({
    required this.title,
    required this.description,
  });

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
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: Colors.green,
              ),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.primaryColor.withOpacity(0.3)),
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
                      'RUANGGURU2024',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Berlaku hingga 31 Des 2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
                            content: const Text('Mengarahkan ke aplikasi Ruangguru...'),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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