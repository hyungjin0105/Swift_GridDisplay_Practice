//
//  CustumFlowLayout.swift
//  PanGestureExample
//
//  Created by hyungjin kim on 12/28/23.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    var numberOfColumns: Int = 6
    let spacingForPairs: CGFloat = 10 // Larger spacing between pairs
    let spacingWithinPair: CGFloat = 1 // Spacing within a pair

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }

        var leftMargin = sectionInset.left
        var currentRow = 0

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.indexPath.item / numberOfColumns > currentRow {
                // New row
                currentRow = layoutAttribute.indexPath.item / numberOfColumns
                leftMargin = sectionInset.left
            }

            if layoutAttribute.indexPath.item % numberOfColumns == 0 {
                // First item in the row
                leftMargin = sectionInset.left
            } else if layoutAttribute.indexPath.item % 2 == 0 {
                // Even column index (start of a new pair)
                leftMargin += spacingForPairs
            } else {
                // Odd column index (second in a pair)
                leftMargin += spacingWithinPair
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width
        }

        return attributes
    }
}
