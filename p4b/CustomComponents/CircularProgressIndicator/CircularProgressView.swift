//
//  CircularProgressView.swift
//  Fitness
//
//  Created by Sagar Ranshur on 07/05/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import Foundation
import UIKit

class CircularProgressView: UIView {
    
    // First create two layer properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var startAngle: CGFloat = 0.0
    private var endAngle: CGFloat = 0.0
        
    @IBInspectable var circleColor: CGColor = UIColor.black.cgColor {
        didSet {
            circleLayer.strokeColor = circleColor
        }
    }
    
    @IBInspectable var circleTintColor: CGColor = UIColor.systemGreen.cgColor {
        didSet {
            progressLayer.strokeColor = circleTintColor
        }
    }
    
    var radius: CGFloat = 80.0
    var percentage = 80


    override init(frame: CGRect) {
        super.init(frame: frame)
        startAngle = -.pi / 2
        endAngle = startAngle + (.pi * 2)
        
        createCircularPath(radius: radius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        startAngle = -.pi / 2
        endAngle = startAngle + (.pi * 2)
        
        createCircularPath(radius: radius)
    }
    
    func createCircularPath(radius: CGFloat) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        
//        let circularPath1 = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: startAngle, endAngle: (endAngle - startAngle) * CGFloat((percentage / 100)) + startAngle, clockwise: true)

        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 8
        circleLayer.strokeColor = circleColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 8
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = circleTintColor
                
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
}
