import 'package:metrix/core/args/home_args.dart';
import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/error_widget.dart';
import 'package:metrix/core/common/widgets/loading_widget.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/home/bloc/home_bloc.dart';
import 'package:metrix/features/home/widgets/drawer.dart';
import 'package:metrix/features/home/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(BiometricMachinesFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/login");
        }
        if(state is LogoutFailureState){
           BlocProvider.of<HomeBloc>(context).add(BiometricMachinesFetchEvent());
        }
      },
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                BlocProvider.of<HomeBloc>(
                  context,
                ).add(BiometricMachinesFetchEvent());
              },
              title: "Home",
            ).buildCustomAppBar(),
        drawer: HomeDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomePageLoadingState) {
                return LoadingWidget();
              } else if (state is HomePageErrorState) {
                return CustomErrorWidget(
                  errorMessage: state.message,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(
                      context,
                    ).add(BiometricMachinesFetchEvent());
                  },
                );
              } else if (state is HomePageLoadSuccessState) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Biometric Machines",
                        style: GoogleFonts.poppins(
                          color: AppColors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1600
                                  ? 7
                                  : MediaQuery.of(context).size.width < 1150
                                  ? 3
                                  : 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return HomeCard(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/details",
                                arguments: HomeArgs(
                                  unitId: state.devices[index]["unit_id"],
                                ),
                              );
                            },
                            isOnline: state.devices[index]["online"],
                            cardText: state.devices[index]["label"],
                            subTitle: state.devices[index]["unit_id"],
                          );
                        },
                        itemCount: state.devices.length,
                      ),
                    ),
                  ],
                );
              }
              return LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
