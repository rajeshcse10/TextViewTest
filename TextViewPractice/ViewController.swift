//
//  ViewController.swift
//  TextViewPractice
//
//  Created by Rajesh Karmaker on 19/1/19.
//  Copyright © 2019 Rajesh Karmaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var mTextView: UITextView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTextView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.mTextView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
    }
    @objc func updateTextView(notification:Notification){
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            mTextView.contentInset = UIEdgeInsets.zero
        }
        else{
            mTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            mTextView.scrollIndicatorInsets = mTextView.contentInset
            mTextView.scrollRangeToVisible(mTextView.selectedRange)
        }
    }
    @IBAction func btnAction(_ sender: Any) {
        if heightConstraint.constant == 128{
            heightConstraint.constant = 256
        }
        else{
            heightConstraint.constant = 128
        }
        self.view.layoutIfNeeded()
    }
    
}

