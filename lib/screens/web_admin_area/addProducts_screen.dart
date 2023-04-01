// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison, avoid_print

import 'dart:io';

import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/utitlies/style.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:ecommerce_app/widget/myTextFormField.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const String id = "AddProductScreen";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool isSaving = false;
  bool isUploadiing = false;
  String? selectedValue;
  // ignore: non_constant_identifier_names
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController titleC = TextEditingController();
  TextEditingController despC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountC = TextEditingController();
  TextEditingController serialC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  bool isFav = false;
  bool onSale = false;
  bool ispopular = false;
  final formKey = GlobalKey<FormState>();
  @override
  var uuid = Uuid();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Add Products",
                      style: BoldStyle.boldStyle,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        hint: const Text("Choose a category"),
                        validator: (value) {
                          if (value == null) {
                            return ('Category must be selected');
                          }
                          return null;
                        },
                        value: selectedValue,
                        items: categories
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e.title,
                                child: Text(e.title!),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        },
                      ),
                    ),
                    MyTextFormField(
                      controller: titleC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Product Title",
                    ),
                    MyTextFormField(
                      controller: despC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Product Details",
                    ),
                    MyTextFormField(
                      controller: priceC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Product Price",
                    ),
                    MyTextFormField(
                      controller: discountC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Product Discount Price",
                    ),
                    MyTextFormField(
                      controller: serialC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Product Serial No#",
                    ),
                    MyTextFormField(
                      controller: brandC,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          return "value Should Not be Empty";
                        }
                        return null;
                      },
                      hintText: "Brand Name",
                    ),
                    MyButton(
                      onPress: () {
                        pickImg();
                      },
                      buttonText: "Pick Image",
                      isLogin: true,
                    ),
                    // MyButton(
                    //   onPress: () {
                    //     uploadImages();
                    //   },
                    //   buttonText: "Upload Image",
                    //   isLoading: isUploadiing,
                    //   isLogin: true,
                    // ),
                    Container(
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    images.removeAt(index);
                                  },
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          );
                        },
                      ),
                    ),
                    SwitchListTile(
                      title: const Text("Is this product is on sale?"),
                      value: onSale,
                      onChanged: (v) {
                        setState(() {
                          onSale = !onSale;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text("Is this product is popular?"),
                      value: ispopular,
                      onChanged: (value) {
                        setState(() {
                          ispopular = !ispopular;
                        });
                      },
                    ),
                    MyButton(
                      isLoading: isSaving,
                      buttonText: "Save ",
                      onPress: () {
                        saveData();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImg() async {
    final List<XFile> pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("No image is seleted");
    }
  }

  Future postImage(XFile? imageFile) async {
    setState(() {
      isUploadiing = true;
    });
    String urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploadiing = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImage(image).then((downLoadUrl) => imageUrls.add(downLoadUrl));
    }
  }

  saveData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });
      await uploadImages();
      await ProductModel.addProduct(ProductModel(
        category: selectedValue,
        id: uuid.v4(),
        productTitle: titleC.text,
        productDesp: despC.text,
        productPrice: int.parse(priceC.text),
        productDiscount: int.parse(discountC.text),
        srialCode: serialC.text,
        brandName: brandC.text,
        imageUrl: imageUrls,
        isFav: isFav,
        onSale: onSale,
        isPopular: ispopular,
      )).whenComplete(() {
        setState(() {
          isSaving = false;
          images.clear();
          imageUrls.clear();
          categoryC.clear();
          titleC.clear();
          despC.clear();
          priceC.clear();
          discountC.clear();
          serialC.clear();
        });
        return ElegantNotification.success(
                title: const Text("Update"),
                description: const Text("Your product has been updated"))
            .show(context);
      });

      // await FirebaseFirestore.instance
      //     .collection("products")
      //     .add({"images": imageUrls}).whenComplete(() {
      //   setState(() {
      //     isSaving = false;
      //     images.clear();
      //     imageUrls.clear();
      //     categoryC.clear();
      //     titleC.clear();
      //     despC.clear();
      //     priceC.clear();
      //     discountC.clear();
      //     serialC.clear();
      //   });

      // });
    }
  }
}
