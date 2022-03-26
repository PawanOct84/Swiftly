//
//  AttributeCell.swift
//  SidemenuSampleApp
//
//  Created by Narender Kumar on 21/03/22.
//

import UIKit

protocol AttributeCellDelegate: AnyObject {
    func didTappedForOptionAt(cell: AttributeCell)
    func didTappedForContainsAt(cell: AttributeCell)
}

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var propertyLbl: UILabel!
    @IBOutlet weak var dataTypeLbl: UILabel!
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    weak var delegate: AttributeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionBtn.setTitle("", for: .normal)
        switchBtn.setTitle("", for: .normal)
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
        
        let iamgeContainsImage = propertyComponent.shouldContains ? "switch_on" : "switch_off"
        let buttonContainsImage = UIImage(named: iamgeContainsImage)
        switchBtn.setImage(buttonContainsImage, for: .normal)
        
        bgView.backgroundColor = propertyComponent.shouldContains ? UIColor.black : UIColor.darkGray
    }
    
    @IBAction func optionAction(_ sender: UIButton) {
        delegate?.didTappedForOptionAt(cell: self)
    }
    
    @IBAction func switchAction(_ sender: UIButton) {
        delegate?.didTappedForContainsAt(cell: self)
    }
    

}
