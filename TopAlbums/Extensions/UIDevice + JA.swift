//
//  UIDevice + JA.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/24/22.
//

import Foundation
import UIKit

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}
