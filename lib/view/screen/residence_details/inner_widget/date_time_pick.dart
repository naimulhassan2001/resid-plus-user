import 'package:flutter/material.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimePick extends StatefulWidget {
  const DateTimePick({super.key});

  @override
  State<DateTimePick> createState() => _DateTimePickState();
}

class _DateTimePickState extends State<DateTimePick> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              SfDateRangePicker(
                // onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: AppColors.black20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  Icon(Icons.calendar_month_outlined,color: AppColors.blackPrimary,size: 18,),
                  // SvgPicture.asset(AppIcons.calander),
                  SizedBox(width: 8,),
                  Text("Select Date",style: TextStyle(color: AppColors.black60,fontSize: 14,fontWeight: FontWeight.w400),)

                ],),
              ),

            ),
          ),

        ),
        const SizedBox(width: 8,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              // return DatePickerDialog(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)
              
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: AppColors.black20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  // SvgPicture.asset(AppIcons.calander,color: AppColors.blackPrimary,),
                  Icon(Icons.watch_later_outlined,color: AppColors.blackPrimary,size: 18,),
                  SizedBox(width: 8,),
                  Text("Select Date",style: TextStyle(color: AppColors.black60,fontSize: 14,fontWeight: FontWeight.w400),)

                ],),
              ),

            ),
          ),

        ),
      ],
    );
  }
}
