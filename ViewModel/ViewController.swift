//
//  ViewController.swift
//  ViewModel
//
//  Created by Garric G. Nahapetian on 4/19/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let viewModel: ViewModeling
    
    init(viewModel: ViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refreshControl?.beginRefreshing()
        
        viewModel.refresh(completion: completion)
    }
    
    @objc private func didPullToRefresh() {
        viewModel.refresh(completion: completion)
    }
    
    private func completion() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = viewModel.itemForRow(at: indexPath)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        let cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "myCell") ?? UITableViewCell()
        cell.contentView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: imageView.superview!.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageView.superview!.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageView.superview!.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageView.superview!.trailingAnchor).isActive = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }
}
