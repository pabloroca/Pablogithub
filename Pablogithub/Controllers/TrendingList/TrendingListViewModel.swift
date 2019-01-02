//
//  TrendingListViewModel.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

final class TrendingListViewModel {

    let title = "GitHub trends today"
    
    var rows: [Trending] = []
    var nofilteredRows: [Trending] = []

    func readTrending(completion: @escaping (Bool) -> Void) {
        ServiceFactory.TrendingService().getTrending { [weak self] (result)  in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.rows = value
                self.nofilteredRows = value
                completion(true)
            case .failure:
                // fail gracefully - no UI
                completion(false)
            }
        }
    }

    func filterRows(with searchText: String) {

        if !searchText.isEmpty {
            rows = nofilteredRows.filter { (trending) -> Bool in
                return trending.name.lowercased().contains(searchText) ? true : false
            }
        } else {
            rows = nofilteredRows
        }
    }
    
}
