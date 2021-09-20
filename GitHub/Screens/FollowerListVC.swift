//
//  FollowerListVCViewController.swift
//  GitHub
//
//  Created by joao camargo on 29/08/21.
//

import UIKit

//classeavc



class FollowerListVC: GFDataLoadingVC {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var pageSize = 100
    var hasMoreFollowers = true
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateAlertButtons = self
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
        collectionView.delegate = self
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false //tira o esmaecido
        navigationItem.hidesSearchBarWhenScrolling = false //isso faz ele aparecer logo que carregado
        navigationItem.searchController = searchController
    }
    
    
    fileprivate func UpdateUI(with followers: ([Follower])) {
        if followers.count < self.pageSize {   self.hasMoreFollowers = false }
        print("call again")
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "No followers found!"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        
        self.updateData(on: followers)
    }
    
    func getFollowers(username: String, page :Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page, pageSize: pageSize) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.UpdateUI(with: followers)
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Error", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseId, for: indexPath) as! FollowersCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped(){
        
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getUserInfo(for: username){ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    func addUserToFavorites(user: (User)) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "favorite added", buttonTitle: "OK")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "ok")
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty
        else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        } // coloca no filtro qualqu er valor q esteja ou retorna pra nao continuar, tem que colocar o ! antes de filter
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        
        // get follower for that user
        self.username = username
        title = username
        page = 1
        isSearching = false
        hasMoreFollowers = true
        followers.removeAll()
        filteredFollowers.removeAll()
        //collectionView.setContentOffset(CGPoint(x: 0, y: -140), animated: true) // scroll to the top
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}

//classeavc
extension FollowerListVC: AlertButtonsUIViewControllerDelegate {
    
    func doFirst() {
        print("do first hahahahha")
        navigationController?.popViewController(animated: true)
    }
    
    func doSecond() {
        print("do second hghahahagah")
        self.dismiss(animated: true)
    }
    
    
}

