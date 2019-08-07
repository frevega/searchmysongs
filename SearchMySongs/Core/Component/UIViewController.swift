//
//  UIViewController.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/7/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

extension UIViewController {
    enum Defaults {
        static var center: CGPoint?
        static let navigatorBarHeight: CGFloat = 64
        static var keyboardHeight: CGFloat?
        static var bottomPadding: CGFloat = 8
        static let toolbarHeight: CGFloat = 50
        static let toolbarBorderHeight: CGFloat = 15
        static let paddingDoneWithNumberPad: CGFloat = 35
        static let paddingDone: CGFloat = 16
        static let headerHeight: CGFloat = 77
        static var extraPadding: CGFloat = 0
        static let tabBarAnimationDuration: TimeInterval = 0.3
    }
    
    private enum Keyboard {
        static var fieldFirstResponder: UIView?
        static var keyboardType: UIKeyboardType?
        static var toolbarKeyboard = UIView()
        static var keyboardButton = UIButton()
        static var fields: [UIView]?
        static var prevButton: UIBarButtonItem?
        static var nextButton: UIBarButtonItem?
        static var updatePosition = false
    }
    
    private enum GestureRecognizers {
        static var dismissKeyboard: UITapGestureRecognizer?
    }
    
    /// Displays a view controller `content` within a the provided `frame`
    /// - Parameter content: View controller to be displayed as child
    /// - Parameter frame: Frame to display the view controller in
    func display(content: UIViewController, frame: CGRect?) {
        addChild(content)
        content.view.frame = frame ?? view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    /// setUpdatePositionIfNeeded(of object:, keyboard:)
    /// Method to register view for update its position related to screen and keyboard size
    /// - Parameter object: view that does need to update position
    /// - Parameter keyboard: keyboard type needed to put Return button
    func setUpdatePositionIfNeeded(of object: UIView, keyboard: UIKeyboardType? = nil, extraPadding: CGFloat = 0) {
        Keyboard.fieldFirstResponder = object
        Defaults.extraPadding = extraPadding
        Keyboard.updatePosition = true
        guard let keyboard = keyboard else { return }
        Keyboard.keyboardType = keyboard
    }
    
    /// updatePositionIfNeeded()
    /// Method trigger by keyboardWillAppear notification
    private func updatePositionIfNeeded() {
        restorePosition()
        guard let keyboardHeight = Defaults.keyboardHeight else { return }
        guard let object = Keyboard.fieldFirstResponder else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let rootViewController = window.rootViewController else { return }
        guard let superview = rootViewController.presentedViewController?.view ?? rootViewController.view else { return }
        let rect = object.bounds
        let convertRect = object.convert(rect, to: superview)
        let navigatorBarHeight = (rootViewController.presentedViewController != nil) ? 0 : Defaults.navigatorBarHeight
        let leftBottomCornerY = convertRect.maxY - navigatorBarHeight
        let bounds = view.bounds
        let keyboardTop = bounds.size.height - keyboardHeight - Defaults.bottomPadding
        Defaults.center = superview.center
        
        if leftBottomCornerY > keyboardTop {
            let delta = leftBottomCornerY - keyboardTop
            UIView.animate(withDuration: 0.3, animations: {
                superview.center = CGPoint(
                    x: Defaults.center!.x,
                    y: Defaults.center!.y - delta - Defaults.extraPadding
                )
            })
        }
    }
    
    /// restorePosition(reset:)
    /// Restore position when keyboardWillDisappear
    /// - Parameter reset: Delete view reference after restore its position
    func restorePosition(reset: Bool = false) {
        guard let point = Defaults.center else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let rootViewController = window.rootViewController else { return }
        guard let superview = rootViewController.presentedViewController?.view ?? rootViewController.view else { return }
        superview.center = point
        if reset {
            Keyboard.fieldFirstResponder = nil
            Keyboard.keyboardType = nil
            Keyboard.updatePosition = false
        }
    }
    
    /// registerKeyboardNotifications()
    /// Register keyboard notifications
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(notification:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    /// unregisterKeyboardNotifications()
    /// Unregister keyboard notifications
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    /// keyboardWillAppear(notification:)
    /// Calls updatePositionIfNeeded and/or put Return button on numberPad keyboard
    @objc
    func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
        Defaults.keyboardHeight = keyboardHeight
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        GestureRecognizers.dismissKeyboard = gesture
        view.addGestureRecognizer(GestureRecognizers.dismissKeyboard!)
        
        guard let field = Keyboard.fieldFirstResponder else { return }
        
        if Keyboard.updatePosition {
            updatePositionIfNeeded()
        }
        if let fields = Keyboard.fields {
            var index: Array<Any>.Index = fields.count - 1
            if fields.contains(field) {
                if let fieldIndex = fields.firstIndex(of: field) {
                    index = fieldIndex
                }
            } else if let superview = field.superview {
                if fields.contains(superview) {
                    if let fieldIndex = fields.firstIndex(of: superview) {
                        index = fieldIndex
                    }
                }
            }
            
            Keyboard.prevButton?.isEnabled = index != 0
            Keyboard.nextButton?.isEnabled = index != fields.count - 1
        }
    }
    
    /// keyboardWillDisappear(notification:)
    /// Remove gestureRecognizer when it corresponds
    @objc
    func keyboardWillDisappear(notification _: NSNotification) {
        guard let dismissKeyboard = GestureRecognizers.dismissKeyboard else { return }
        view.removeGestureRecognizer(dismissKeyboard)
    }
    
    /// dismissKeyboard()
    /// Action for Return Button
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
        Keyboard.keyboardButton.isHidden = true
        Keyboard.toolbarKeyboard.isHidden = true
    }
    
    /// prepareKeyboardToolbar(textFields:, keyboardType)
    /// - Parameter textFields: if fields is part of form, arrows available
    /// - Parameter keyboardType: if keyboardType = .numberPad, add padding to left
    func prepareKeyboardToolbar(textFields: [UIView]?, keyboardType: UIKeyboardType? = nil) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(dismissKeyboard))
        let padding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        padding.width = keyboardType != nil ? Defaults.paddingDoneWithNumberPad : Defaults.paddingDone
        doneButton.accessibilityIdentifier = "doneBarButton"
        
        let array = NSMutableArray(array: [padding, flexibleSpace, flexibleSpace, flexibleSpace, doneButton, padding])
        
        guard let textFields = textFields, !textFields.isEmpty else {
            toolbar.setItems(array as? [UIBarButtonItem], animated: true)
            return toolbar
        }
        
        Keyboard.fields = textFields
        
        toolbar.setItems(array as? [UIBarButtonItem], animated: true)
        return toolbar
    }
    
    func registerFirstResponder(field: UIView) {
        Keyboard.fieldFirstResponder = field
    }
}

