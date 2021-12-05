//
//  ThermalVentsView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 05/12/2021.
//

import UIKit
import SwiftUI

class ThermalVentsView: UIView {
    let collectionView: UICollectionView
    var thermalValues: [Point: Int] = [:] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let colors = [UIColor(hex: "001825"),
                  UIColor(hex: "3F7193"),
                  UIColor(hex: "7EB2DD"),
                  UIColor(hex: "B6C8CE"),
                  UIColor(hex: "FFBE3B"),
                  UIColor(hex: "D65B27"),
                  UIColor(hex: "B30909")]
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .init(origin: .zero, size: frame.size), collectionViewLayout: ThermalVentsLayout())
        collectionView.register(UINib(nibName: "ThermalVentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        super.init(frame: frame)
        collectionView.dataSource = self
        addSubview(collectionView)
        backgroundColor = .black
        collectionView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
}

extension ThermalVentsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ThermalVentCollectionViewCell
        let point = Point(x: indexPath.row, y: indexPath.section)
        let thermalValue = thermalValues[point] ?? 0
        cell.color = colors[thermalValue]
        cell.shouldBlink = true
        return cell
    }
}

class ThermalVentsLayout: UICollectionViewLayout {
    
    let itemSize: CGFloat = 30
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 1000 * itemSize, height: 1000 * itemSize)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let minRow = Int(max(rect.minX / itemSize, 0))
        let minSection = Int(max(rect.minY / itemSize, 0))
        let maxRow = Int(min(rect.maxX / itemSize, 999))
        let maxSection = Int(min(rect.maxY / itemSize, 999))
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for row in minRow...maxRow {
            for section in minSection...maxSection {
                if let attributes = layoutAttributesForItem(at: IndexPath(row: row, section: section)) {
                    layoutAttributes.append(attributes)
                }
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: CGFloat(indexPath.row) * itemSize, y: CGFloat(indexPath.section) * itemSize, width: itemSize, height: itemSize)
        return attributes
    }
}
