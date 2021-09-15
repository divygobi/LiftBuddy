//
//  HideKeyboardExtension.swift
//  
//
//  Created by Divy Gobiraj on 9/8/21.
//

import SwiftUI
#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
