//
//  UserInfoVCViewController.swift
//  GitHub
//
//  Created by joao camargo on 06/09/21.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    
    var itemViews: [UIView] = []
    var username: String!
    
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        print(username!)
        getUserInfo()
    }
    
    func layoutUI() {
        
         let padding: CGFloat  = 20
         let itemHeight: CGFloat = 140
        
        itemViews = [headerView,itemViewOne, itemViewTwo,dateLabel]
        
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor,constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor,constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch(result){
            case .success(let user):
                print(user)
                DispatchQueue.main.async {   self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "ok")
                break
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let repoFollowerVC = GFFollowerItemVC(user: user)
        repoFollowerVC.delegate = self
        
            self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            self.add(childVC: repoItemVC, to: self.itemViewOne)
            self.add(childVC: repoFollowerVC, to: self.itemViewTwo)
            self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid url", message: "Url user is invalid?", buttonTitle: "OK")
            return
        }
        
        presentSafariVC(with: url)

    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This User has no followers", buttonTitle: "ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }

}
