//
//  OptionCell.swift
//  WHAT_IS_MONEY
//
//  Created by jinyong yun on 2023/01/04.
//

import UIKit
import Then
import SnapKit

final class OptionCell: UITableViewCell {
  static let id = "OptionCell"
  
  private let titleLabel = UILabel().then {
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 16)
  }
    private var AlertSwitch = UISwitch()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.setupLayout()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  override func prepareForReuse() {
    super.prepareForReuse()
      self.prepare(alertswitch: nil, titleText: nil)
  }
  
  private func setupLayout() {
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.AlertSwitch)
    self.titleLabel.snp.makeConstraints {
      //$0.left.lessThanOrEqualToSuperview().offset(10)
      $0.right.lessThanOrEqualToSuperview().inset(285)
      $0.centerY.equalToSuperview()
    }
      self.AlertSwitch.snp.makeConstraints {
          $0.right.equalToSuperview().inset(10)
          $0.centerY.equalToSuperview()
      }
  }
    func prepare(alertswitch: UISwitch?, titleText: String?) {
    self.AlertSwitch = UISwitch()
    self.titleLabel.text = titleText
  }
}
