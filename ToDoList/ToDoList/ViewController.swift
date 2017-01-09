//
//  ViewController.swift
//  ToDoList
//
//  Created by Seab on 1/8/17.
//  Copyright © 2017 Seab Jackson. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "To-Do-List"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        // register the cell class
        collectionView?.register(ToDoCell.self, forCellWithReuseIdentifier: "cellID")
        // register the collectionView header
        collectionView?.register(ToDoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
    }
    
    var tasks = ["Buy Groceries", "Pay Phone Bill", "Learn to Code"]

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sampleToDoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ToDoCell
        sampleToDoCell.nameLabel.text = tasks[indexPath.item]
        return sampleToDoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! ToDoHeader
        header.viewController = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func addNewTask(taskName: String) {
        tasks.append(taskName)
        collectionView?.reloadData()
    }

}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews() {
   
    }

}

class ToDoCell: BaseCell {
   
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func setUpViews() {
        addSubview(nameLabel)
        
        // add horizontal constraints to label
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        // add vertical constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}

class ToDoHeader: BaseCell {
    
    var viewController: ViewController?
    
    let toDoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setUpViews() {
        addSubview(toDoTextField)
        addSubview(addTaskButton)
        
        addTaskButton.addTarget(self, action: #selector(ToDoHeader.addTask), for: .touchUpInside)
        // add horizontal constraints to label
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil,
                                                      views: [
                                                        "v0": toDoTextField,
                                                        "v1": addTaskButton
            ]))
        // add vertical constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[v0]-24-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": toDoTextField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: [
            "v0": addTaskButton
            ]))
    }
    
    func addTask() {
        viewController?.addNewTask(taskName: toDoTextField.text!)
        toDoTextField.text = ""
    }
}

































