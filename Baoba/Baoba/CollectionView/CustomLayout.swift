//
//  CustomLayout.swift
//  CollectionView01
//
//  Created by Paulo Ricardo on 08/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    
    var layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()     // 1
    var columnsYoffset: [CGFloat]!                                       // 2
    var contentSize: CGSize!                                             // 3
    
    var totalItemsInSection = 0
    
    // 4
    var totalColumns = 0
    var interItemsSpacing: CGFloat = 28
    
    // 5
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
    
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        
        for (_, layoutAttributes) in layoutMap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        
        return layoutAttributesArray
    }
    
    
    override func prepare() {
        // 1
        layoutMap.removeAll()
        columnsYoffset = Array(repeating: 0, count: totalColumns)
        
        totalItemsInSection = collectionView!.numberOfItems(inSection: 0)
        
        // 2
        if totalItemsInSection > 0 && totalColumns > 0 {
            // 3
            self.calculateItemsSize()
            
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0
            
            // 4
            while itemIndex < totalItemsInSection {
                // 5
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                // 6
                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: columnsYoffset[columnIndex])
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect
                
                // 7
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                columnsYoffset[columnIndex] = attributeRect.maxY + interItemsSpacing
                layoutMap[indexPath] = targetLayoutAttributes
                
                itemIndex += 1
            }
            
            // 8
            contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right,
                                  height: contentSizeHeight)
        }
    }
    
    
    // 1
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        return indexPath.item % totalColumns
    }
    // 2
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        return CGRect.zero
    }
    // 3
    func calculateItemsSize() {}
}
