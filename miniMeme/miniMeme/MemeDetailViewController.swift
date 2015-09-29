//
//  MemeDetailViewController.swift
//  miniMeme
//
//  Created by ZZZZeran on 9/24/15.
//  Copyright © 2015 Z Latte. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView?.image = meme.memedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "edit")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let memeEditorVC = segue.destinationViewController as! ViewController
        
        memeEditorVC.imagePickerView?.image = self.meme.memedImage
        memeEditorVC.topTextField?.text = "self.meme.topText"
        memeEditorVC.bottomTextField?.text = self.meme.bottomText
    }
    
    func edit() {
        performSegueWithIdentifier("detailToEdit", sender: self)
    }
    
    
    
}
