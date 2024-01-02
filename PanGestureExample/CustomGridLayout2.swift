//import UIKit
//
//class CustomGridLayout2: UICollectionViewFlowLayout {
//    var columns: Int
//    var useAlternatingLayoutForEven: Bool = true
//
//    init(columns: Int) {
//        self.columns = columns
//        super.init()
//        self.setupLayout()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
//
//        if columns % 2 == 0 && useAlternatingLayoutForEven {
//            var xOffset: CGFloat = 0
//            var previousRow: Int = 0
//
//            // Define spacing constants
//            let smallSpace: CGFloat = 1  // smaller space between cells
//            let largeSpace: CGFloat = 15 // larger space between cells
//
//            attributes?.forEach { layoutAttribute in
//                let indexPath = layoutAttribute.indexPath
//                let columnIndex = indexPath.item % columns
//                let rowIndex = indexPath.item / columns
//
//                if rowIndex != previousRow {
//                    xOffset = 0 // Reset xOffset for each new row
//                    previousRow = rowIndex
//                }
//
//                layoutAttribute.frame.origin.x = xOffset
//
//                // Alternating space logic
//                if columnIndex % 2 == 0 {
//                    xOffset += itemSize.width + smallSpace
//                } else {
//                    xOffset += itemSize.width + largeSpace
//                }
//            }
//        } else {
//            // Odd number of columns
//              let baseSpacing = 5
//              let spacingIncrement = 10
//              let columnDifference = max(0, 8 - columns)
//            self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//              self.minimumLineSpacing = 2
//        }
//
//        return attributes
//    }
//
//        
//
//
//    
//    private func setupLayout() {
//        
//        if columns % 2 == 0 {
//            // Even columns: standard item size, alternating spacing
//            let baseSpacing = 5
//            let spacingIncrement = 10
//            let columnDifference = max(0, 8 - columns)
//              self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//            self.minimumLineSpacing = 2
//        } else {
//            // Odd number of columns
//          let baseSpacing = 5
//          let spacingIncrement = 10
//          let columnDifference = max(0, 8 - columns)
//            self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//          self.minimumLineSpacing = 2
//      }    }
//
//
//
//    func updateColumnCount(newColumnCount: Int) {
//        self.columns = newColumnCount
//        self.setupLayout()
//    }
//}





//import UIKit
//
//class CustomGridLayout: UICollectionViewFlowLayout {
//    var columns: Int
//    var useAlternatingLayoutForEven: Bool = true
//
//    init(columns: Int) {
//        self.columns = columns
//        super.init()
//        self.setupLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
//
//        if columns % 2 == 0 && useAlternatingLayoutForEven {
//            var xOffset: CGFloat = 0
//            var previousRow: Int = 0
//
//            // Define spacing constants
//            let smallSpace: CGFloat = 1  // smaller space between cells
//            let largeSpace: CGFloat = 15 // larger space between cells
//
//            attributes?.forEach { layoutAttribute in
//                let indexPath = layoutAttribute.indexPath
//                let columnIndex = indexPath.item % columns
//                let rowIndex = indexPath.item / columns
//
//                if rowIndex != previousRow {
//                    xOffset = 0 // Reset xOffset for each new row
//                    previousRow = rowIndex
//                }
//
//                layoutAttribute.frame.origin.x = xOffset
//
//                // Alternating space logic
//                if columnIndex % 2 == 0 {
//                    xOffset += itemSize.width + smallSpace
//                } else {
//                    xOffset += itemSize.width + largeSpace
//                }
//            }
//        } else {
//            // Odd number of columns
//              let baseSpacing = 5
//              let spacingIncrement = 10
//              let columnDifference = max(0, 8 - columns)
//            self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//              self.minimumLineSpacing = 2
//        }
//
//        return attributes
//    }
//
//
//
//
//
//    private func setupLayout() {
//
//        if columns % 2 == 0 {
//            // Even columns: standard item size, alternating spacing
//            let baseSpacing = 5
//            let spacingIncrement = 10
//            let columnDifference = max(0, 8 - columns)
//              self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//            self.minimumLineSpacing = 2
//        } else {
//            // Odd number of columns
//          let baseSpacing = 5
//          let spacingIncrement = 10
//          let columnDifference = max(0, 8 - columns)
//            self.minimumInteritemSpacing = CGFloat(baseSpacing + spacingIncrement * columnDifference)
//          self.minimumLineSpacing = 2
//      }    }
//
//
//
//    func updateColumnCount(newColumnCount: Int) {
//        self.columns = newColumnCount
//        self.setupLayout()
//    }
//}