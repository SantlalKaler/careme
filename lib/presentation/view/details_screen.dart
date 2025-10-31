import 'package:careme/app/theme/colors.dart';
import 'package:careme/core/constants/app_images.dart';
import 'package:careme/core/widget/app_loader.dart';
import 'package:careme/core/widget/icon_with_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/widget/app_error.dart';
import '../viewmodel/customer_viewmodel.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final String title;
  final String id;
  const DetailsScreen({super.key, required this.title, required this.id});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  final double imageSize = 50;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerViewModelProvider.notifier).getCustomerById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var state = ref.watch(customerViewModelProvider);
          var customer = state.customer;
          return SingleChildScrollView(
            child: state.isLoading
                ? Center(child: AppLoader())
                : customer == null
                ? Center(child: AppError())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            color: AppColors.secondaryLight,
                          ),
                          padding: EdgeInsetsGeometry.all(15),
                          child: Row(
                            children: [
                              Container(
                                height: imageSize,
                                width: imageSize,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.profile),
                                  ),
                                ),
                              ),
                              Gap(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${customer.firstName} ${customer.lastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    customer.maritalStatus ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                _singleInfo(
                                  icon: Icons.calendar_month_outlined,
                                  "DOB",
                                  customer.dateOfBirth ?? "",
                                ),
                                Gap(15),
                                _singleInfo(
                                  icon: Icons.family_restroom,
                                  "Marital Status",
                                  customer.maritalStatus ?? "",
                                ),
                              ],
                            ),
                            Gap(30),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                color: Colors.grey.withValues(alpha: 0.1),
                              ),
                              padding: EdgeInsetsGeometry.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconWithData(
                                    icon: Icons.location_on_outlined,
                                    data: "Addresses",
                                    iconColor: AppColors.primaryLight,
                                  ),
                                  Divider(thickness: 0.1),
                                  Gap(10),
                                  ...customer.addresses!.map((address) {
                                    return _singleInfo(
                                      address.type ?? "",
                                      "${address.street}, ${address.city}, ${address.state}, ${address.zipCode}",
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Gap(30),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                color: Colors.grey.withValues(alpha: 0.1),
                              ),
                              padding: EdgeInsetsGeometry.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconWithData(
                                    icon: Icons.local_phone_outlined,
                                    data: "Phones",
                                    iconColor: AppColors.primaryLight,
                                  ),

                                  Divider(thickness: 0.1),
                                  Gap(10),
                                  ...customer.phones!.map((phone) {
                                    return _singleInfo(
                                      phone.type ?? "",
                                      phone.number ?? "",
                                      isPrimary: phone.isPrimary ?? false,
                                    );
                                  }),
                                  Gap(20),
                                  IconWithData(
                                    icon: Icons.email_outlined,
                                    data: "Emails",
                                    iconColor: AppColors.primaryLight,
                                  ),

                                  Divider(thickness: 0.1),
                                  Gap(10),
                                  ...customer.emails!.map((email) {
                                    return _singleInfo(
                                      email.type ?? "",
                                      email.address ?? "",
                                      isPrimary: email.isPrimary ?? false,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(50),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _singleInfo(
    String title,
    String subTitle, {
    bool isPrimary = false,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPrimary)
            Text(
              "Primary",
              style: TextStyle(
                fontSize: 10,
                color: Colors.green,
                fontWeight: FontWeight.w100,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: AppColors.contentTertiaryLight.withValues(
                          alpha: 0.7,
                        ),
                        size: 20,
                      ),
                    if (icon != null) Gap(15),

                    Text(title),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "$subTitle",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
