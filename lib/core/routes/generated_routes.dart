import 'package:metrix/core/args/details_args.dart';
import 'package:metrix/core/args/home_args.dart';
import 'package:metrix/core/common/cubits/fetch_units_cubit.dart';
import 'package:metrix/features/authentication/bloc/authentication_bloc.dart';
import 'package:metrix/features/authentication/pages/login_page.dart';
import 'package:metrix/features/change_password/bloc/change_password_bloc.dart';
import 'package:metrix/features/forgot_password/cubits/send_otp_cubit.dart';
import 'package:metrix/features/forgot_password/cubits/verify_otp_cubit.dart';
import 'package:metrix/features/forgot_password/pages/forgot_password_page.dart';
import 'package:metrix/features/home/bloc/home_bloc.dart';
import 'package:metrix/features/home/pages/home_page.dart';
import 'package:metrix/features/settings/cubits/change_label_cubit.dart';
import 'package:metrix/features/settings/pages/settings_page.dart';
import 'package:metrix/features/student_attendance_download/bloc/download_excel_bloc.dart';
import 'package:metrix/features/student_attendance_download/bloc/download_pdf_bloc.dart';
import 'package:metrix/features/student_attendance_download/pages/student_attendance_download_page.dart';
import 'package:metrix/features/student_attendance_time/bloc/time_bloc.dart';
import 'package:metrix/features/student_attendance_time/pages/student_attendance_time_setting_page.dart';
import 'package:metrix/features/student_details/bloc/details_bloc.dart';
import 'package:metrix/features/student_details/cubits/delete_student_cubit.dart';
import 'package:metrix/features/student_details/cubits/update_student_cubit.dart';
import 'package:metrix/features/student_details/pages/student_details_page.dart';
import 'package:metrix/features/student_logs/bloc/logs_bloc.dart';
import 'package:metrix/features/student_logs/pages/student_logs_page.dart';
import 'package:metrix/features/student_registration/bloc/fingerprint_scanner_bloc.dart';
import 'package:metrix/features/student_registration/bloc/registration_bloc.dart';
import 'package:metrix/features/student_registration/bloc/verification_bloc.dart';
import 'package:metrix/features/student_registration/cubits/fetch_ports_cubit.dart';
import 'package:metrix/features/student_registration/cubits/fetch_student_unitid_cubit.dart';
import 'package:metrix/features/student_registration/pages/student_registration_page.dart';
import 'package:metrix/features/change_password/pages/change_password.dart';
import 'package:metrix/features/swap_machines/pages/swap_machines_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthenticationBloc(),
                child: LoginPage(),
              ),
        );
      case "/home":
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => HomeBloc(),
                child: HomePage(),
              ),
        );
      case "/details":
        if (args is HomeArgs) {
          return MaterialPageRoute(
            builder:
                (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => DetailsBloc()),
                    BlocProvider(create: (context) => DeleteStudentCubit()),
                    BlocProvider(create: (context) => UpdateStudentCubit()),
                  ],
                  child: StudentDetailsPage(unitId: args.unitId),
                ),
          );
        }
      case "/logs":
        if (args is DetailsArgs) {
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create: (context) => LogsBloc(),
                  child: StudentLogsPage(
                    studentId: args.studentId,
                    studentName: args.studentName,
                    studentUsn: args.studentUsn,
                  ),
                ),
          );
        }
      case "/register":
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => RegistrationBloc()),
                  BlocProvider(create: (context) => VerificationBloc()),
                  BlocProvider(create: (context) => FingerprintScannerBloc()),
                  BlocProvider(create: (context) => FetchStudentUnitidCubit()),
                  BlocProvider(create: (context) => FetchUnitIDCubit()),
                  BlocProvider(create: (context) => FetchPortsCubit()),
                ],
                child: RegistrationPage(),
              ),
        );
      case "/download":
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FetchUnitIDCubit()),
                  BlocProvider(create: (context) => DownloadExcelBloc()),
                  BlocProvider(create: (context) => DownloadPdfBloc()),
                ],
                child: StudentAttendanceDownloadPage(),
              ),
        );
      case "/time":
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [BlocProvider(create: (context) => TimeBloc())],
                child: StudentAttendanceTimeSettingPage(),
              ),
        );
      case "/password":
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ChangePasswordBloc(),
                child: UserPasswordPage(),
              ),
        );
      case "/settings":
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FetchUnitIDCubit()),
                  BlocProvider(create: (context) => ChangeLabelCubit()),
                ],
                child: SettingsPage(),
              ),
        );
      case "/forgot":
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => SendOtpCubit()),
                  BlocProvider(create: (context) => VerifyOtpCubit()),
                ],
                child: ForgotPassword(),
              ),
        );
      case "/swap":
        return MaterialPageRoute(builder: (context) => SwapMachinesPage());
    }
    return null;
  }
}
