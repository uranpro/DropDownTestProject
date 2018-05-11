//
//  DropDownButton.swift
//  DropDownTestProject
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit

class DropDownButton: UIView {
    var data: [String] = []
    var expanded = false
    var placeholder = "Choose something"
    var onSelect: ((String, Int, DropDownButton) -> ())?
    var selectedIndex = -1
    var rowHeight: CGFloat?
    
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(named: "arrow"))
    private let tableView = UITableView()
    
    private let padding: CGFloat = 16
    private let arrowSize: CGFloat = 20
    
    private var contentHeight: CGFloat {
        return (rowHeight ?? bounds.height) * CGFloat(data.count)
    }
    
    // MARK: Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let width = bounds.width
        let height = bounds.height
        
        titleView.frame = bounds
        
        titleLabel.frame = CGRect(x: padding, y: 0, width: width - arrowSize - padding, height: height)
        
        arrowImageView.frame = CGRect(x: width - arrowSize - padding, y: 0, width: arrowSize, height: height)
        
        tableView.rowHeight = rowHeight ?? bounds.height
        tableView.reloadData()
        tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + height, width: width, height: contentHeight)
    }
    
    // MARK: User interactions
    
    @objc func titleTap() {
        toggle()
    }
    
    // MARK: Helpers
    
    private func setup() {
        [titleView, titleLabel, arrowImageView].forEach { (view) in
            addSubview(view)
        }
        
        titleLabel.text = placeholder
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleTap))
        titleView.addGestureRecognizer(tapGesture)
        
        arrowImageView.contentMode = .scaleAspectFit
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsMake(0, padding, 0, padding)
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func toggle() {
        expanded = !expanded
        
        let show = expanded
        let svHeight = superview?.frame.size.height ?? 0
        let tableViewMaxY = tableView.frame.origin.y + contentHeight
        let height = tableViewMaxY > svHeight ? svHeight - tableView.frame.origin.y - padding : contentHeight
        
        if show {
            tableView.frame.size.height = 0
            superview?.addSubview(tableView)
        }
        
        tableView.alpha = show ? 0 : 1
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = show ? 1 : 0
            self.tableView.frame.size.height = show ? height : 0
            
            self.arrowImageView.transform = show ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
        }) { (finish) in
            if finish && !show {
                self.tableView.removeFromSuperview()
            }
        }
    }
    
    private func selectItem(atIndex index: Int) {
        selectedIndex = index
        
        let item = data[index]
        
        titleLabel.text = item
        onSelect?(data[index], index, self)
        toggle()
    }
}

extension DropDownButton: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectItem(atIndex: indexPath.row)
    }
}

