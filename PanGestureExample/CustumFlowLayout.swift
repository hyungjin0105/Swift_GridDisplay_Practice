import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    var numberOfColumns: Int = 6

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }) else { return nil }

        var leftMargin = sectionInset.left
        var currentRow = -1

        attributes.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.indexPath.item / numberOfColumns > currentRow {
                    // New row
                    currentRow = layoutAttribute.indexPath.item / numberOfColumns
                    leftMargin = sectionInset.left
                }

                if layoutAttribute.indexPath.item % numberOfColumns == 0 {
                    // First item in the row
                    leftMargin = sectionInset.left
                } else {
                    // Alternate spacing logic
                    let columnIndex = layoutAttribute.indexPath.item % numberOfColumns
                    leftMargin += columnIndex % 2 == 0 ? 10 : 1
                }

                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width
            }
        }

        return attributes
    }
}
