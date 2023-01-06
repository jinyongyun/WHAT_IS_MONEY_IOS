//
//  TitleCell.swift
//  WHAT_IS_MONEY
//
//  Created by jinyong yun on 2023/01/04.
//

import UIKit
import Then
import SnapKit

final class TitleCell: UITableViewCell {
  static let id = "TitleCell"
  
  private let titleLabel = UILabel().then {
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 14)
  }
  
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
    self.prepare(titleText: nil)
  }
  
  private func setupLayout() {
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.left.equalToSuperview().inset(10)
      $0.right.lessThanOrEqualToSuperview().inset(20)
      $0.centerY.equalToSuperview()
    }
  }
  func prepare(titleText: String?) {
    self.titleLabel.text = titleText
  }
}
