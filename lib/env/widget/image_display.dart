// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:tandi_mobile/env/class/app_shorcut.dart';

// class ImageDisplay extends StatelessWidget {
//   const ImageDisplay({
//     super.key,
//     this.image,
//     required this.x,
//     this.isLocal = false,
//     this.fileLocal,
//     required this.onTap,
//     this.canDelete = true,
//   });

//   final List<File>? image;
//   final int x;
//   final bool isLocal, canDelete;
//   final String? fileLocal;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     var my = AppShortcut.of(context);

//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       width: MediaQuery.of(context).size.width / 4.2,
//       height: 82,
//       decoration: const BoxDecoration(
//         shape: BoxShape.rectangle,
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: isLocal
//                 ? Image.file(
//                     File(fileLocal!),
//                     width: MediaQuery.of(context).size.width / 4.2,
//                     height: 82,
//                     fit: BoxFit.cover,
//                   )
//                 : Image.network(
//                     // 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
//                     image?[x].photo != ''
//                         ? 'https://apps.gts-shipyard.com/${image?[x].photo}'
//                         : 'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
//                     width: MediaQuery.of(context).size.width / 4.2,
//                     height: 82,
//                     fit: BoxFit.cover,
//                   ),
//           ),
//           canDelete == true
//               ? Align(
//                   alignment: Alignment.topRight,
//                   child: InkWell(
//                     onTap: onTap,
//                     child: Icon(
//                       Icons.close,
//                       color: my.color.primary,
//                       size: 24,
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
