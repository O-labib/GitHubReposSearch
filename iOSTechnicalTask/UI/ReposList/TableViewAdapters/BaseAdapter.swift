//
//  BaseAdapter.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

class BaseAdapter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
}
