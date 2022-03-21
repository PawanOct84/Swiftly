//
//  AttributeCell.swift
//  SidemenuSampleApp
//
//  Created by Narender Kumar on 21/03/22.
//

import UIKit

protocol AttributeCellDelegate: AnyObject {
    func didTappedAt(cell: AttributeCell)
}

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var propertyLbl: UILabel!
    @IBOutlet weak var dataTypeLbl: UILabel!
    @IBOutlet weak var optionBtn: UIButton!
    weak var delegate: AttributeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionBtn.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ propertyComponent: PropertyComponent) {
        propertyLbl.text = propertyComponent.name
        dataTypeLbl.text = propertyComponent.type
        
        let iamgeName = propertyComponent.variablesOptional ? "push_btn_unsel" : "push_btn_sel"
        let buttonImage = UIImage(named: iamgeName)
        optionBtn.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func optionAction(_ sender: UIButton) {
        delegate?.didTappedAt(cell: self)
    }
    

}
