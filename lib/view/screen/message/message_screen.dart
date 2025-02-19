import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/socket_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  BookingListModel bookingListModel = BookingListModel();

  int index = 0;
  String hostUid = "";
  String userUid = "";

  @override
  void initState() {
    bookingListModel = Get.arguments[0];
    index = Get.arguments[1];
    hostUid = bookingListModel.data!.attributes!.bookings![index].hostId!.id.toString();
    userUid = bookingListModel.data!.attributes!.bookings![index].userId!.id.toString();
    final socketService = Get.find<SocketService>();
    socketService.joinRoom(userUid);
    socketService.addNewChat({
      "participants": [userUid, hostUid],
    }, userUid);

    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = bookingListModel.data?.attributes?.bookings?[index];
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.black5,
        appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              IconButton(onPressed: () => Get.back(), icon:const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),

              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "${data!.userId?.image?.publicFileUrl}"),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                "${data.userId?.fullName.toString()}",
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackPrimary,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<SocketService>(
            builder: (socketService) {
              return socketService.messageList.isEmpty ? Center(
                  child: Text(
                      "No Data Found".tr,
                      style: GoogleFonts.raleway(fontSize: 20)
                  )
              ) : SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        socketService.messageList.length, (index) => Align(
                      alignment: socketService.messageList[index]["sender"]["role"] == "user" ? Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(bottom: 12),
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: socketService.messageList[index]["sender"]["role"] == "user" ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12)
                          ) : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)
                          ),
                          color: socketService.messageList[index]["sender"]["role"] == "user"
                              ? AppColors.blackPrimary
                              : const Color(0xffE2E2E2),
                        ),
                        child: Text(
                          socketService.messageList[index]["message"],
                          textAlign: TextAlign.start,
                          style: GoogleFonts.raleway(
                              color:socketService.messageList[index]["sender"]["role"] == "user"
                                  ? AppColors.whiteColor
                                  : AppColors.blackPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    )
                    ),
                  ),
              );
            }
        ),
        bottomNavigationBar: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackPrimary.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      blurRadius: 10,
                    ),
                  ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                        cursorColor: AppColors.blackPrimary,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.done,
                        controller: messageController,
                        style: GoogleFonts.raleway(
                            color: AppColors.blackPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 12, bottom: 12),
                          fillColor: AppColors.transparentColor,
                          filled: true,
                          hintText: "Type message".tr,
                          hintStyle: GoogleFonts.raleway(
                              color: AppColors.black40,
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.blackPrimary.withOpacity(0.5))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.blackPrimary.withOpacity(0.5))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.blackPrimary.withOpacity(0.5))
                          ),
                        ),
                      )
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      if(messageController.text != "" && messageController.text.isNotEmpty){
                        Get.find<SocketService>().addNewMessage(messageController.text, userUid, Get.find<SocketService>().chatId);
                      }

                      messageController.text = "";
                    },
                    child: const Icon(Icons.send,
                        color: AppColors.blackPrimary, size: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}