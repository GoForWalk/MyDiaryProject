//
//  BackUpViewVC.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit

final class BackUpViewVC: BaseViewVC {
    
    let backUpButton: SquareButton = {
        let button = SquareButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("Backup", for: .normal)
        return button
    }()
    
    let restorebutton: SquareButton = {
        let button = SquareButton()
        button.backgroundColor = .orange
        button.setTitleColor( UIColor.lightGray, for: .disabled)
        button.setTitle("Restore", for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [backUpButton, restorebutton])
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func configure() {
        [stackView, tableView].forEach {
            self.addSubview($0)
        }
        backgroundColor = .clear
    }
    
    override func layoutConstraint() {
        backUpButton.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
        
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self).inset(32)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        restorebutton.snp.makeConstraints { make in
            make.height.equalTo(backUpButton.snp.height)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backUpButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
