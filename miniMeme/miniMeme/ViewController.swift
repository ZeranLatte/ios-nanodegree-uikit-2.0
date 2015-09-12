//
//  ViewController.swift
//  miniMeme
//
//  Created by ZZZZeran on 9/11/15.
//  Copyright (c) 2015 Z Latte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 12
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    // - UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .ScaleAspectFit
            self.imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // - UITextFieldDelegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    

}

