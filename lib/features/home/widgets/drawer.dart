import 'package:metrix/core/common/widgets/custom_dialog.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/home/bloc/home_bloc.dart';
import 'package:metrix/features/home/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  void _showDialog() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: AppColors.white,
            child: CustomDialog(
              title: "Logout",
              subTitle: "Do you really want to logout.",
              onDonePressed: () {
                _logout();
              },
              onCancelPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
    );
  }

  void _logout() {
    BlocProvider.of<HomeBloc>(context).add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            Image.asset("assets/logo.png", width: 140),
            SizedBox(height: 15),
            Text(
              "Vithsutra",
              style: GoogleFonts.nunito(
                color: AppColors.blue,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DrawerTile(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              title: "Register",
              subTitle: "Register New Student",
              leading: Icons.people,
              trailing: Icons.arrow_right_rounded,
            ),
            DrawerTile(
              onPressed: () {
                Navigator.pushNamed(context, "/time");
              },
              title: "Time",
              subTitle: "Set Time for Attendance",
              leading: Icons.more_time_rounded,
              trailing: Icons.arrow_right_rounded,
            ),
            DrawerTile(
              onPressed: () {
                Navigator.pushNamed(context, "/download");
              },
              title: "Download",
              subTitle: "Download Attandance",
              leading: Icons.download_rounded,
              trailing: Icons.arrow_right_rounded,
            ),
            // DrawerTile(
            //   onPressed: () {},
            //   title: "Delete",
            //   subTitle: "Delete Machine Data",
            //   leading: Icons.delete,
            //   trailing: Icons.arrow_right_rounded,
            // ),
            // DrawerTile(
            //   onPressed: () {
            //     Navigator.pushNamed(context, "/swap");
            //   },
            //   title: "Swap Machines",
            //   subTitle: "Switch Machine Data",
            //   leading: Icons.swap_calls,
            //   trailing: Icons.arrow_right_rounded,
            // ),
            DrawerTile(
              title: "Password",
              subTitle: "Change Password",
              leading: Icons.key_rounded,
              trailing: Icons.arrow_right_rounded,
              onPressed: () {
                Navigator.pushNamed(context, "/password");
              },
            ),
            DrawerTile(
              title: "Settings",
              subTitle: "View and Edit Profile",
              leading: Icons.settings,
              trailing: Icons.arrow_right_rounded,
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
            ),
            DrawerTile(
              onPressed: () {
                _showDialog();
              },
              title: "Logout",
              subTitle: "Sign out from Account",
              leading: Icons.logout_rounded,
              trailing: Icons.arrow_right_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
