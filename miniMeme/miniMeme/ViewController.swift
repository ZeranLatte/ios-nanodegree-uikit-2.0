//
//  ViewController.swift
//  miniMeme
//
//  Created by ZZZZeran on 9/11/15.
//  Copyright (c) 2015 Z Latte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // meme struct
    struct Meme {
        var topText: String!
        var bottomText: String!
        var originalImage: UIImage!
        var memedImage: UIImage!
        
        init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
            self.topText = topText
            self.bottomText = bottomText
            self.originalImage = originalImage
            self.memedImage = memedImage
        }
       
    }
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSStrokeWidthAttributeName: -8
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        subscribeToKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = false
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        imagePickerView.image = nil
        viewDidLoad()
        viewWillAppear(false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func shareImage() {

        let image = generateMemedImage()
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(avc, animated: true, completion: nil)
        save()
    }
    
    
   
    
    // - UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFit
            shareButton.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // textField delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    // Move image view up and down code session
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.editing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    // hide the keyboard when editing the bottom textfield
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.editing {
           view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // unsubscribe
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Generating a Meme Object
    func save() -> Meme {
        let saved = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        return saved
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar.hidden = true
        navBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    

}

