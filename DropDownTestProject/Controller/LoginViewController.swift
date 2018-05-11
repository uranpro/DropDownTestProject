//
//  ViewController.swift
//  dropdown
//
//  Created by Mikhail Bushuev on 10/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var keyboardDisposeBag = DisposeBag()
    
    @IBOutlet weak var loginContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginContainerView: UIView!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardEvents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unsubscribeFromKeyboardEvents()
        
        textFields.forEach { (field) in
            field.resignFirstResponder()
        }
    }
    
    // MARK: Helpers
    
    func bind() {
        // hide on return button pressed
        let fieldObservers = textFields.map {
            $0.rx.controlEvent(.editingDidEndOnExit).asObservable()
        }
        Observable.merge(fieldObservers).subscribe(onNext: { x in
            
        }).disposed(by: disposeBag)
    }
    
    func keyboardUpdates(_ height: CGFloat) {
        let viewBottomY = loginContainerView.frame.maxY
        let visibleSpace = view.bounds.size.height - height
        let spacing = viewBottomY > visibleSpace ? viewBottomY - visibleSpace : 0
        
        self.loginContainerConstraint.constant = -spacing
        
        UIView.animate(withDuration: 0.375) {
            self.loginContainerView.superview?.layoutIfNeeded()
        }
    }
    
    func subscribeToKeyboardEvents() {
        keyboardHeight()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (height) in
                self.keyboardUpdates(height)
            }).disposed(by: keyboardDisposeBag)
    }
    
    func unsubscribeFromKeyboardEvents() {
        keyboardDisposeBag = DisposeBag()
    }
}

