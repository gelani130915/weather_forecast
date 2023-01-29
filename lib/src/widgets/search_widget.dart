// // ignore_for_file: library_private_types_in_public_api, unnecessary_this

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weather_forecast/src/blocs/places_bloc/places_bloc.dart';
// import 'package:weather_forecast/src/models/interface/selectable_item.dart';

// class SearchWidget<T extends SelectableItem> extends StatefulWidget {
//   final List<T>? initialList;
//   final String label;
//   final TextEditingController? controller;
//   final Function(T?) getSelectedValue;
//   final InputDecoration? decoration;
//   final TextStyle? textStyle;
//   final int minStringLength;
//   final T? selectedItem; 
//   final String? hintText;
//   final String? helperText;
//   final bool showIcon;
//   final IconData upIcon;
//   final IconData downIcon;
//   final bool showRadio;
//   final BoxDecoration? itemDecoration;
//   final bool isFilterModal;
//   final TextStyle? labelStyle;
//   final double iconSize;
//   final Color? textColor;
//   final Function(String) onSearch;

//   const SearchWidget(
//       {Key? key,
//       this.initialList,
//       required this.label,
//       this.controller,
//       this.textStyle,
//       required this.getSelectedValue,
//       this.decoration,
//       this.minStringLength = 2,
//       this.selectedItem, 
//       this.hintText,
//       this.helperText,
//       this.showIcon = true,
//       this.upIcon = Icons.search,
//       this.downIcon = Icons.search,
//       this.showRadio = false,
//       this.itemDecoration,
//       this.isFilterModal = false,
//       this.labelStyle,
//       this.iconSize = 15.0,
//       this.textColor,
//       required this.onSearch})
//       : super(key: key);

//   @override
//   _SearchWidgetState createState() => _SearchWidgetState();
// }

// class _SearchWidgetState<T extends SelectableItem> extends State<SearchWidget> {
//   final FocusNode _focusNode = FocusNode();
//   late OverlayEntry _overlayEntry;
//   final LayerLink _layerLink = LayerLink();
//   List<T>? filteredList = <T>[];
//   List<T>? elementsList = <T>[];
//   bool hasFuture = false;
//   bool _isOpen = false;
//   bool? itemsFound;
//   T? _selectedItem;
//   bool isExpanded = false;
//   String? errorType;
//   bool errorActive = false;

//   TextEditingController? _editController;

//   var _focusListener;

//   void resetList() {
//     List<T> tempList = <T>[];
//     setState(() {
//       filteredList = tempList;
//     });
//     this._overlayEntry.markNeedsBuild();
//   }

//   void resetState(List<T> tempList) {
//     setState(() {
//       this.filteredList = tempList;
//       itemsFound = tempList.isEmpty && _editController!.text.isNotEmpty
//           ? false
//           : true;
//     });
//     this._overlayEntry.markNeedsBuild();
//   }

//   void updateList({bool loadAll = false}) {
//     this.filteredList = elementsList;
//     if (loadAll) {
//       this.resetState(this.filteredList ?? []);
//     } else {
//       List<T> tempList = <T>[];
//       for (int i = 0; i < filteredList!.length; i++) {
//         final text = _editController!.text.toLowerCase();
//         if (this.filteredList![i].getValue().toLowerCase().contains(text)) {
//           tempList.add(this.filteredList![i]);
//         }
//       }
//       this.resetState(tempList);
//     }
//   }

//   @override
//   void didUpdateWidget(covariant SearchWidget<SelectableItem> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _selectedItem = widget.selectedItem as T?;
//     if ((!widget.isFilterModal) && _selectedItem == null) {
//       // _editController!.clear();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     elementsList = widget.initialList as List<T>;
//     _editController = widget.controller ?? TextEditingController();
//     _selectedItem =
//         widget.selectedItem != null ? widget.selectedItem as T : null;
//     _editController?.text = _selectedItem?.getValue() ?? '';
//     _focusListener = () {
//       if (_focusNode.hasFocus && _isOpen && mounted) {
//         this._overlayEntry = this._createOverlayEntry();
//         isExpanded = true;
//         Overlay.of(context)!.insert(this._overlayEntry);
//         updateList(loadAll: true);
//       } else if (!_isOpen && mounted) {
//         isExpanded = false;
//         this._overlayEntry.remove();
//         if (itemsFound == false) {
//           resetList();
//           if (widget.selectedItem == null) {
//             _editController!.clear();
//           }
//         }
//         if (filteredList!.isNotEmpty) {
//           bool textMatchesItem = false;

//           textMatchesItem = filteredList!.any((SelectableItem item) =>
//               item.getValue() == _editController!.text);

//           if (textMatchesItem == false && widget.selectedItem == null) {
//             _editController!.clear();
//           }
//           resetList();
//         }
//       } else if (_isOpen && (_focusNode.hasFocus == false) && mounted) {
//         isExpanded = false;
//         this._overlayEntry.remove();
//       }
//     };
//     _focusNode.addListener(_focusListener);
//   }

//   @override
//   void dispose() {
//     _editController!.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   _listViewBuilder(context) {
//     if (itemsFound == false) {
//       return ListView(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         physics: const ScrollPhysics(),
//         children: const [],
//       );
//     }
//     return ListView.builder(
//       itemCount: filteredList!.length,
//       physics: const ScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, i) {
//         var item = filteredList![i];
//         return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedItem = item;
//                 _editController!.text =
//                     _selectedItem?.getValue() ?? widget.label;
//                 widget.getSelectedValue(_selectedItem);
//               });
//               resetList();
//               FocusScope.of(context).unfocus();
//               _isOpen = false;
//             },
//             child: Container(
//               decoration: widget.itemDecoration ?? buildItemDecoration(),
//               child: widget.showRadio
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           buildTextItem(item, context),
//                           Radio(
//                             activeColor: Theme.of(context).colorScheme.primary,
//                             fillColor: MaterialStateProperty.resolveWith<Color>(
//                                 (states) {
//                               if (states.contains(MaterialState.disabled)) {
//                                 return Theme.of(context).disabledColor;
//                               } else if (states
//                                   .contains(MaterialState.selected)) {
//                                 return Theme.of(context).colorScheme.primary;
//                               }
//                               return Theme.of(context).disabledColor;
//                             }),
//                             onChanged: (T? value) {
//                               setState(() {
//                                 _selectedItem = item;
//                                 _editController!.text =
//                                     _selectedItem?.getValue() ?? widget.label;
//                                 widget.getSelectedValue(item);
//                               });
//                               resetList();
//                               FocusScope.of(context).unfocus();
//                             },
//                             groupValue: _selectedItem,
//                             value: item,
//                           )
//                         ],
//                       ),
//                     )
//                   : buildTextItem(item, context),
//             ));
//       },
//       padding: EdgeInsets.zero,
//     );
//   }

//   BoxDecoration buildItemDecoration() {
//     return BoxDecoration(
//       border: Border(
//         bottom: BorderSide(
//           color: Theme.of(context).disabledColor,
//         ),
//       ),
//     );
//   }

//   buildTextItem(item, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         item.getValue(),
//       ),
//     );
//   }

//   Widget? _listViewContainer(context) {
//     if (itemsFound == true && filteredList!.isNotEmpty ||
//         itemsFound == false && _editController!.text.isNotEmpty) {
//       return Container(
//         child: _listViewBuilder(context),
//       );
//     }
//     return null;
//   }

//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     Size overlaySize = renderBox.size;
//     Size screenSize = MediaQuery.of(context).size;
//     double screenWidth = screenSize.width;
//     return OverlayEntry(
//         builder: (context) => Stack(
//               children: [
//                 Material(
//                   type: MaterialType.transparency,
//                   color: Colors.red[50],
//                   child: GestureDetector(
//                     onTapDown: (d) {
//                       if (isExpanded) {
//                         if(_selectedItem == null){
//                           elementsList?.clear();
//                         }
//                         _focusNode.unfocus();
//                       }
//                       setState(() {
//                         _isOpen = false;
//                       });
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   width: overlaySize.width, 
//                   child: CompositedTransformFollower(
//                     link: _layerLink,
//                     showWhenUnlinked: false,
//                     offset: Offset(
//                         0.0, overlaySize.height + (errorActive ? 5.0 : -15)),
//                     child: Material(
//                       elevation: 6.0,
//                       child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minWidth: screenWidth,
//                             maxWidth: screenWidth,
//                             minHeight: 0,
//                             // max height set to 150
//                             maxHeight: itemsFound == true ? 150 : 55,
//                           ),
//                           child: _listViewContainer(context)),
//                     ),
//                   ),
//                 ),
//               ],
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<PlacesBloc, PlacesState>(
//           listener: (context, state) {
//             if (state is SuccessPlacesState) {
//               setState(() {
//                 elementsList = state.places as List<T>;
//                 updateList();
//               });
//             }
//           },
//         )
//       ],
//       child: CompositedTransformTarget(
//         link: this._layerLink,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.label, style: widget.labelStyle),
//             TextFormField(
//               controller: _editController,
//               focusNode: this._focusNode,
//               textInputAction: TextInputAction.next,
//               style: widget.textStyle,
//               decoration: widget.decoration ??
//                   InputDecoration(
//                     // hintText: widget.hintText,
//                     // helperText: widget.helperText,
//                     // enabledBorder: UnderlineInputBorder(
//                     //   borderSide: BorderSide(
//                     //     color: Theme.of(context).primaryColor,
//                     //   ),
//                     // ),
//                     errorBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Theme.of(context).errorColor,
//                       ),
//                     ),
//                     contentPadding: EdgeInsets.all(8),
//                     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(50.0),
//       ),
//                     suffixIcon: widget.showIcon
//                         ? Padding(
//                             padding: const EdgeInsets.only( left: 15),
//                             child: InkWell(
//                               onTap: () {
//                                 if (isExpanded) {
//                                   _focusNode.unfocus();
//                                 } else {
//                                   _focusNode.requestFocus();
//                                 }
//                                 setState(() {
//                                   _isOpen = true;
//                                 });
//                               },
//                               child: Icon(
//                                 isExpanded ? widget.upIcon : widget.downIcon,
//                                 color: Theme.of(context).disabledColor,
//                                 size: widget.iconSize,
//                               ),
//                             ),
//                           )
//                         : null,
//                   ),
//               onChanged: (value) => widget.onSearch(value),
//               onTap: () {
//                 _isOpen = true;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
