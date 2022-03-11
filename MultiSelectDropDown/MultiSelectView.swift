//
//  MultiSelectView.swift
//  MultiSelectDropDown
//
//  Created by Sraavan Chevireddy on 3/11/22.
//

import SwiftUI

struct DropDownView<Content:View>: View{

    var actionItems = requiredActions.allCases
    @ViewBuilder var content: Content
    
    @State private var presenter = viewToPresent.photoLibrary
    
    @State var showPicker = false
    @State var showUploader = false
    @State var selectedData = Data()
    
    var body: some View{
        Menu{
            ForEach(actionItems, id: \.self){ eachAction in
                Section{
                    Menu{
                        Button("Camera"){
                            presenter = .cameraView
                            print("Tapped on Camera for \(eachAction.rawValue)")
                        }
                        Button("Photo Library"){
                            presenter = .photoLibrary
                            showPicker.toggle()
                            print("Tapped on PhotoLibrary for \(eachAction.rawValue)")
                        }
                        Button("Files"){
                            presenter = .files
                            print("Tapped on Files for \(eachAction.rawValue)")
                        }
                    } label: {
                        Text(eachAction.rawValue)
                    }
                }
            }
        } label:{
            content
        }
        .sheet(isPresented: $showPicker) {
            if presenter == .photoLibrary{
                ImagePickerView(sourceType: .photoLibrary) { imagePicked in
                    print("Picked from Gallery")
                    if let data = imagePicked.jpegData(compressionQuality: 1.0){
                        selectedData = data
                        showUploader.toggle()
                    }
                }
            }else if presenter == .cameraView{
                ImagePickerView(sourceType: .camera) { cameraImage in
                    print("Picked from Camera")
                    showUploader.toggle()
                }
            }else{
                Text("Files Are loading")
//                showUploader.toggle()
            }
        }
        .sheet(isPresented: $showUploader) {
            UploaderView(data: $selectedData)
        }
    }
}

enum requiredActions:String{
    static let allCases = [photoId, intakeForm, invoice]

    case photoId = "Upload PhotoID/ Verification Form"
    case intakeForm = "Upload Intake Forms"
    case invoice = "Upload Invoice"
}

enum viewToPresent{
    case cameraView
    case photoLibrary
    case files
}

