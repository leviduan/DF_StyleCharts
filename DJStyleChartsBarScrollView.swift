//
//  DJStyleChartsBarScrollView.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/16.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

protocol DJStyleChartsBarScrollViewDelegate : NSObjectProtocol {
    func scrollMenuView(scrollMenuView: DJStyleChartsBarScrollView, clickedButtonAtIndex index: NSInteger)
}

class DJStyleChartsBarScrollView: UIScrollView {
    weak var barDelegate : DJStyleChartsBarScrollViewDelegate?
    // current button position
    var currentButtonIndex: NSInteger = 0
    // current button title's array
    var titleArray = [String]()
    // the margin is between first button and view's the left-most layout and between last button and view's the right-most layout
    var margin: CGFloat = 23.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        var i = 0
        var lastX : CGFloat = margin
        for titleString in titleArray {
            let menuButton: UIButton = UIButton.init(type: .custom)
            self.addSubview(menuButton)
            menuButton.titleLabel?.font = DJFont.helveticaFont(ofSize: 14)
            menuButton.setTitle(titleString, for: .normal)
            menuButton.setTitle(titleString, for: .selected)
            menuButton.setBackgroundColor(.clear, forState: .normal)
            menuButton.setBackgroundColor(UIColor(fromHexString: "EAEAEA"), forState: .highlighted)
            menuButton.setBackgroundColor(UIColor(fromHexString: "EAEAEA"), forState: .selected)
            menuButton.addTarget(self, action: #selector(menuButtonClick(sender:)), for: .touchUpInside)
            menuButton.isHighlighted = false
            menuButton.isUserInteractionEnabled = true
            menuButton.setTitleColor(UIColor(fromHexString: "818181"), for: .normal)
            menuButton.setTitleColor(UIColor(fromHexString: "262729"), for: .selected)
            menuButton.tag = 1000 + i
            menuButton.sizeToFit()
            menuButton.layoutIfNeeded()
            let width = CGFloat(menuButton.bounds.width + 32.0)
            menuButton.frame = CGRect(x: CGFloat(lastX), y: 0.0, width: width, height: 32.0)
            lastX = width + lastX
            if (i == 0) {
                menuButton.isSelected = true
                menuButton.layer.cornerRadius = 16.0
                menuButton.layer.masksToBounds = true
                menuButton.titleLabel?.font = DJFont.boldHelveticaFont(ofSize: 14)
            }
            i+=1
        }
        currentButtonIndex = 0
        self.contentSize = CGSize(width: lastX+margin, height: 32.0)
    }
    
    @objc func menuButtonClick(sender: UIButton) {
        for button in self.subviews {
            if button.isMember(of: UIButton.self) {
                if let button: UIButton = button as? UIButton {
                    button.isSelected = false
                    button.layer.cornerRadius = 16.0
                    button.layer.masksToBounds = true
                    button.titleLabel?.font = DJFont.helveticaFont(ofSize: 14)
                }
            }
        }
        sender.isSelected = true
        sender.layer.cornerRadius = 16.0
        sender.titleLabel?.font = DJFont.boldHelveticaFont(ofSize: 14)
        currentButtonIndex = sender.tag-1000
        self.barDelegate?.scrollMenuView(scrollMenuView: self, clickedButtonAtIndex: currentButtonIndex)
        
        let senderCenterX: CGFloat = sender.frame.origin.x + sender.bounds.width/2.0
        if sender.frame.origin.x + margin > self.bounds.width/2.0 && senderCenterX <= self.contentSize.width - self.bounds.width/2.0 - margin {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = CGPoint(x: senderCenterX - self.bounds.width/2.0, y: 0)
            }
        }
        else if (sender.frame.origin.x + margin < self.bounds.width/2.0) {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = CGPoint(x: self.contentSize.width - self.bounds.width, y: 0)
            }
        }
    }
    
    func setCurrentButtonIndex(currentIndex: NSInteger) {
        for button in self.subviews {
            if button.isMember(of: UIButton.self) {
                if let button: UIButton = button as? UIButton {
                    button.isSelected = false
                    button.layer.cornerRadius = 16.0
                    button.layer.masksToBounds = true
                    button.titleLabel?.font = DJFont.helveticaFont(ofSize: 14)
                }
            }
        }
        currentButtonIndex = currentIndex
        self.barDelegate?.scrollMenuView(scrollMenuView: self, clickedButtonAtIndex: currentButtonIndex)
        if let currentButton = self.viewWithTag(1000 + currentIndex) {
            if let selectedButton: UIButton = currentButton as? UIButton {
                selectedButton.isSelected = true
                selectedButton.layer.cornerRadius = 16.0
                selectedButton.layer.masksToBounds = true
                selectedButton.titleLabel?.font = DJFont.boldHelveticaFont(ofSize: 14)
                
                let selectedButtonCenterX: CGFloat = selectedButton.frame.origin.x + selectedButton.bounds.width/2.0
                if selectedButton.frame.origin.x + margin > self.bounds.width/2.0 && selectedButtonCenterX <= self.contentSize.width - self.bounds.width/2.0 - margin {
                    UIView.animate(withDuration: 0.3) {
                        self.contentOffset = CGPoint(x: selectedButtonCenterX - self.bounds.width/2.0, y: 0)
                    }
                }
                else if (selectedButton.frame.origin.x + margin < self.bounds.width/2.0) {
                    UIView.animate(withDuration: 0.3) {
                        self.contentOffset = CGPoint(x: 0, y: 0)
                    }
                }
                else {
                    UIView.animate(withDuration: 0.3) {
                        self.contentOffset = CGPoint(x: self.contentSize.width - self.bounds.width, y: 0)
                    }
                }
            }
        }
    }
}



