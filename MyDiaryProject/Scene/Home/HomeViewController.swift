//
//  HomeViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/22.
//

import UIKit
import Alamofire
import RealmSwift
import FSCalendar

class HomeViewController: BaseViewController {
    
    // MARK: Properties
    let repository: UserDiaryRepositoryType = UserDiaryRepository()
    
    lazy var calender: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.backgroundColor = .gray
        return view
    }()
    
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadData()
            print("Tasks Changed!", tasks.description)
        }
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(calender)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        
        calender.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        
        setBarrbutton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면 갱신은 화면 전환 코드 및 생명주기 실행 점검 필요!!
        // present, overCurrentContext, overFullScreen > viewWillAppear X
        
        // Realm 데이터를 정렬해서 task에 담기
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
}

// MARK: SetNav
extension HomeViewController {
    
    func setBarrbutton() {
        print(#function)
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortData)),
            UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterData))
        ]
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(transitionView))
    }
    
    @objc func sortData() {
        tasks = repository.fetchSortData("registedDate", ascending: true)
    }
    
    // 쿼리문 사용
    // realm filter query, NSPredicate
    @objc func filterData() {
        
        tasks = repository.fetchFilterData() // [c] : 대소문자 상관없이 색인
//            .filter("diaryTitle = '오늘의 일기'") // 해당 스트링 값으로 색인하는 방법 (정확하게 맞는 값만 출력한다.)
    }
    
//    @objc func transitionView() {
//        presentVC(MainViewController(), transitionType: .presentNavigation)
//    }
        
}

// MARK: TableViewDelegate, TableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell() }
        
        let diaryData = tasks[indexPath.row]
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        cell.titleLabel.text = diaryData.diaryTitle
        cell.dateLabel.text = formatter.string(from: diaryData.diaryDate)
        cell.contentLabel.text = diaryData.diaryContent
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].uuID).jpg")
        
        return cell
    }
    
    // 참고. TableView Editing Mode
    
    // TableView 셀 높이가 작을 경우, 이미지가 없을 때, 시스템 이미지가 아닌 경우 (이미지 사이즈 조절 중요)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            let currentItem = self.tasks[indexPath.row]

            self.repository.updateFavorite(item: currentItem)
            self.fetchRealm()
        }
        
        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            
            print("example Button Clicked")
        }
        
        // realm 데이터 기준으로 다른 이미지 설정
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        return UISwipeActionsConfiguration(actions: [favorite, example])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 역순으로 추가
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
                        
            guard let self = self else { return }
            // TODO: 순서 정확하게 이해하기 (사진을 먼저 삭제해야하는 이유??)
            self.removeImageFromDocuement(fileName: "\(self.tasks[indexPath.row].uuID)")
            self.repository.deleteItem(item: self.tasks[indexPath.row]) {
                self.fetchRealm()
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
 
    }
    
    
}

