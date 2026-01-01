import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taskora/features/component%20Testing/testing_container.dart';
import '../../core/config/constants/color_manager.dart';
import '../../core/config/widgets/AlertDialogs/AppAlertDialog.dart';
import '../../core/config/widgets/BottomSheets/AppBottomSheet.dart';
import '../../core/config/widgets/Cards/AppCustomCard.dart';
import '../../core/config/widgets/Cards/AppDashboardCard.dart';
import '../../core/config/widgets/Cards/CircularProgressCard.dart';
import '../../core/config/widgets/Cards/CustomInfoCard.dart';
import '../../core/config/widgets/Cards/MiniStatCard.dart';
import '../../core/config/widgets/Cards/ProjectProgressCard.dart';
import '../../core/config/widgets/ProgressIndicators/AppProgressIndicator.dart';
import '../../core/config/widgets/SnackBars/app_snackbar.dart';
import '../../core/config/widgets/Texts/app_icon_text.dart';
import '../../core/config/widgets/buttons/app_button_base.dart';
import '../../core/config/widgets/buttons/app_chip_button.dart';
import '../../core/config/widgets/buttons/app_dual_action_row.dart';
import '../../core/config/widgets/buttons/app_outlined_danger_button.dart';
import '../../core/config/widgets/buttons/app_pill_button.dart';
import '../../core/config/widgets/buttons/app_primary_icon_button.dart';
import '../../core/config/widgets/buttons/app_soft_danger_button.dart';
import '../../core/config/widgets/logo/app_logo.dart';
import '../../core/config/widgets/status_badge/AppStatusBadge.dart';
import '../../core/config/widgets/tasks_list/AppTaskList.dart';
import '../../core/config/widgets/tasks_list/AppTaskListTile.dart';
import '../../core/config/widgets/text_fields/app_text_field.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Testing Screen',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 25)
        ),
      ),
      body: Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: SizedBox(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Buttons start here
                      namedDivider( dividerTitle: 'Buttons'),
                      ///AppButtonBase & AppAlertDialog
                      TestingContainer(
                        title: 'AppButtonBase & AppAlertDialog',
                        widget: AppButtonBase(
                          onPressed: () {
                            AppAlertDialog.show(context, message: 'test');
                            },
                          backgroundColor: ColorManager.secondaryColor,
                          foregroundColor: ColorManager.primaryColor,
                          child: Text('show AppAlertDialog'),
                        ),
                      ),
                      ///AppButtonBase.Loading
                      TestingContainer(
                        title: 'AppButtonBase  /  Loading',
                        widget: AppButtonBase(
                          onPressed: () {  },
                          isLoading: true,
                          backgroundColor: ColorManager.secondaryColor,
                          foregroundColor: ColorManager.primaryColor,
                          child: Text('test'),
                        ),
                      ),
                      ///AppChipButton & AppBottomSheetTypes.success
                      TestingContainer(
                        width: 120,
                        height: 25,
                        title: 'AppChipButton & AppBottomSheetTypes.success',
                        widget: AppChipButton(
                            icon: Icon(Icons.add),
                            text: 'show success',
                            onPressed: () {
                              AppBottomSheet.show(
                                type: AppBottomSheetTypes.success,
                                  context,
                                  message: 'success',
                              );
                            }
                        ),
                      ),
                      ///AppDualActionRow
                      TestingContainer(
                        title: 'AppDualActionRow',
                        widget: AppDualActionRow(
                          leftText: 'show Error',
                          rightText: 'show Empty',
                          onLeftPressed: () {
                            AppBottomSheet.show(
                              type: AppBottomSheetTypes.error,
                              context,
                              message: 'show empty',
                              showBackButtons: true,
                            );
                          },
                          onRightPressed: () {
                            AppBottomSheet.show(
                              type: AppBottomSheetTypes.empty,
                              context,
                              message: 'empty',
                            );
                          },
                        ),
                      ),
                      ///AppOutlinedDangerButton
                      TestingContainer(
                        title: 'AppOutlinedDangerButton',
                        widget: AppOutlinedDangerButton(
                          text: 'showSnackBar.success',
                          onPressed: () {
                            AppSnackBar.show(
                              context,
                              message: 'success',
                              type: AppSnackBarType.success,
                            );
                          },
                        ),
                      ),
                      ///AppPillButton
                      TestingContainer(
                        title: 'AppPillButton',
                        widget: AppPillButton(
                          text: 'showSnackBar.error',
                          onPressed: () {
                            AppSnackBar.show(
                              context,
                              message: 'error',
                              type: AppSnackBarType.error,
                            );
                          },
                        ),
                      ),
                      ///AppPrimaryIconButton
                      TestingContainer(
                        title: 'AppPrimaryIconButton',
                        widget: AppPrimaryIconButton(
                          text: 'showSnackBar.warning',
                          onPressed: () {
                            AppSnackBar.show(
                              context,
                              message: 'warning',
                              type: AppSnackBarType.warning,
                            );
                          },
                        ),
                      ),
                      /// AppSoftDangerButton
                      TestingContainer(
                        title: 'AppSoftDangerButton',
                        widget: AppSoftDangerButton(
                          text: 'showSnackBar.info',
                          onPressed: () {
                            AppSnackBar.show(
                              context,
                              message: 'info',
                              type: AppSnackBarType.info,
                            );
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ),
            
                      /// Cards start here
                      namedDivider( dividerTitle: 'Cards'),
                      /// AppDashboardCard
                      TestingContainer(
                          title: 'AppDashboardCard',
                          widget: AppDashboardCard(
                            title: 'الاجمالي',
                            amountText: '100 \$',
                            icon: Icons.attach_money,
                          )
                      ),
                      /// CircularProgressCard
                      TestingContainer(
                          title: 'CircularProgressCard',
                          widget: CircularProgressCard(
                            value: 90,
                          )
                      ),
                      /// CustomInfoCard  /  info
                      TestingContainer(
                          title: 'CustomInfoCard  /  info',
                          widget: CustomInfoCard(
                            type: CustomInfoCardType.info,
                            title: 'حالة المهمة',
                            description: 'info description\n info description',
                          )
                      ),
                      /// CustomInfoCard  /  warning
                      TestingContainer(
                          title: 'CustomInfoCard  /  warning',
                          widget: CustomInfoCard(
                            type: CustomInfoCardType.warning,
                            title: 'تنبيه !',
                            description: 'info description\n info description',
                          )
                      ),
                      /// MiniStatCard
                      TestingContainer(
                          title: 'MiniStatCard',
                          widget: MiniStatCard(
                            title: 'الموعد',
                            icon: Icons.attach_money,
                            value: '3 رجب',
                          )
                      ),
                      /// ProjectProgressCard
                      TestingContainer(
                          title: 'ProjectProgressCard',
                          widget: ProjectProgressCard(
                            title: 'تطبيق التجارة الالكترونية',
                            company: 'الشركة التقنية الحديثة',
                            progress: 50,
                            tasksText: '50/100 مهمة',
                            hoursText: '40/80 ساعة',
                          )
                      ),
            
                      /// logos start here
                      namedDivider( dividerTitle: 'logos'),
                      /// AppLogo  / splash
                      TestingContainer(
                          title: 'AppLogo  / splash',
                          widget: AppLogo.splash()
                      ),
                      /// AppLogo  / auth
                      TestingContainer(
                          title: 'AppLogo  / auth',
                          widget: AppLogo.auth()
                      ),
                      /// ProgressIndicators start here
                      namedDivider( dividerTitle: 'ProgressIndicator'),
                      /// ProgressIndicator / linear / right
                      TestingContainer(
                          title: 'AppProgressIndicator / linear / right',
                          widget: AppProgressIndicator(
                            value: 20,
                          )
                      ),
                      /// ProgressIndicator / linear / left
                      TestingContainer(
                          title: 'AppProgressIndicator / linear / left',
                          widget: AppProgressIndicator(
                            value: 30,
                            isRTL: false,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.yellow,
                                  Colors.green
                                ]),
                          )
                      ),
                      /// ProgressIndicator / dotted / right
                      TestingContainer(
                          title: 'AppProgressIndicator / dotted / right',
                          widget: AppProgressIndicator(
                            value: 40,
                            type: AppProgressType.dotted,
                          )
                      ),
                      /// ProgressIndicator / dotted / left
                      TestingContainer(
                          title: 'AppProgressIndicator / dotted / left',
                          widget: AppProgressIndicator(
                            value: 50,
                            type: AppProgressType.dotted,
                            isRTL: false,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.orange,
                                  Colors.red
                                ]),
                          )
                      ),
                      /// TaskLists start here
                      namedDivider( dividerTitle: 'TaskLists'),
                      /// TaskLists / inProgress
                      TestingContainer(
                          title: 'AppTaskList / inProgress',
                          widget: AppTaskList(
                            title: 'title',
                            subtitle: 'subtitle',
                            stateBadge: TaskStateBadge.inProgress,
                          )
                      ),
                      /// TaskLists / toDo
                      TestingContainer(
                          title: 'AppTaskList / toDo',
                          widget: AppTaskList(
                            title: 'title',
                            subtitle: 'subtitle',
                            stateBadge: TaskStateBadge.toDo,
                            sideColor: Colors.red,
                          )
                      ),
                      /// TaskListTiles start here
                      namedDivider( dividerTitle: 'TaskListTiles'),
                      /// AppTaskListTile / normal
                      TestingContainer(
                          title: 'AppTaskListTile / normal',
                          widget: AppTaskListTile(
                            title: 'title',
                            type: TaskTileType.normal,
                          )
                      ),
                      /// AppTaskListTile / alert
                      TestingContainer(
                          title: 'AppTaskListTile / alert',
                          widget: AppTaskListTile(
                            title: 'title',
                            type: TaskTileType.alert,
                          )
                      ),
                      /// AppTextField start here
                      namedDivider( dividerTitle: 'AppTextField'),
                      /// AppTextField
                      TestingContainer(
                          title: 'AppTextField',
                          widget: AppTextField(
                            label: 'label',
                            hint: 'hint',
                          )
                      ),
                      /// AppIconText start here
                      namedDivider( dividerTitle: 'AppIconText'),
                      /// AppIconText
                      TestingContainer(
                          title: 'AppIconText ',
                          widget: AppIconText(
                            text: 'text',
                            icon: Icons.add,
                            iconColor: Colors.red,
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}

Widget namedDivider({required  String dividerTitle}){

  return Column(
    children: [
       Divider(),
       SizedBox(height: 10,),
      Text(dividerTitle,
        style: TextStyle(
            color: ColorManager.secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w800
        ),
      )
  ],);
}