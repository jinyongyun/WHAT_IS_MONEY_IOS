//
//  SettingSection.swift
//  WHAT_IS_MONEY
//
//  Created by jinyong yun on 2023/01/04.
//

import UIKit

enum SettingSection {
  case profile([ProfileModel])
  case option([OptionModel])
  case title([TitleModel])
}

struct ProfileModel {
  let profileImage: UIImage?
  let titleText: String?
  let descriptionText: String?
}

struct OptionModel {
  let alertswitch: UISwitch?
  let title: String?
}

struct TitleModel {
  let title: String?
}
