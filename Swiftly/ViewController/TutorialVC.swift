//
//  TutorialVC.swift
//  SidemenuSampleApp
//
//  Created by Apple on 20/03/22.
//

import UIKit
import AdvancedPageControl

class TutorialVC: UIViewController {
    
    //MARk: IBOutlets
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var pgControl: AdvancedPageControlView!
    @IBOutlet weak var btnSuivant: UIButton!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    //MARK: Properties
    let arrTitle = ["ABC","ABC","ABC"]
    let arrSubTitle = ["XYZ","XYZ","XYZ"]
    let arrImg = [#imageLiteral(resourceName: "logo_transparent"),#imageLiteral(resourceName: "logo_transparent"),#imageLiteral(resourceName: "logo_transparent")]

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        self.collView.delegate = self
        self.collView.dataSource = self
        
        self.pgControl.drawer = JumpDrawer(numberOfPages: 3, height: 10, width: 10, space: 5, raduis: 5, currentItem: 0, indicatorColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dotsColor: #colorLiteral(red: 0.1411764706, green: 0.18431372549, blue: 0.29019607843, alpha: 1), isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        
    }
}

//MARK: Button Actions
extension TutorialVC {
    @IBAction func btnCancelTapAction(_ sender: UIButton) {
        self.jumpToVC()
    }
    
    @IBAction func btnSuivantTapAction(_ sender: UIButton) {
        let visibleItems: NSArray = self.collView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        
        if nextItem.row < arrTitle.count {
            self.collView.scrollToItem(at: nextItem, at: .left, animated: true)
            pgControl.setPage(nextItem.row)
            if nextItem.row == 2{
                self.btnSuivant.setTitle("END", for: .normal)
            }
        } else {
            self.jumpToVC()
        }
    }
    
    func jumpToVC() {
    }
}

//MARK: UICollectionViewDelegate
extension TutorialVC: UICollectionViewDelegate {
    
}

//MARK: UICollectionViewDataSource
extension TutorialVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollViewCell", for: indexPath) as! TutorialCollViewCell
        cell.lblTitle.text = arrTitle[indexPath.row]
        cell.lblSubTitle.text = arrSubTitle[indexPath.row]
        UIView.transition(with: cell.img, duration: 2, options: .curveEaseInOut) {
            cell.img.image = self.arrImg[indexPath.row]
        } completion: { (finished) in
            
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pg = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pgControl.setPage(pg)
        if pg == 2 {
            self.btnSuivant.setTitle("END", for: .normal)
        } else {
            self.btnSuivant.setTitle("NEXT", for: .normal)
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension TutorialVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collView.frame.size.width, height: collView.frame.size.height)
    }
}

//MARK: UICollectionViewCell
class TutorialCollViewCell:UICollectionViewCell{
    //MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
}
