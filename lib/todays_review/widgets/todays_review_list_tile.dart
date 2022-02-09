import 'dart:async';

import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TodaysReviewListTile extends StatelessWidget {
  const TodaysReviewListTile({
    Key? key,
    required this.entry,
    this.onTap,
  }) : super(key: key);

  final Entry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final _entryTitle = entry.title;
    final _entrySource = entry.source;
    final _entryActivationDate = entry.activationDate;
    final _entryNotes = entry.notes;
    final _entryUrl = entry.relatedUrl;


      Future _launchURL(String url) async {
        //define submethod to attemp http if https fails below
        Future<void> _launchWithHttp(String url) async {
          final newUrl = 'http://$url';
          await canLaunch(newUrl)
              ? unawaited(launch(newUrl))
              : throw Exception('Could not launch Url');
        }

        //to start, just launch if formatted correctly
        if (url.contains(
              'http://',
            ) ||
            url.contains('https://')) {
          await canLaunch(url)
              ? unawaited(launch(url))
              : throw Exception('Could not launch Url');
          //if not formatted correctly try with https
        } else {
          final newUrl = 'https://$url';
          await canLaunch(newUrl)
              ? unawaited(launch(newUrl))
              ///if that fails...
              : _launchWithHttp(url);
        }
      }
      
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              title: Text(_entryTitle),
              subtitle: (_entrySource != null)
                  ? Text(_entrySource)
                  : const SizedBox(),
              trailing: Container(
                padding: const EdgeInsets.only(right: 8),
                child: Transform.rotate(
                  angle: -0.78539,
                  child: InkWell(
                    onTap: _entryUrl != null 
                       ? () => _launchURL(_entryUrl)
                       : () {},
                    child: const Icon(Icons.link, size: 18),
                  ),
                ),
              ),
            ),
            Text(_entryNotes),
            TextButton(onPressed: onTap, child: const Text('...'))
          ],
        ),
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: Column(
//             children: <Widget>[
//               if (entry.relatedUrl != '')
//                 InkWell(
//                   onTap: () {
//                     //define overall method
//                     void _launchURL(String url) async {
//                       //define submethod to attemp http if https fails below
//                       void _launchWithHttp(String url) async {
//                         final newUrl = 'http://$url';
//                         await canLaunch(newUrl)
//                             ? await launch(newUrl)
//                             : throw 'Could not launch Url';
//                       }

//                       //to start, just launch if formatted correctly
//                       if (url.contains('http://',) ||
//                           url.contains('https://')) {
//                         await canLaunch(url)
//                             ? await launch(url)
//                             : throw 'Could not launch Url';
//                         //if not formatted correctly try with https
//                       } else {
//                         final newUrl = 'https://$url';
//                         await canLaunch(newUrl)
//                             ? await launch(newUrl)

//                             ///if that fails...
//                             : _launchWithHttp(url);
//                       }
//                     }

//                     ///now, give it all a shot
//                     _launchURL(entry.relatedUrl!);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Transform.rotate(
//                       angle: -0.78539,
//                       child: const InkWell(
//                         child: Icon(
//                           Icons.link,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 Container(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: const Icon(
//                     Icons.link,
//                     size: 18,
//                     color: Colors.transparent,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 8,
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {},
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: Text(
//                     entry.title,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Container(
//                   child: entry.source != ''
//                       ? Text(
//                           entry.source.toString(),
//                           style: TextStyle(color: Colors.grey[500]),
//                         )
//                       : null,
//                 ),
//                 Text(
//                   entry.activationDate.toString(),
//                   style: TextStyle(color: Colors.grey[500]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Text(
//                     entry.notes,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
