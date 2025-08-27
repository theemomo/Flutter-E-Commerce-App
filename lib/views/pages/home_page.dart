import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/widgets/category_tab_view.dart';
import 'package:e_commerce/views/widgets/home_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const SizedBox.shrink();
                    } else if (state is HomeLoaded) {
                      return Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                              "https://cdn-icons-png.flaticon.com/512/9408/9408175.png",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi, Mohammad Moustafa",
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Let's go shopping",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),
                          const Icon(CupertinoIcons.search),
                          const SizedBox(width: 15),
                          const Icon(CupertinoIcons.bell),
                        ],
                      );
                    } else if (state is HomeError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      );
                    }else{
                       return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 24),
                TabBar(
                  unselectedLabelColor: AppColors.grey,
                  labelColor: Theme.of(context).primaryColor,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Home"),
                    Tab(text: "Category"),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [HomeTabView(), CategoryTabView()],
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
