//
//  SnappingLayout.swift
//  CollectionViewSnapping
//
//  Created by Alessandro Perna on 05/06/18.
//  Copyright © 2018 VJTechnology Srl. All rights reserved.
//

import UIKit

struct UltraVisualLayoutConstants {
    struct Cell {
        // The height of the non-futured cell
        static let standardHeight: CGFloat = 100.0
        // The height of the first visible cell
        static let featuredHeight: CGFloat = 280.0

    }
}
class UltraVisualLayout: UICollectionViewLayout {

    // the amount the user needs to scroll before the featured cell changes
    let dragOffset: CGFloat = 180.0
    var cache = [UICollectionViewLayoutAttributes]()

    // return the item index of the currently featured cell
    var featuredItemIndex: Int {
        get{
            // Use max to make sure of the featuredItemIndex is never < 0
            return max(0, Int(collectionView!.contentOffset.y/dragOffset))
        }
    }
    
    // Return a value between 0 and 1 than rapresents how close the next cell is to becoming the featured cell
    var nextItemPercentageOffSet: CGFloat{
        get{
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    // Returns the width of the collection view
    var width: CGFloat {
        get{
            return collectionView!.bounds.width
        }
    }

    // Returns the height of the collection view
    var height: CGFloat {
        get{
            return collectionView!.bounds.height
        }
    }
    
    // Returns the number of item in the collection view
    var numberOfItems: Int {
        get{
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    //Return the size of all the content in the collection view
    override var collectionViewContentSize: CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache{
            if rect.intersects(attributes.frame){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }


}

