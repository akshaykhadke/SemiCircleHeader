//
//  StickyHeaderViewController.swift
//  StickyHeader
//
//  Created by Akshay Khadke on 05/11/19.
//  Copyright © 2019 Akshay Khadke. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
class StickyHeaderViewController: GSKStretchyHeaderView {

    @IBOutlet weak var semiCircile: UIView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
           super.init(frame: frame)
        semiCircile.addTopRoundedCornerToView(targetView: semiCircile, desiredCurve: 2)//addTopRoundedCornerToView(targetView: semiCircile, desiredCurve: 0.6)
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.semiCircile.addTopRoundedCornerToView(targetView: self.semiCircile, desiredCurve: 2)
        }
       }
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        super.didChangeStretchFactor(stretchFactor)
        
        let fontSize = CGFloatTranslateRange(min(1, stretchFactor), 0, 1, 0.1  , 2)
        let TopConstraint = CGFloatTranslateRange(min(1, stretchFactor), 0, 1, 0, 100)
        self.topConstraint.constant = 100 - TopConstraint
        print("TopConstraint = \(TopConstraint)")
        print("stretchFactor = \(fontSize)")
        self.semiCircile.addTopRoundedCornerToView(targetView: self.semiCircile, desiredCurve: fontSize)
        
    }
        

}
