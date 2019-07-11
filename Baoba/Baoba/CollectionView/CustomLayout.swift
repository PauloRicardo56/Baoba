//
//  CustomLayout.swift
//  CollectionView01
//
//  Created by Paulo Ricardo on 08/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

let kReducedHeightColumnIndex = 1
let kItemHeightAspect: CGFloat  = 2

class CustomLayout: UICollectionViewLayout {
    
    var layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()     // 1
    var columnsYoffset: [CGFloat]!                                       // 2
    var contentSize: CGSize!                                             // 3
    
    var totalItemsInSection = 0
    
    // 4
    var totalColumns = 3
    var interItemsSpacing: CGFloat = 20
    
    var itemSize: CGSize!
    var columnsXoffset: [CGFloat]!
    
    let indexOfFocus = 4
    
    // 5
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
//        return UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    
    override func prepare() {
        // 1
        layoutMap.removeAll()
        
//            Array(repeating: 0, count: totalColumns)    // [0.0, 0.0, 0.0]
        
        totalItemsInSection = collectionView!.numberOfItems(inSection: 0)    // 30
        
        // 2
        if totalItemsInSection > 0 && totalColumns > 0 {
            // 3
            self.calculateItemsSize()
            columnsYoffset = [itemSize.height/2, 0.0, itemSize.height/2]
            
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0
            
            // 4
            while itemIndex < totalItemsInSection {
                // 5
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                // 6
                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: columnsYoffset[columnIndex])    // Como nossas cells serão sempre do msm tam uma função é dispensada.
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect
                
                // 7
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                
                // Aqui eu faço com que a primeira e ultima coluna comecem um pouco mais abaixo.
//                let initialYSpace: CGFloat = columnIndex != 1 ? attributeRect.maxY / 2 : 0.0
                columnsYoffset[columnIndex] = attributeRect.maxY + interItemsSpacing
                
                layoutMap[indexPath] = targetLayoutAttributes
                
                itemIndex += 1
            }
            
            // 8
            contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right, height: contentSizeHeight)
        }
    }
    
    
    // Calculating the initial item’s size, depending on provided content size, and number of columns. Also, we fill a columnsXoffset array with x-position info, for each column.
    func calculateItemsSize() {
        
        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right    // 414.0 - (contentsInsets = .zero)
        let itemWidth = contentWidthWithoutIndents*0.8 / CGFloat(totalColumns)
//            (contentWidthWithoutIndents - (CGFloat(totalColumns) - 1) * interItemsSpacing) / CGFloat(totalColumns)    // 119.33
        let itemHeight = itemWidth * 1.2
//        kItemHeightAspect    // 238.66
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // Calculating offsets by X for each column
        columnsXoffset = [0, collectionView!.bounds.width/2 - itemWidth/2, collectionView!.bounds.width - itemWidth]    // [0.0, 147.33, 294.66] - X inicial da coluna
//        for columnIndex in 0...(totalColumns - 1) {
//            columnsXoffset.append(CGFloat(columnIndex) * (itemSize.width + interItemsSpacing))
//        }
//        columnsXoffset[0] += 30
    }
    
    
    // 1
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        let columnIndex = indexPath.item % totalColumns
//        return self.isLastItemSingleInRow(indexPath) ? kReducedHeightColumnIndex : columnIndex
        return columnIndex
    }
    
    
    // 2
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        // 1
//        let rowIndex = indexPath.item / totalColumns    // 1/2/3/4/5/6/7/8/9
        
//        let halfItemHeight = (itemSize.height - interItemsSpacing) / 2
        
        // 2
//        let itemHeight = itemSize.height
        
        // 3
//        if indexPath.item == indexOfFocus {
//            return CGRect(x: columnsXoffset[columnIndex], y: columnYoffset, width: itemSize.width*1.2, height: itemSize.height*1.2)
//        }
        
        return CGRect(x: columnsXoffset[columnIndex], y: columnYoffset, width: itemSize.width, height: itemSize.height)
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
    
    
    // 4
    private func isLastItemSingleInRow(_ indexPath: IndexPath) -> Bool {
        return indexPath.item == (totalItemsInSection - 1) && indexPath.item % totalColumns == 0
    }
    
    
    
}
