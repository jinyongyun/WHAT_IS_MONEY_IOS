//
//  OnlyCellModel.swift
//  WHAT_IS_MONEY
//
//  Created by jinyong yun on 2023/01/04.
//

import UIKit

enum OnlyCellModel {
  case profile(profileImage: UIImage?, titleText: String, descriptionText: String)
  case option(alertswitch: UISwitch?, title: String)
  case title(title: String)
}
