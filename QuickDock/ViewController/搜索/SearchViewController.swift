//
//  SearchViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class SearchTableViewController: BaseTableViewController {
    
    // 搜索控制器的恢复状态
    private struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }

    var images = [Image]()

    // 搜索控制器以进行筛选
    private var searchController: UISearchController!

    // 辅助搜索结果表视图
    private var resultsTableController: ResultsTableController!

    // UISearchController 的恢复状态
    private var restoredState = SearchControllerRestorableState()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsTableController = ResultsTableController()
        resultsTableController.tableView.delegate = self

        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none

        // 对于iOS 11及更高版本，搜索栏将放在导航栏中。
        navigationItem.searchController = searchController

        // 使搜索栏始终可见
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // 默认值为 true
        searchController.searchBar.delegate = self

        definesPresentationContext = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 恢复 searchController 的活动状态
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false

            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedImage: Image
        
        // 检查选择了哪个表格视图单元格。
        if tableView === self.tableView {
            selectedImage = images[indexPath.row]
        } else {
            selectedImage = resultsTableController.filteredImages[indexPath.row]
        }
        
        // 设置要显示的详细视图控制器
        let detailViewController = DetailViewController.detailViewControllerForImage(selectedImage)
        
        // 如果视图控制器未嵌入导航控制器中，则 navigationController 属性值为 nil
        navigationController?.pushViewController(detailViewController, animated: true)
        
        // 取消表格选中效果
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.tableViewCellIdentifier, for: indexPath)
        
        let image = images[indexPath.row]
        configureCell(cell, forImage: image)
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchControllerDelegate
// 使用这些委托函数可以对搜索控制器进行其他控制
extension SearchTableViewController: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate 调用了函数: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate 调用了函数: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate 调用了函数: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate 调用了函数: \(#function).")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate 调用了函数: \(#function).")
    }
}

// MARK: - UISearchResultsUpdating
extension SearchTableViewController: UISearchResultsUpdating {
    
    // NSPredicate expression keys
    private enum ExpressionKeys: String {
        case title
        case remark
        //case date
    }
    
    private func findMatches(searchString: String) -> NSCompoundPredicate {
        /** 每个searchString都为：name，remark，introPrice创建一个OR谓词。
         例如，如果searchItems包含“Gladiolus 51.99 2001”：
         name CONTAINS[c] "gladiolus"
         name CONTAINS[c] "gladiolus", yearIntroduced ==[c] 2001, introPrice ==[c] 51.99
         name CONTAINS[c] "ginger", yearIntroduced ==[c] 2007, introPrice ==[c] 49.98
         */
        var searchItemsPredicate = [NSPredicate]()
        
        /** Below we use NSExpression represent expressions in our predicates.
         NSPredicate is made up of smaller, atomic parts:
         two NSExpressions (a left-hand value and a right-hand value).
         */
        
        // 名称字段匹配
        let titleExpression = NSExpression(forKeyPath: ExpressionKeys.title.rawValue)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        
        // 通过使用给定的修饰符和选项组合给定的左表达式和右表达式，将谓词初始化为给定类型
        let titleSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: titleExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])// 不区分大小写, 模糊音
        
        searchItemsPredicate.append(titleSearchComparisonPredicate)
        
        // MARK: - TODO 备注字段匹配

        // MARK: - TODO 提醒日期字段匹配
        
        let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        
        return orMatchPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // 根据搜索文本更新已筛选的列表
        let searchResults = images
        
        // 去除所有前导和尾随空格
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // 为searchString中的每个值构建所有“AND”表达式
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        
        // 匹配 Image 对象的字段
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // 将筛选结果应用于搜索结果表
        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredImages = filteredResults
            resultsController.tableView.reloadData()
        }
    }
}

// MARK: - UIStateRestoration
extension SearchTableViewController {
    
    // 需要恢复的值
    private enum RestorationKeys: String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        // 对视图状态进行编码以便以后恢复
        
        // 编码页面的标题
        coder.encode(navigationItem.title!, forKey: RestorationKeys.viewControllerTitle.rawValue)
        
        // 编码搜索控制器的活动状态
        coder.encode(searchController.isActive, forKey: RestorationKeys.searchControllerIsActive.rawValue)
        
        // 编码 first responser 的状态
        coder.encode(searchController.searchBar.isFirstResponder, forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // 编码搜索栏文本
        coder.encode(searchController.searchBar.text, forKey: RestorationKeys.searchBarText.rawValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        // 恢复页面的标题
        guard let decodedTitle = coder.decodeObject(forKey: RestorationKeys.viewControllerTitle.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
        }
        navigationItem.title! = decodedTitle
        
        /** Restore the active state:
         We can't make the searchController active here since it's not part of the view
         hierarchy yet, instead we do it in viewWillAppear.
         */
        restoredState.wasActive = coder.decodeBool(forKey: RestorationKeys.searchControllerIsActive.rawValue)
        
        /** Restore the first responder status:
         Like above, we can't make the searchController first responder here since it's not part of the view
         hierarchy yet, instead we do it in viewWillAppear.
         */
        restoredState.wasFirstResponder = coder.decodeBool(forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // 恢复搜索字段中的文本
        searchController.searchBar.text = coder.decodeObject(forKey: RestorationKeys.searchBarText.rawValue) as? String
    }
}

