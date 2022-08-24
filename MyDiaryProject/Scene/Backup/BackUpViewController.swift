//
//  BackUpViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit

class BackUpViewController: BaseViewController {
    
    let backupView = BackUpViewVC()
    
    override func loadView() {
        self.view = backupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        backupView.tableView.delegate = self
        backupView.tableView.dataSource = self
        backupView.tableView.register(BackUpTableViewCell.self, forCellReuseIdentifier: BackUpTableViewCell.identifier)
    }
    
    override func setAction() {
        backupView.backUpButton.addTarget(self, action: #selector(backupButtonTapped(_:)), for: .touchUpInside)
        
        backupView.restorebutton.addTarget(self, action: #selector(restoreButtonTapped(_:)), for: .touchUpInside)
        
    }
    
}

extension BackUpViewController {
    
    @objc func backupButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func restoreButtonTapped(_ sender: UIButton) {
        
    }
    
}


extension BackUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackUpTableViewCell.identifier) as? BackUpTableViewCell else { return UITableViewCell()}
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backupView.restorebutton.isEnabled = true
    }
    
}
