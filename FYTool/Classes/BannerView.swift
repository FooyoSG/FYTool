//
//  BannerView.swift
//  Charger Core
//
//  Created by chinghoi on 2020/7/30.
//  Copyright © 2020 Chinghoi. All rights reserved.
//

import UIKit

struct Banner {
    var title: String?
    var imageNetwork: ImageNetwork?
    var image: UIImage?
    
    struct ImageNetwork {
        var url: String?
        var placeholder: UIImage?
    }
}

struct BannerItemStyle {
    var titleAlignment: NSTextAlignment = .center
    var titleColor: UIColor = .black
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    var imageViewContentMode: UIView.ContentMode = .scaleAspectFill
    var backgroundColor: UIColor = .lightGray
}

protocol BannerViewDelegate: class {
    func bannerView(_ bannerView: BannerView, didSelectItemAt index: Int)
}


/// BannerView, support set to UIView array, or default Banner class array.
class BannerView: UIView {
    
    public weak var delegate: BannerViewDelegate?
    public var didSelectItem: ((_ bannerView: BannerView, _ index: Int) -> Void)?
    
    // MARK: - Public
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    /// Automatic rotation interval, default is 3 seconds.
    /// The number of seconds between firings of the timer.
    /// If interval is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
    public var timeInterval: TimeInterval = 3
    
    /// Is Automatic rotation, default is true
    public var isAutoRotation: Bool = true
    
    public var itemStyle = BannerItemStyle() { didSet { collectionView.reloadData() } }
    
    private var currentIndex: Int = 1
    private var timer: Timer?
    private var data: [Any] = []
    private var layout = BannerFlowLayout()
    
    
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.register(BannerCollectionViewCell.self)
        v.bounces = false
        v.isPagingEnabled = false
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard layout.itemSize != frame.size else { return }
        layout.itemSize = frame.inset(by: edgeInsets).size
        layout.minimumLineSpacing = edgeInsets.left + edgeInsets.right
        
        collectionView.contentInset = edgeInsets
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.decelerationRate = .fast
    }
    
    public func setData(data: [Banner]) {
        setData(any: data)
    }
    
    public func setData(data: [UIView]) {
        setData(any: data)
    }
    
    private func setData(any: [Any]) {
        guard data.count >= 1 else { return }
        self.data = [data.last!] + data + [data.first!]
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)

        guard isAutoRotation else {
            timer?.invalidate()
            timer = nil
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] (timer) in
            guard let weakSelf = self else { return }
            let width = weakSelf.collectionView.frame.width
            let edgeInsets = weakSelf.edgeInsets
            if weakSelf.currentIndex == weakSelf.data.count - 1 {
                weakSelf.collectionView.contentOffset = CGPoint(x: width - edgeInsets.left, y: -edgeInsets.top)
            }
            let currentOffset = weakSelf.collectionView.contentOffset
            let nesxtOffset = CGPoint(x: currentOffset.x + width, y: -edgeInsets.top)
            weakSelf.collectionView.setContentOffset(nesxtOffset, animated: true)
        })
    }
}

extension BannerView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BannerCollectionViewCell! = collectionView.dequeueReusableCell(indexPath: indexPath)
        if let banner = data[indexPath.item] as? Banner {
            cell.setCell(data: banner)
        }
        if let customView = data[indexPath.item] as? UIView {
            cell.setCell(data: customView)
        }
        cell.setCellStyle(itemStyle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard isAutoRotation else {
            timer?.invalidate()
            timer = nil
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] (timer) in
            guard let weakSelf = self else { return }
            let width = weakSelf.collectionView.frame.width
            let edgeInsets = weakSelf.edgeInsets
            if weakSelf.currentIndex == weakSelf.data.count - 1 {
                weakSelf.collectionView.contentOffset = CGPoint(x: width - edgeInsets.left, y: -edgeInsets.top)
            }
            let currentOffset = weakSelf.collectionView.contentOffset
            let nesxtOffset = CGPoint(x: currentOffset.x + width, y: -edgeInsets.top)
            weakSelf.collectionView.setContentOffset(nesxtOffset, animated: true)
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if currentIndex == data.count - 1 {
            scrollView.contentOffset = CGPoint(x: scrollView.frame.width - edgeInsets.left, y: -edgeInsets.top)
        }
        if currentIndex == 0 {
            scrollView.contentOffset = CGPoint(x: (scrollView.frame.width * CGFloat(data.count - 2)) - edgeInsets.left, y: -edgeInsets.top)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerView(self, didSelectItemAt: indexPath.item)
        if let b = didSelectItem {
            b(self, indexPath.item)
        }
    }
}

class BannerCollectionViewCell: UICollectionViewCell {
    
    private var cacheCustomView: UIView?
    
    public final let imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    public final let title: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        title.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(data: Banner) {
        if let imageNetwork = data.imageNetwork, let url = imageNetwork.url {
            imageView.setImage(url: url, placeholder: imageNetwork.placeholder)
        } else {
            imageView.image = data.image
        }
        
        title.text = data.title
        title.isHidden = data.title == nil
    }
    
    func setCell(data: UIView) {
        guard data != cacheCustomView else { return }
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.addSubview(data)
        data.frame = contentView.bounds
    }
    
    func setCellStyle(_ preference: BannerItemStyle) {
        
        contentView.backgroundColor = preference.backgroundColor
        
        imageView.contentMode = preference.imageViewContentMode
        
        title.textColor = preference.titleColor
        title.textAlignment = preference.titleAlignment
        title.font = preference.titleFont
    }
}

class BannerFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        /// 建议的点（在集合视图的内容视图中），在该点停止滚动。这是如果不进行任何调整自然会停止滚动的值。该点反映了可见内容的左上角。
        
        guard let collectionView = collectionView else {
            return .zero
        }
        let index = (proposedContentOffset.x + collectionView.contentInset.left) / collectionView.frame.width
        var offsetX: CGFloat = 0
        
        if index.truncatingRemainder(dividingBy: 1) >= 0.5 { // 余数大于 0.5 滚到下一页
            let next = index + 1
            offsetX = collectionView.frame.width * CGFloat(Int(next))
        } else { // 余数小于0.5，则滚回当前页的初始位置
            offsetX = collectionView.frame.width * CGFloat(Int(index))
            
        }
        return CGPoint(x: offsetX - collectionView.contentInset.left, y: proposedContentOffset.y)
    }
    
}
