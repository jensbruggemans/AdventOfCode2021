//
//  ThermalVentCollectionViewCell.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 05/12/2021.
//

import UIKit

class ThermalVentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var centerView: UIView!
    
    var color: UIColor {
        get {
            return centerView.backgroundColor ?? .white
        }
        set {
            centerView.backgroundColor = newValue
        }
    }
    
    var shouldBlink = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        centerView.layer.cornerRadius = 5
        blink()
    }
    
    func blink() {
        UIView.animate(withDuration: 1, delay: CGFloat.random(in: 0...1), options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            if self.centerView.alpha == 1 {
                self.centerView.alpha = self.shouldBlink ? 0.6 : 1
            } else {
                self.centerView.alpha = 1
            }
        }) { [weak self] _ in
            self?.blink()
        }
        
    }
}
