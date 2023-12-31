//
//  ViewController.swift
//  SwiftCodeGenerator
//
//  Created by Tifo Audi Alif Putra on 16/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = .title
        captionLabel.font = .caption
        bodyLabel.font = .body
        
        titleLabel.textColor = .redDark
        captionLabel.textColor = .blueRegular
        bodyLabel.textColor = .greenLight
    }


}

