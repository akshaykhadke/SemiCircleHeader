//
//  ViewController.swift
//  StickyHeader
//
//  Created by Akshay Khadke on 05/11/19.
//  Copyright © 2019 Akshay Khadke. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GSKStretchyHeaderViewStretchDelegate {
    func stretchyHeaderView(_ headerView: GSKStretchyHeaderView, didChangeStretchFactor stretchFactor: CGFloat) {
        
    }
    
    @IBOutlet weak var semiCircle: UIView!
    
    var stretchyHeader: GSKStretchyHeaderView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        return cell
        
    }
    
    @IBOutlet weak var stickyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        let headerSize = CGSize(width: self.stickyTableView.frame.size.width,
                                   height: 200) // 200 will be the default height
           self.stretchyHeader = GSKStretchyHeaderView(frame: CGRect(x: 0, y: 0,
                                                                             width: headerSize.width,
                                                                             height: headerSize.height))
        self.stretchyHeader.backgroundColor = .blue
       */
        //semiCircle.addTopRoundedCornerToView(targetView: semiCircle, desiredCurve: 2)
        //semiCircle.setTopCurve()
        let nibViews = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        self.stretchyHeader = nibViews?[0] as! GSKStretchyHeaderView
        self.stretchyHeader.stretchDelegate = self // this is completely optional
           self.stickyTableView.addSubview(self.stretchyHeader)
        
        if #available(iOS 11.0, *) {
            self.stickyTableView.contentInsetAdjustmentBehavior = .never
        }
        
        ///
        // you can change wether it expands at the top or as soon as you scroll down
        stretchyHeader.expansionMode = .immediate

        // You can change the minimum and maximum content heights
        stretchyHeader.minimumContentHeight = 64 // you can replace the navigation bar with a stretchy header view
        stretchyHeader.maximumContentHeight = 242

        // You can specify if the content expands when the table view bounces, and if it shrinks if contentView.height < maximumContentHeight. This is specially convenient if you use auto layout inside the stretchy header view
        stretchyHeader.contentShrinks = false//true
        stretchyHeader.contentExpands = true//false // useful if you want to display the refreshControl below the header view

        // You can specify wether the content view sticks to the top or the bottom of the header view if one of the previous properties is set to `false`
        // In this case, when the user bounces the scrollView, the content will keep its height and will stick to the bottom of the header view
        stretchyHeader.contentAnchor = .bottom
        
    }


}

extension UIView {

func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?)
{
    let offset:CGFloat =  targetView!.frame.width/desiredCurve!
    let bounds: CGRect = targetView!.bounds

    //Top side curve
    //let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
    
    //Bottom side curve
    let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)

    let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
    
    //Top side curve
    //let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
    
    //Bottom side curve
    let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
    
    let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
    rectPath.append(ovalPath)

    // Create the shape layer and set its path
    let maskLayer: CAShapeLayer = CAShapeLayer()
    maskLayer.frame = bounds
    maskLayer.path = rectPath.cgPath

    // Set the newly created shape layer as the mask for the view's layer
    targetView!.layer.mask = maskLayer
}
    
    func setTopCurve(){
           let offset = CGFloat(self.frame.size.height/4)
           let bounds = self.bounds
           //let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height/2  , width:  bounds.size.width, height: bounds.size.height / 2)
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y  , width:  bounds.size.width, height: bounds.size.height / 2)
           let rectPath = UIBezierPath(rect: rectBounds)
           let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
         //let ovalBounds = CGRect(x: bounds.origin.x , y: bounds.origin.y - offset / 2, width: bounds.size.width + offset, height: bounds.size.height)
           let ovalPath = UIBezierPath(ovalIn: ovalBounds)
       rectPath.append(ovalPath)

           let maskLayer = CAShapeLayer.init()
           maskLayer.frame = bounds
           maskLayer.path = rectPath.cgPath
           self.layer.mask = maskLayer
       }
}
