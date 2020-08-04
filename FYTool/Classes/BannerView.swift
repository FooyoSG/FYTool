//
//  BannerView.swift
//  Charger Core
//
//  Created by chinghoi on 2020/7/30.
//  Copyright © 2020 Chinghoi. All rights reserved.
//

import UIKit

public struct Banner {
    public var title: String?
    public var imageNetwork: ImageNetwork?
    public var image: UIImage?
    
    public struct ImageNetwork {
        public var url: String?
        public var placeholder: UIImage?
        
        public init(url: String? = nil, placeholder: UIImage?) {
            self.url = url
            self.placeholder = placeholder
        }
    }
    
    public init(title: String? = nil, imageNetwork: ImageNetwork? = nil, image: UIImage? = nil) {
        self.title = title
        self.imageNetwork = imageNetwork
        self.image = image
    }
}

public struct BannerItemStyle {
    public var titleAlignment: NSTextAlignment = .center
    public var titleColor: UIColor = .black
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    public var imageViewContentMode: UIView.ContentMode = .scaleAspectFill
    public var backgroundColor: UIColor = .lightGray
}

public protocol BannerViewDelegate: class {
    func bannerView(_ bannerView: BannerView, didSelectItemAt index: Int)
}


/// BannerView, support set to UIView array, or default Banner class array.
public class BannerView: UIView {
    
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
    private var pagerC = UIPageControl()
    
    
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.register(BannerCollectionViewCell.self)
        v.bounces = false
        v.isPagingEnabled = false
        v.decelerationRate = .fast
        v.dataSource = self
        v.delegate = self
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
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
    }
    
    public func setData(data: [Banner]) {
        setData(any: data)
    }
    
    public func setData(data: [UIView]) {
        setData(any: data)
    }
    
    private func setData(any: [Any]) {
        guard any.count >= 1 else { return }
        self.data = [any.last!] + any + [any.first!]
        collectionView.reloadData()
        DispatchQueue.main.async {
            self.collectionView.contentOffset = CGPoint(x: self.collectionView.frame.width - self.edgeInsets.left, y: -self.edgeInsets.top)
        }

        guard isAutoRotation else {
            timer?.invalidate()
            timer = nil
            return
        }
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(autoScrollAction), userInfo: nil, repeats: true)
    }
    
    @objc
    private func autoScrollAction() {
        if currentIndex == data.count - 1 {
            scrollToFirstDataOnMain()
        }
        let currentOffset = collectionView.contentOffset
        let nesxtOffset = CGPoint(x: currentOffset.x + collectionView.frame.width, y: -edgeInsets.top)
        collectionView.setContentOffset(nesxtOffset, animated: true)
    }
    private func scrollToFirstDataOnMain() {
        DispatchQueue.main.async {
            let offset = CGPoint(x: self.collectionView.frame.width - self.edgeInsets.left, y: -self.edgeInsets.top)
            self.collectionView.contentOffset = offset
        }
    }
    private func scrollToLastDataOnMain() {
        DispatchQueue.main.async {
            let offset = CGPoint(x: (self.collectionView.frame.width * CGFloat(self.data.count - 2)) - self.edgeInsets.left, y: -self.edgeInsets.top)
            self.collectionView.contentOffset = offset
        }
    }
}

extension BannerView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
        if currentIndex == data.count - 1 {
            scrollToFirstDataOnMain()
        }
    }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard isAutoRotation else {
            timer?.invalidate()
            timer = nil
            return
        }
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(autoScrollAction), userInfo: nil, repeats: true)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if currentIndex == data.count - 1 {
            scrollToFirstDataOnMain()
        }
        if currentIndex == 0 {
            scrollToLastDataOnMain()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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