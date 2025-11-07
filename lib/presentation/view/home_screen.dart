import 'package:careme/app/theme/colors.dart';
import 'package:careme/core/constants/app_images.dart';
import 'package:careme/core/widget/app_loader.dart';
import 'package:careme/presentation/viewmodel/customer_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/route_names.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerViewModelProvider.notifier).getCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(10),
              color: AppColors.primaryLight.withValues(alpha: 0.1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(16),
                Image.asset(AppImages.logo, height: 200),
                Gap(10),
                Text("Care4Me", style: Theme.of(context).textTheme.titleLarge),
                Gap(10),
                Divider(thickness: 0.1),
                Gap(10),
                Consumer(
                  builder: (context, ref, child) {
                    var state = ref.watch(customerViewModelProvider);
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: state.isLoading
                          ? AppLoader()
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _infoCard(
                                        "Total Customers",
                                        state.customers?.length ?? 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _infoCard(
                                        "Married",
                                        state.customers
                                                ?.where(
                                                  (c) =>
                                                      c.maritalStatus ==
                                                      "Married",
                                                )
                                                .length ??
                                            0,
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _infoCard(
                                        "Divorced",
                                        state.customers
                                                ?.where(
                                                  (c) =>
                                                      c.maritalStatus ==
                                                      "Divorced",
                                                )
                                                .length ??
                                            0,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _infoCard(
                                        "Single",
                                        state.customers
                                                ?.where(
                                                  (c) =>
                                                      c.maritalStatus ==
                                                      "Single",
                                                )
                                                .length ??
                                            0,
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _infoCard(
                                        "Widowed",
                                        state.customers
                                                ?.where(
                                                  (c) =>
                                                      c.maritalStatus ==
                                                      "Widowed",
                                                )
                                                .length ??
                                            0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      context.push(RouteNames.search);
                    },
                    child: TextField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hint: Text("Search for a customer..."),
                        suffixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, int subTitle) {
    return Container(
      padding: EdgeInsetsGeometry.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(5),
        color: AppColors.secondaryLight.withValues(alpha: 0.9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
          Gap(5),
          Text(
            subTitle.toString(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
