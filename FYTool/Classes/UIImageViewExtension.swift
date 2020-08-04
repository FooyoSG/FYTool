//
//  UIImageViewExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/4.
//

import UIKit
import AlamofireImage
import Alamofire

extension UIImageView  {
    
    func setImage(url: URLConvertible?, placeholder: UIImage?, size: CGSize? = nil) {
        
        guard let url = try? url?.asURL() else {
            image = placeholder
            return
        }
        
        var filter: ImageFilter?
        if let s = size {
            filter = AspectScaledToFillSizeFilter(size: s)
        }
        
        self.af.setImage(withURL: url, placeholderImage: placeholder, filter: filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true) { (_) in
            
        }
    }
}
