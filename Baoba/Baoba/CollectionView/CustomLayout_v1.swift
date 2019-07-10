//
//  CustomLayout_v1.swift
//  CollectionView01
//
//  Created by Paulo Ricardo on 10/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation
import UIKit


private let kReducedHeightColumnIndex = 1
private let kItemHeightAspect: CGFloat  = 2


class CustomLayout_v1: CustomLayout {
    
    // 2
    private var itemSize: CGSize!
    private var columnsXoffset: [CGFloat]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // 3
        self.totalColumns = 3
    }
    
    // 4
    private func isLastItemSingleInRow(_ indexPath: IndexPath) -> Bool {
        return indexPath.item == (totalItemsInSection - 1) && indexPath.item % totalColumns == 0
    }
    
    
    override func calculateItemsSize() {
        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right
        let itemWidth = (contentWidthWithoutIndents - (CGFloat(totalColumns) - 1) * interItemsSpacing) / CGFloat(totalColumns)
        let itemHeight = itemWidth * kItemHeightAspect
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // Calculating offsets by X for each column
        columnsXoffset = []
        
        for columnIndex in 0...(totalColumns - 1) {
            columnsXoffset.append(CGFloat(columnIndex) * (itemSize.width + interItemsSpacing))
        }
    }
    
    
    override func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        let columnIndex = indexPath.item % totalColumns
        return self.isLastItemSingleInRow(indexPath) ? kReducedHeightColumnIndex : columnIndex
    }
    
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        // 1
        let rowIndex = indexPath.item / totalColumns
        let halfItemHeight = (itemSize.height - interItemsSpacing) / 2
        
        // 2
        var itemHeight = itemSize.height
        
        // 3
        if (rowIndex == 0 && columnIndex == kReducedHeightColumnIndex) || self.isLastItemSingleInRow(indexPath) {
            itemHeight = halfItemHeight
        }
        
        return CGRect(x: columnsXoffset[columnIndex], y: columnYoffset, width: itemSize.width, height: itemHeight)
    }
}
