//
//  NoResultsAdapter.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

class NoResultsAdapter: BaseAdapter {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoResultsCell.identifier, for: indexPath) as? NoResultsCell ?? NoResultsCell()
        return cell
    }
}
