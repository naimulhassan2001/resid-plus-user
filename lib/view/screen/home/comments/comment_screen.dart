import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/view/screen/home/comments/comment_controller.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import '../../../widgets/text/custom_text.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
final controller =  Get.put(CommentController());
final homeController = Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));
int index = 0;
@override
  void initState() {
    final controller = Get.put(CommentController());
    controller.getCommentList(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "All Comments",),
      ),
      body: GetBuilder<CommentController>(
        builder: (controller) {
           return controller.isLoading? const Center(child: SizedBox(child: CircularProgressIndicator(color: AppColors.blackPrimary,))):
           controller.commentList.isEmpty?const Center(child: Text("Please write your valuable comment below")) : SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
             child:  Column(
               children: [
                 ListView.builder(
                   padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                   physics: const BouncingScrollPhysics(),
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   itemCount: controller.commentList.length,
                   itemBuilder: (context, index) {

                     return Row(
                       children: [
                     controller.commentList.isNotEmpty && controller.commentList[0].userId?.image?.publicFileUrl!= null ?
                     Container(
                             height: 40,
                             width: 40,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: CachedNetworkImageProvider(
                                controller.commentList[0].userId?.image?.publicFileUrl.toString() ??"",
                                 ),
                                 fit: BoxFit.fill,
                               ),
                             ),
                           ): Container(
                             height: 40,
                             width: 40,
                             decoration: const BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(image: AssetImage(AppImages.profileImage)),
                             ),
                           ),
                         Flexible(
                           child: CustomText(
                             left: 8,
                             top: 16,
                             bottom: 16,
                             textAlign: TextAlign.start,
                             text: controller.commentList[index].comment,
                             maxLines: 10,
                           ),
                         ),
                       ],
                     );

                   },
                 ),
               ],
             ),
           );

        }
      ),
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 44,left: 24,right: 8),
        child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
          child: Row(
          children: [
            Expanded(
              child: TextFormField(
                minLines: 1, // Set minimum number of lines
                maxLines: null, // Allow unlimited lines
                keyboardType: TextInputType.multiline,
                controller: controller.commentController,
                cursorColor: Colors.black45,
                decoration:  InputDecoration(
                  hintText: "Write Comment here",
                  border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Colors.black45)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.black45)
                  )
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if(controller.commentController.text != null && controller.commentController.text != "" && controller.commentController.text.isNotEmpty) {
                    controller.addComment();
                    controller.sentComments(widget.id);
                   // controller.commentController.clear();
                  }
                else{
                  controller.commentController.text = '';
                }
                },
              icon: const Icon(Icons.send, color: Colors.black, size: 30),
            ),
          ],
              ),
        ),
      ),
    );
  }
}
