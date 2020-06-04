//
//  CostomButton.swift
//  Calculator
//
//  Created by Азизбек on 04.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
@IBDesignable
class CostomButton: UIButton {

    
    private var size = CGSize()
    
    @IBInspectable var cornerRadiusButton: CGFloat = 0 {
        didSet {
            size = CGSize(width: cornerRadiusButton, height: cornerRadiusButton)
        }
    }
    
    var corners: UIRectCorner = .allCorners
        
    private var degreeFloat = CGFloat()
    @IBInspectable var degree : CGFloat = 0.0 {
        didSet {
            degreeFloat = degree
        }
    }
        
    
    
    @IBInspectable var color: UIColor = .green

    var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
         path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [corners], cornerRadii: size)
        
        color.setFill()
        path?.fill() //заполнение фигуры зеленым цветом
        transform =  transform.rotated(by:degreeFloat)
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let path = path {
            return path.contains(point)
        }
        return false
    }
    

}
