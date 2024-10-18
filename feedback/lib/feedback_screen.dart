import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _images = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    messageController.text = "";
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images = pickedImages;
      });
    }
  }

  void _removeImage(XFile image) {
    setState(() {
      _images?.remove(image);
    });
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Basic ${base64Encode(utf8.encode('50e59afd1b9a0706e3cf5c1edd2d6c24473b2ce1:X'))}';
      dio.options.baseUrl = "https://docsapi.helpscout.net/v1/";

      FormData formData = FormData.fromMap({
        "message": messageController.text,
        // "images": _images
        //         ?.map((image) => MultipartFile.fromFileSync(image.path,
        //             filename: image.name))
        //         .toList() ??
        //     [],
      });

      Response response = await dio.post('/collections', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feedback submitted successfully!")),
        );
        messageController.clear();
        setState(() {
          _images = [];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to submit feedback. Try again.")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearError(String value) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2d9cdb),
          title: const Text(
            "Send Us Feedback",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      CustomTextField(
                          label: "Your Message",
                          controller: messageController,
                          hintText: "Give us feedback",
                          errorText: "Please enter your message",
                          maxLines: 7,
                          suffixIcons: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: IconButton(
                                  icon: const Icon(Icons.image_outlined),
                                  onPressed: _pickImage,
                                ),
                              ),
                            ],
                          ),
                          images: _images,
                          onImageRemove: _removeImage,
                          onChanged: _clearError),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _submitFeedback,
                        child: const Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2d9cdb),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 40),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final int maxLines;
  final Widget? suffixIcons;
  final Function(String)? onChanged;
  final List<XFile>? images;
  final Function(XFile)? onImageRemove;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.errorText,
    this.maxLines = 1,
    this.suffixIcons,
    this.onChanged,
    this.images,
    this.onImageRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 5),
        IntrinsicHeight(
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                maxLines: maxLines,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return errorText;
                  }
                  return null;
                },
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  errorStyle: const TextStyle(fontSize: 14),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  suffixIcon: suffixIcons,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 190, 42, 31)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 190, 42, 31)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              if (images != null && images!.isNotEmpty)
                SizedBox(
                  height: 65,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: images!.map((image) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                child: Image.file(
                                  File(image.path),
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -15,
                              right: -15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () => onImageRemove?.call(image),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
