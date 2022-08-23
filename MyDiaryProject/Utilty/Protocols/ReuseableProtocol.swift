//
//  ReuseableProtocol.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol { }

extension UICollectionViewCell: ReusableProtocol { }

extension UITableViewCell: ReusableProtocol { }

