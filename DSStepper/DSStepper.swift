//
//  DSStepper.swift
//  DSStepper
//
//  Created by Daniel Session on 03/01/2015.
//  Copyright (c) 2015 Daniel Sessions. All rights reserved.
//

import UIKit

@IBDesignable class DSStepper: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    @IBInspectable var maximumValue: NSInteger = 100
    @IBInspectable var minimumValue: NSInteger = 0
    
    @IBInspectable var value: NSInteger = 0 {
        didSet {
            updateLabel()
        }
    }
    
    @IBInspectable var textColor: UIColor! = UIColor.blackColor() {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            updateLayer()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateLayer()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            updateColors()
        }
    }
    
    @IBOutlet weak private var incrementButton: UIButton!
    @IBOutlet weak private var decrementButton: UIButton!
    @IBOutlet weak private var valueLabel: UILabel!
    
    var view: UIView!
    
    func configureView() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "DSStepper", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
    
    @IBAction func tapIncrementButton(sender: UIButton) {
        if self.value != self.maximumValue {
            self.value += 1;
            updateLabel()
        }
    }
    
    @IBAction func tapDecrementButton(sender: UIButton) {
        if self.value != self.minimumValue {
            self.value -= 1;
            updateLabel()
        }
    }

    private func updateLabel() {
        self.valueLabel.text = String(self.value)
        updateButtons()
    }

    private func updateButtons() {
        self.incrementButton.enabled = self.value < self.maximumValue
        self.decrementButton.enabled = self.value > self.minimumValue
    }
    
    private func updateLayer() {
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = 1
        layer.cornerRadius = cornerRadius
    }
    
    private func updateColors() {
        self.incrementButton.tintColor = self.tintColor
        self.decrementButton.tintColor = self.tintColor
        self.valueLabel.textColor = self.textColor
    }
    
}
