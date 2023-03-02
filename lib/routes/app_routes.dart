// ignore: depend_on_referenced_packages
import 'package:get/get.dart';


import '../controllers/overall_result_controller.dart';
import '../controllers/question_paper_controller.dart';
import '../controllers/rules_controller.dart';
import '../screens/change_password/change_password_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/introduction/introduction.dart';
import '../screens/login/login_screen.dart';
import '../screens/overall_result/overall_result_screen.dart';
import '../screens/question/answer_check_screen.dart';
import '../screens/question/question_screen.dart';
import '../screens/question/question_start_screen.dart';
import '../screens/question/result_screen.dart';
import '../screens/question/test_overview_screen.dart';
import '../screens/quiz_rules/quiz_rules.dart';
import '../screens/register/register_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../controllers/question_paper/questions_controller.dart';
class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/intro", page: () => const IntroductionScreen()),
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(name: RegisterScreen.routeName, page: ()=>const RegisterScreen()),
         GetPage(
            name: HomeScreen.routeName,
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              // we have to use questionpapercontroller after
              Get.put(QuestionPaperController());
              // we have to use OverAll Result COntroller
              Get.put(OverallResultController());
              //to use the zoom drawer controller
            })),
        GetPage(
            name: QuizRules.routeName,
            page: () => const QuizRules(),
            binding: BindingsBuilder(() {
              Get.put(QuizRulesController());
            })),
        GetPage(
            name: OverallResultScreen.routeName,
            page: () => const OverallResultScreen()),
        GetPage(
            name: ChangePasswordScreen.routeName,
            page: () => const ChangePasswordScreen()),


        // QUiz 
         GetPage(
          name: QuestionStartScreen.routeName,
          page: () => const QuestionStartScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionsController());
          }),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
          binding: BindingsBuilder(() {
            // retrieve the QuestionsController instance from QuestionStartScreen
            final questionsController = Get.find<QuestionsController>();
            // make the instance available to TestOverviewScreen
            Get.put(questionsController);
          }),
        ),
        GetPage(
          name: QuestionScreen.routeName,
          page: () => const QuestionScreen(),
          binding: BindingsBuilder(() {
             final questionsController = Get.find<QuestionsController>();
            // make the instance available to TestOverviewScreen
            Get.put(questionsController);
          }),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
          binding: BindingsBuilder(() {
            // retrieve the QuestionsController instance from QuestionStartScreen
            final questionsController = Get.find<QuestionsController>();
            // make the instance available to TestOverviewScreen
            Get.put(questionsController);
          }),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
          binding: BindingsBuilder(() {
            // retrieve the QuestionsController instance from QuestionStartScreen
            final questionsController = Get.find<QuestionsController>();
            // make the instance available to TestOverviewScreen
            Get.put(questionsController);
          }),
        ),

      ];
}
