//
//  Extension_Style.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/15.
//

import UIKit

extension UIFont {

    static var largeRegular: UIFont {
        return UIFont.systemFont(ofSize: 25, weight: .regular)
    }

    static var mediumRegular: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }

    static var smallRegular: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    static var largeBold: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .semibold)
    }

    static var mediumBold: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }

    static var smallBold: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }

    static var caption: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}
