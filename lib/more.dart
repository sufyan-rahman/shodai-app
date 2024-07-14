import 'package:ecom/manage_address.dart';
import 'package:ecom/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'sign_up.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _updateUser(User? newUser) {
    setState(() {
      user = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserProfileSection(),
              const SizedBox(height: 10),
              user != null ? _buildPromoSection() : _buildLoginSection(),
              const SizedBox(height: 10),
              _buildMenuSection(),
              const SizedBox(height: 10),
              user != null ? _buildLogout() : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: const DecorationImage(
          image: AssetImage('assets/images/promo.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: SvgPicture.asset(
              'assets/icons/user-icon.svg',
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.displayName ?? 'Guest User',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              GestureDetector(
                onTap: user != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(user: user!)),
                        );
                      }
                    : null,
                child: Text(
                  user != null ? 'View Profile' : 'Sign in to view profile',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7D7D00)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogout() {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(fontSize: 16, height: 3.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 50.0),
                                    backgroundColor: Colors.grey,
                                  ),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Flexible(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    _updateUser(null);
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    backgroundColor: Colors.red,
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 50.0),
                                  ),
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginSection() {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Log In'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ).then((_) {
                  _updateUser(FirebaseAuth.instance.currentUser);
                });
              },
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.login_outlined),
              title: const Text('Register'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                ).then((_) {
                  _updateUser(FirebaseAuth.instance.currentUser);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Manage Address'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageAddressPage(),
                  ),
                );
              },
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.discount_outlined),
              title: const Text('My Coupons'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('My Order'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help & Contact'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Blog'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.local_police_outlined),
              title: const Text('Terms & Privacy Policy'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(endIndent: 10.0, indent: 10.0),
            ListTile(
              leading: const Icon(Icons.sunny),
              title: const Text('Switch Themes'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.light_mode),
                                title: const Text('Light Mode'),
                                onTap: () {
                                  Get.changeTheme(ThemeData.light());
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.dark_mode),
                                title: const Text('Dark Mode'),
                                onTap: () {
                                  Get.changeTheme(ThemeData.dark());
                                },
                              )
                            ],
                          ),
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
