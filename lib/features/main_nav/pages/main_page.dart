import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_nav_bloc.dart';
import '../main_nav_state.dart';
import '../widgets/app_bottom_nav_bar.dart';

// يتم استبدالهم بصفحاتك الحقيقية
class HomePage extends StatelessWidget { const HomePage({super.key}); @override Widget build(_) => const Center(child: Text('الرئيسية')); }
class ProjectsPage extends StatelessWidget { const ProjectsPage({super.key}); @override Widget build(_) => const Center(child: Text('المشاريع')); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(_) => const Center(child: Text('الملف الشخصي')); }

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomePage(),
      ProjectsPage(),
      ProfilePage(),
    ];

    return BlocProvider(
      create: (_) => MainNavBloc(),
      child: BlocBuilder<MainNavBloc, MainNavState>(
        buildWhen: (p, c) => p.currentIndex != c.currentIndex,
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: pages,
            ),
            bottomNavigationBar: const AppBottomNavBar(),
          );
        },
      ),
    );
  }
}
