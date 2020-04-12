//
//  DashboardCell.swift
//  WiproCodingTest
//
//  Created by AjeetZone on 11/04/20.
//  Copyright © 2020 AjeetZone. All rights reserved.
//

import UIKit
import SDWebImage


class DashboardCell: UITableViewCell {
    static let cellIdentifier = "DashboardCell"

    @IBOutlet weak var imgvw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgvw.contentMode = .scaleAspectFit
        imgvw.isUserInteractionEnabled = true
        imgvw.setRoundCornder(0.6, .darkGray)
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblDesc.textColor = .darkGray

        lblTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with item:Row) {
        lblTitle.text = item.title ?? "N/A"
        lblDesc.text = item.description ?? "N/A"
                
        if let strImgURL = item.imageHref {
            imgvw.setImageFromURL(strImgURL: strImgURL, isShowIndicator: true, placeholderimg: UIImage(named: placeholderImg)) { (isTrue) in }
        }
        
        self.imgvw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        tappedImage.setupImageViewer()
    }


}
