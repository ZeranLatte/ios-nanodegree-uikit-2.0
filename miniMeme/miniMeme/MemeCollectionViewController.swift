//
//  MemeCollectionViewController.swift
//  miniMeme
//
//  Created by ZZZZeran on 9/23/15.
//  Copyright © 2015 Z Latte. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
}