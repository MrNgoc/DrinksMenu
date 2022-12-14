//
//  DrinkTableViewCell.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import UIKit
import Kingfisher

final class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        imgView.layer.cornerRadius = 8
        imgView.clipsToBounds = true
    
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        containerView.layer.shadowRadius = 6
        containerView.layer.masksToBounds = false
    }
    
    func configData(_ model: Drink) {
        instructionLabel.text = model.instructions
        nameLabel.text = model.name
        
        guard let url = URL(string: model.image) else { return }
        imgView.kf.setImage(
            with: url,
            placeholder: nil)
        {
            result in
            switch result {
            case .success(let value):
                self.imgView.image = value.image
                break
            case .failure(_):
                break
            }
        }
    }

}
