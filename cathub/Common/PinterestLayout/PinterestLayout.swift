//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by  moma on 2017/11/21.
//  Copyright © 2017年 Razeware LLC. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

/// Pinterest 瀑布布局
class PinterestLayout: UICollectionViewLayout {
    /// 代理
    weak var delegate: PinterestLayoutDelegate?
    /// 布局列数
    fileprivate var numberOfColumns = 1
    /// cell padding
    fileprivate var cellPadding: CGFloat = 1 / UIScreen.main.scale
    /// 缓存
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    /// 内容高度 ？
    fileprivate var contentHeight: CGFloat = 0
    /// 内容宽度
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // MARK: - Init
    init(numberOfColumns: Int = 1) {
        self.numberOfColumns = numberOfColumns
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // 核心代码
    override func prepare() {
        super.prepare()
        
        guard cache.isEmpty,
            let collectionView = collectionView,
            collectionView.numberOfSections > 0 else {
            return
        }
        
        // 每一列的宽度
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        // 水平 x 偏移量 - eg [0, 300]
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        // 每一列 y 的偏移量，初始化为 0 - eg [0, 0]
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        // 遍历每个 item - 只看 section 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            // 通过代理方法得到 photo 的 size
            let size = delegate?.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath) ?? CGSize(width: 100, height: 100)
            // 按比例 缩放
            let cellContentHeight = size.height * columnWidth / size.width
            // 考虑 padding
            let height = cellPadding + cellContentHeight
            // 得到 frame
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            // ?
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            // 设置 attr
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            // 加入缓存
            cache.append(attributes)
            // 设置内容高度 - 同一行 取最大值
            contentHeight = max(contentHeight, frame.maxY)
            // 增加这一列的高度
            yOffset[column] += height
            // 横向列指针变化
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in cache where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        contentHeight = 0
        cache.removeAll()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
