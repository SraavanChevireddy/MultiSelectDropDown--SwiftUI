//
//  UploaderView.swift
//  MultiSelectDropDown
//
//  Created by Sraavan Chevireddy on 3/11/22.
//

import SwiftUI

struct UploaderView: View {
    @Binding var data: Data
    
    var body: some View {
        Image(uiImage: UIImage(data: data, scale: 0.6) ?? UIImage())
            .resizable()
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .shadow(radius: 3)
    }
}
