//
//  QuizTableViewDelegateDataSource.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import Foundation
import UIKit

class QuizTableViewDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView?
    var answers: [String] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KeywordCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: answers[indexPath.row])
        return cell
    }
    
    func registerCells() {
        tableView?.register(cellType: KeywordCell.self)
    }
}
