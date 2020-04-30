//
//    CameraProvider.swift
//    UIFramework
//
//    Created by Evan Welsh on 4/19/20.
//    Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public class CameraCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    
    public init(isShown: Binding<Bool>, image: Binding<Image?>, uiImage: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
        _uiImage = uiImage
    }

    public func imagePickerController(_: UIImagePickerController,
                                                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        image = Image(uiImage: unwrapImage)
        uiImage = unwrapImage
        isShown = false
    }

    public func imagePickerControllerDidCancel(_: UIImagePickerController) {
        isShown = false
    }
}

public struct NativeCameraView: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    
    public init(isShown: Binding<Bool>, image: Binding<Image?>, uiImage: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
        _uiImage = uiImage
    }

    public func makeCoordinator() -> CameraCoordinator {
        return Coordinator(isShown: $isShown, image: $image, uiImage: $uiImage)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<NativeCameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.cameraDevice = .front
        picker.imageExportPreset = .compatible
        return picker
    }

    public func updateUIViewController(_: UIImagePickerController,
                                                                         context _: UIViewControllerRepresentableContext<NativeCameraView>) {}
}
