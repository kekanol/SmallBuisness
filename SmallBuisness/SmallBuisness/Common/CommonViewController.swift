//
//  UIViewController+Extension.swift
//  SmallBuisness
//
//  Created by Константин on 04.10.2022.
//

import UIKit

class CommonViewController: UIViewController {

	lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
	}()

	var window: UIWindow {
		UIApplication.shared.windows[0]
	}

	func addTapRecognizerToHideKeyboard(_ target: UIView? = nil) {
		let target = target ?? view
		target?.addGestureRecognizer(tapGestureRecognizer)
	}

	private func removeTapRecognizerToHideKeyboard(_ target: UIView? = nil) {
		let target = target ?? view
		target?.removeGestureRecognizer(tapGestureRecognizer)
	}

	func subscribeToKeyboardNotifications() {
		subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardShown))
		subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardHidden))
	}

	private func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
	}

	func unsubscribeFromKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc
	func handleTap(sender: UITapGestureRecognizer? = nil) {
		window.endEditing(true)
	}

	@objc
	private func keyboardShown(notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] else { return }
		addTapRecognizerToHideKeyboard()

		let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
		handleKeyboardDidShown(endRect)
	}

	@objc
	private func keyboardHidden(notification: NSNotification) {
		guard  let userInfo = notification.userInfo,
			   let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] else { return }
		removeTapRecognizerToHideKeyboard()

		let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
		handleKeyboardDidHidden(endRect)
	}

	func handleKeyboardDidShown(_ keyboardBounds: CGRect) { }

	func handleKeyboardDidHidden(_ keyboardBounds: CGRect) { }
}

