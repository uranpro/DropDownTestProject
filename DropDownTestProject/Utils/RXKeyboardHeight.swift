//
//  RXKeyboardHeight.swift
//  DropDownTestProject
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 rt. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

func keyboardHeight() -> Observable<CGFloat> {
    return Observable
        .from([
            NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow)
                .map { notification -> CGFloat in
                    (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            },
            NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide)
                .map { _ -> CGFloat in
                    0
            }
            ])
        .merge()
}
