import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_drop_down.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/core/common/cubits/fetch_unit_cubit_state.dart';
import 'package:metrix/core/common/cubits/fetch_units_cubit.dart';
import 'package:metrix/features/settings/cubits/change_label_cubit.dart';
import 'package:metrix/features/settings/cubits/change_label_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _unitIdController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<FetchUnitIDCubit>(context).fetchMachines();
    super.initState();
  }

  @override
  void dispose() {
    _unitIdController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  void _clear() {
    _labelController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchUnitIDCubit, FetchUnitIDState>(
          listener: (context, state) {
            if (state is FetchUnitIDFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),

        BlocListener<ChangeLabelCubit, ChangeLabelState>(
          listener: (context, state) {
            if (state is ChangeLabelFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
            if (state is ChangeLabelSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
              _clear();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                BlocProvider.of<FetchUnitIDCubit>(context).fetchMachines();
                _clear();
              },
              title: "Settings",
            ).buildCustomAppBar(),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 500,
            child: Card(
              elevation: 100,
              shadowColor: AppColors.moderateBlue,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.change_circle_rounded,
                      color: AppColors.blue,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Change Machine Label",
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      "This Name will be Allocated for Particular Devices.",
                      style: GoogleFonts.poppins(
                        color: AppColors.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<FetchUnitIDCubit, FetchUnitIDState>(
                      builder: (context, state) {
                        if (state is FetchUnitIDLoadingState) {
                          Skeletonizer(
                            enabled: true,
                            effect: SoldColorEffect(
                              color: AppColors.moderateBlue,
                            ),
                            child: CustomDropDownMenu(
                              data: [],
                              onChanged: (value) {
                                _unitIdController.text = value!;
                              },
                              hint: "Select Machine",
                            ),
                          );
                        }
                        if (state is FetchUnitIDSuccessState) {
                          return CustomDropDownMenu(
                            data: state.units,
                            onChanged: (value) {
                              _unitIdController.text = value!;
                            },
                            hint: "Select Machine",
                          );
                        }
                        return Skeletonizer(
                          enabled: true,
                          effect: SoldColorEffect(
                            color: AppColors.moderateBlue,
                          ),
                          child: CustomDropDownMenu(
                            data: [],
                            onChanged: (value) {
                              _unitIdController.text = value!;
                            },
                            hint: "Select Machine",
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _labelController,
                      hintText: "Device Name",
                      icon: Icons.devices_outlined,
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<ChangeLabelCubit, ChangeLabelState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is ChangeLabelLoadingState,
                          onPressed: () {
                            BlocProvider.of<ChangeLabelCubit>(
                              context,
                            ).changeLabel(
                              _unitIdController.text,
                              _labelController.text,
                            );
                          },
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Change Name",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
