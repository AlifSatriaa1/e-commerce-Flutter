import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final int cartCount;
  const AccountPage({super.key, this.cartCount = 0});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4C53A5);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: primary,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'CartPage'),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 26),
                if (cartCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Center(
                        child: Text(
                          cartCount > 99 ? '99+' : '$cartCount',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4C53A5), Color(0xFF6C5CE7)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png', // <-- path yang sesuai
                      width: 86,
                      height: 86,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 86,
                          height: 86,
                          color: Colors.white24,
                          child: const Icon(Icons.person, size: 46, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Alif Satria',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'alifrpl14@gmail.com',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            _buildSettingItem(
              context: context,
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),

            _buildSettingItem(
              context: context,
              icon: Icons.shopping_cart_outlined,
              title: 'My Cart',
              onTap: () => Navigator.pushNamed(context, 'CartPage'),
            ),

            _buildSettingItem(
              context: context,
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () => Navigator.pushNamed(context, '/changePassword'),
            ),

            _buildSettingItem(
              context: context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () => Navigator.pushNamed(context, '/notifications'),
            ),

            _buildSettingItem(
              context: context,
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),

            _buildSettingItem(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4C53A5), size: 26),
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C53A5)),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacementNamed(context, 'LoginPage');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout successful')),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
