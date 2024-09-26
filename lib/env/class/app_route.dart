part of '../class/app_env.dart';

class AppRoute {
  const AppRoute({required this.path, required this.page});
  final String path;
  final Widget page;

  static AppRoute homePage = AppRoute(
    path: 'homePage',
    page: BlocProvider(
      create: (_) => HomepageCubit()..getGetAllChecklist(),
      child: const HomePage(),
    ),
  );

  static AppRoute registerPage = AppRoute(
    path: 'registerPage',
    page: BlocProvider(
      create: (_) => RegisterCubit(),
      child: const RegisterPage(),
    ),
  );

  static AppRoute loginPage = AppRoute(
    path: 'loginPage',
    page: BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginPage(),
    ),
  );

  static AppRoute checklistDetailPage = AppRoute(
    path: 'checklistDetailPage',
    page: BlocProvider(
      create: (_) => ChecklistCubit(),
      child: Builder(
        builder: (context) {
          var modal = context.modal<Map<String, dynamic>?>();

          ChecklistModel checklist = modal!['data'];

          if (context.read<ChecklistCubit>().items.isEmpty) {
            context.read<ChecklistCubit>().getFindAllChecklistItem(
                  idChecklist: checklist.id,
                );
          }

          return const ChecklistDetailPage();
        },
      ),
    ),
  );

  // example route without bloc provider
  // static AppRoute blankPage = const AppRoute(
  //   path: 'blankPage',
  //   page: BlankPage(),
  // );

  // example route single bloc provider
  // static AppRoute splashPage = AppRoute(
  //   path: 'splashPage',
  //   page: BlocProvider(
  //     create: (_) => SplashCubit()..splash(),
  //     child: const SplashPage(),
  //   ),
  // );

  // example route single bloc provider with builder (if need params)
  // static AppRoute otpPage = AppRoute(
  //   path: 'otpPage',
  //   page: BlocProvider(
  //     create: (context) => OtpCubit(),
  //     child: Builder(
  //       builder: (context) {
  //         var modal = context.modal<Map<String, dynamic>?>();
  //         if (modal?['isResend'] == true) {
  //           context.read<OtpCubit>().resendOtp(
  //                 numberPhone: modal?['numberPhone'],
  //               );
  //         }
  //         return const OtpPage();
  //       },
  //     ),
  //   ),
  // );

  // example route multi bloc provider
  // static AppRoute dashboardPage = AppRoute(
  //   path: 'dashboardPage',
  //   page: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (_) => ProfileCubit()..getProfile()),
  //       BlocProvider(create: (_) => HomepageCubit()),
  //       BlocProvider(
  //           create: (_) => TransactionHistoryCubit()..getTransactionHistory()),
  //     ],
  //     child: const DashboardPage(),
  //   ),
  // );

  // example route single bloc provider with builder (if need params)
  // static AppRoute paymentPage = AppRoute(
  //   path: 'paymentPage',
  //   page: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (_) => PaymentCubit()),
  //       BlocProvider(create: (_) => PpobPaymentDetailCubit()),
  //       BlocProvider(create: (_) => PinCubit()),
  //     ],
  //     child: Builder(
  //       builder: (context) {
  //         var modal = context.modal<Map<String, dynamic>?>();
  //         double amount = 0;
  //         if (modal?['product'].runtimeType.toString() == 'PlnCustomerModel') {
  //           amount = AppFunction.extractNumberFromString(
  //               modal?['product'].totalBayar);
  //         } else {
  //           amount = modal?['product'].priceSell ?? 10000;
  //         }

  //         log('amount : $amount', name: 'paymentPageRoute');
  //         context.read<PaymentCubit>().getPaymentMethod(amount: amount);

  //         return const PaymentPage();
  //       },
  //     ),
  //   ),
  // );
}
