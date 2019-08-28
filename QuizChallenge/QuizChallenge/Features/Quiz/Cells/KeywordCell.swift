//
//  KeywordCell.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import UIKit

class KeywordCell: UITableViewCell, Reusable {
    
    func setup(with answer: String?) {
        textLabel?.text = answer
    }
    
}
