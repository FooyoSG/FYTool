//
//  CLLocationCoordinate2DExtension.swift
//  Alamofire
//
//  Created by chinghoi on 2020/8/31.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {}

/**
 Return whether two `CLLocationCoordinate2D` structs are equivalent.
 - parameter lhs: The lefthand side of the `==` operator.
 - parameter rhs: The righthand side of the `==` operator.
 - returns: `true` if the `lhs` and `rhs` values are equal, false otherwise.
 */
public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
