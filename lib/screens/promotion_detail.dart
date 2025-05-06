import 'package:flutter/material.dart';
import 'package:rucas_exam_project/config/theme_config.dart';
import 'package:rucas_exam_project/data/promotion_data.dart';

class PromotionDetail extends StatelessWidget {
  final Promotion promotion;

  const PromotionDetail({super.key, required this.promotion});

  // Define constants for reusable values
  static const double kDefaultPadding = 24.0;
  static const double kDefaultSpacing = 16.0;
  static const double kSmallSpacing = 12.0;
  static const double kTinySpacing = 8.0;
  static const double kBorderRadius = 16.0;
  static const double kLargeBorderRadius = 32.0;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Image header with glassmorphism app bar
              _buildAppBar(context, size, theme),

              // Main content
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kLargeBorderRadius),
                      topRight: Radius.circular(kLargeBorderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promotion info section
                      _buildPromotionInfoSection(theme, textTheme),

                      const SizedBox(height: kDefaultSpacing),

                      // Terms and conditions
                      _buildTermsAndConditions(context, theme, textTheme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Size size, AppTheme theme) {
    return SliverAppBar(
      expandedHeight: size.height * 0.45,
      pinned: true,
      backgroundColor: theme.primaryColor,
      elevation: 0,
      stretch: true,
      leading: _buildBackButton(context),
      leadingWidth: 45,
      flexibleSpace: FlexibleSpaceBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            promotion.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  color: Colors.black45,
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: _buildHeaderBackground(),
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Hero image
        Hero(
          tag: 'promo-${promotion.id}',
          child: Image.asset(
            promotion.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                ),
              );
            },
          ),
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.6, 0.8, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderOverlayContent() {
    return Positioned(
      bottom: kDefaultPadding,
      left: kDefaultPadding,
      right: kDefaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge row
          Row(
            children: [
              _buildBadge(
                'Tawaran Terbatas',
                Icons.timelapse_rounded,
                Colors.orange,
              ),
              const SizedBox(width: kTinySpacing),
              _buildBadge(
                'Terverifikasi',
                Icons.verified_rounded,
                Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionInfoSection(AppTheme theme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kDefaultPadding,
        kDefaultPadding + kTinySpacing,
        kDefaultPadding,
        kDefaultSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization info
          _buildOrganizationInfo(theme),

          const SizedBox(height: kDefaultPadding),
          _buildHeaderOverlayContent(),
          const SizedBox(height: kDefaultPadding),
          // Promotion stats
          _buildPromotionStats(theme),

          const SizedBox(height: kDefaultPadding + 4),

          // About section
          Text(
            'Tentang Promosi Ini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: kSmallSpacing),
          Text(
            promotion.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationInfo(AppTheme theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(kTinySpacing + 2),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(kSmallSpacing),
          ),
          child: Icon(
            Icons.school_rounded,
            color: theme.primaryColor,
            size: 22,
          ),
        ),
        const SizedBox(width: kSmallSpacing),
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
              Text(
                'ID: ${promotion.id} • 500+ Digunakan',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(
    BuildContext context,
    AppTheme theme,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kLargeBorderRadius),
          topRight: Radius.circular(kLargeBorderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: theme.primaryColor),
              const SizedBox(width: kTinySpacing),
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
          const SizedBox(height: kDefaultSpacing),
          _buildTermItem('Berlaku hingga akhir bulan'),
          _buildTermItem('Tidak dapat digabungkan dengan promosi lain'),
          _buildTermItem('Berlaku untuk pengguna baru dan lama'),
          _buildTermItem('Terbatas satu penggunaan per akun'),

          const SizedBox(height: 40),

          // Call to action button
          _buildClaimButton(context, theme),

          const SizedBox(height: kDefaultSpacing),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 8),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        padding: EdgeInsets.zero, // Menghilangkan padding default
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.grey,
          size: 20, // Ukuran ikon
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
            arguments: true,
          );
        },
      ),
    ),
  );
}

  Widget _buildBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionStats(AppTheme theme) {
    return Container(
      padding: const EdgeInsets.all(kDefaultSpacing),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(kDefaultSpacing),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.verified_user_rounded,
            label: 'Terverifikasi',
            value: '100%',
            iconColor: Colors.green,
          ),
          _buildStatDivider(),
          _buildStatItem(
            icon: Icons.people_alt_rounded,
            label: 'Pengguna',
            value: '500+',
            iconColor: Colors.blue,
          ),
          _buildStatDivider(),
          _buildStatItem(
            icon: Icons.thumb_up_alt_rounded,
            label: 'Sukses',
            value: '95%',
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: kTinySpacing),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTermItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSmallSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 18, color: Colors.green),
          const SizedBox(width: kSmallSpacing),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimButton(BuildContext context, AppTheme theme) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColor.withBlue(
              (theme.primaryColor.blue + 40).clamp(0, 255),
            ),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(kBorderRadius),
          onTap: () => _showSuccessDialog(context, theme),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_offer_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'KLAIM PROMO SEKARANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, AppTheme theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding),
              topRight: Radius.circular(kDefaultPadding),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultSpacing),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green[600],
                  size: 48,
                ),
              ),
              const SizedBox(height: kDefaultSpacing + 4),
              const Text(
                'Promosi Diterima!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kSmallSpacing),
              Text(
                'Anda telah berhasil mengklaim ${promotion.title}. Diskon akan diterapkan pada pembelian Anda berikutnya.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Belanja',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
