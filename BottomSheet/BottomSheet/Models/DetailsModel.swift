//
//  DetailsModel.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import Foundation

struct DetailsModel: Hashable {
    var title: String?
    var sections: [String]?
    static var models: [DetailsModel] = {
        return [DetailsModel(title: "item1", sections: ["section11","section12","section13",
                                                       "section14","section15","section16","section17",
                                                       "section18","section19","section20","section21",
                                                       "section22","section23","section24","section25",
                                                       "section26","section27","section28","section29",
                                                        "section14","section15","section16","section17",
                                                        "section18","section19","section20","section21",
                                                        "section22","section23","section24","section25",
                                                        "section26","section27","section28","section29",
                                                        "section14","section15","section16","section17",
                                                        "section18","section19","section20","section21",
                                                        "section22","section23","section24","section25",
                                                        "section26","section27","section28","section29",
                                                        "section14","section15","section16","section17",
                                                        "section18","section19","section20","section21",
                                                        "section22","section23","section24","section25",
                                                        "section26","section27","section28","section29",
                                                        "section30","section31","section32","section33"]),
                DetailsModel(title: "item2", sections: ["section21","section22","section23","section24",
                                                       "section25","section26","section27","section28"]),
                DetailsModel(title: "item3", sections: ["section11","section12","section13"])]
    }()
}
