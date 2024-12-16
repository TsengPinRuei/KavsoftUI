//
//  TextActionView.swift
//  TextFieldMenuAction
//
//  Created by 曾品瑞 on 2024/11/14.
//

import SwiftUI

struct TextActionView: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var delegate: UITextFieldDelegate?
        var parent: TextActionView
        
        init(parent: TextActionView) {
            self.parent=parent
        }
        
        func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions suggest: [UIMenuElement]) -> UIMenu? {
            var action: [UIMenuElement]=[]
            let custom=self.parent.action.compactMap { item in
                let action: UIAction=UIAction(title: item.title) { _ in
                    item.action(range, textField)
                }
                return action
            }
            
            if(self.parent.show) {
                action=custom+suggest
            } else {
                action=custom
            }
            
            let menu: UIMenu=UIMenu(children: action)
            return menu
        }
        func textFieldDidChangeSelection(_ field: UITextField) {
            self.delegate?.textFieldDidChangeSelection?(field)
        }
    }
    
    var show: Bool
    var action: [TextAction]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UIView {
        let view: UIView=UIView(frame: .zero)
        
        view.backgroundColor=UIColor.clear
        DispatchQueue.main.async {
            if let field=view.superview?.superview?.subviews.last?.subviews.first as? UITextField {
                context.coordinator.delegate=field.delegate
                field.delegate=context.coordinator
            }
        }
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) { }
}
