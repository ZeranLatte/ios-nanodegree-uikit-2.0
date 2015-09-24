//
//  Meme.swift
//  miniMeme
//
//  Created by ZZZZeran on 9/23/15.
//  Copyright © 2015 Z Latte. All rights reserved.
//

import UIKit
import Foundation

class Meme {
    
    // meme properties
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = originalImage
    }
}
