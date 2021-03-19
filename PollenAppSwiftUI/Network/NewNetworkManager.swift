////
////  NetworkManager.swift
////  PollenAppSwiftUI
////
////  Created by Sabri Sönmez on 3/11/21.
////
////
//
////import Alamofire
//import Foundation
//import Combine
//
//class NewNetworkManager: ObservableObject {
//    @Published var excelData = ExcelDataList(results: [])
//    @Published var entryList = [Title]()
//    @Published var datesArray = [String]()
//
//    //    @Published var entryList = [String:EntryValue]()
//    //    @Published var nameLC = [String:EntryValue]()
//    //    @Published var datesLC = [String:EntryValue]()
//    //    @Published var pollenCountLC = [String:EntryValue]()
//    //    @Published var predominantPollenLC = [String:EntryValue]()
//    //    var nameEntry = [EntryValue]()
//    @Published var loading = false
//    private let range = "A20:B23"
//    private let api_url_base = "https://spreadsheets.google.com/feeds/list/1JgdxwstIJVet8rVMbegqCS72kFtFLt8jr8v_y-3gVos/1/public/full?alt=json"
//    init() {
//        loading = true
//        //        loadDataNormal()
//        loadDataNew()
//    }
//
//    private func loadDataNew() {
//        guard let url = URL(string: "\(api_url_base)") else { return }
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print("some error occured")
//            } else {
//
//                if let urlContent =  data {
//
//                    do{
//                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
//
//                        guard let newValue = jsonResult as? [String: Any] else {
//                            print("invalid format")
//                            return
//                        }
//
//                        let feedValues = newValue["feed"]! as! Dictionary<String,Any>
////                        print(String(describing: type(of: post_paramsValue)))
//                        let entryValues = feedValues["entry"] as! NSArray
//
//                        let nameLC = entryValues[0] as! Dictionary<String,Any>
////                        print(nameLC.keys)
//
//
//                        let nameTitleLC = nameLC["title"] as! Dictionary<String,Any>
////                        print(nameTitleLC["$t"]!)
//
//                        let dateLC = entryValues[1] as! Dictionary<String,Any>
//                        let valuesDateLC = dateLC["content"] as! Dictionary<String,Any>
//                        let castString = valuesDateLC["$t"] as! String
//                        let parsedValuesDate = castString.components(separatedBy: ", ")
//
//                        let pollenCountLC = entryValues[2] as! Dictionary<String,Any>
//                        let valuesPollenCountLC = pollenCountLC["content"] as! Dictionary<String,Any>
//                        let castString2 = valuesPollenCountLC["$t"] as! String
//                        let parsedValuesPollenCount = castString2.components(separatedBy: ", ")
//
//                        let pollenNameLC = entryValues[4] as! Dictionary<String,Any>
//                        let valuesPollenNameLC = pollenNameLC["content"] as! Dictionary<String,Any>
//                        let castString3 = valuesPollenNameLC["$t"] as! String
//                        let parsedValuesPollenName = castString3.components(separatedBy: ", ")
////                        print(parsedValuesDate)
//
//                        for i in 0 ..< 500 {
//                            print("\(parsedValuesDate[i].dropFirst(8)) || \(parsedValuesPollenCount[i].dropFirst(8))")
//
//                        }
//                        DispatchQueue.main.async {
//                            self.loading = false
//                            for i in parsedValuesDate {
//                                self.datesArray.append(i)
//                            }
//
//                       }
//                    }catch {
//                        print("JSON Preocessing failed")
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
//
//    //    private func loadDataNormal() {
//    //        guard let url = URL(string: "\(api_url_base)") else { return }
//    //        URLSession.shared.dataTask(with: url){ (data, _, _) in
//
//    ////            let excelData = try! JSONDecoder().decode(NewModel.self, from: data)
//    ////            let excelData = try! JSONSerialization.jsonObject(with: data, options: [])
//    //
//    //            DispatchQueue.main.async {
//    //
//    ////                self.dataAny = excelData["feed"] as! [String : Any]
//    //
//    ////                self.excelData.results.append(excelData)
//    ////                self.dataAny = excelData
//    //                self.loading = false
//    //                if let dictionary = excelData as? [String: Any] {
//    //                    if let number = dictionary["someKey"] as? Double {
//    //                        // access individual value in dictionary
//    //                    }
//    //
//    //                    for (key, value) in dictionary {
//    //                        // access all key / value pairs in dictionary
//    //
//    //                    }
//    //
//    //                    if let nestedDictionary = dictionary["feed"] as? [String: Any] {
//    //
//    ////                        var categoryString = nestedDictionary["entry"]!
//    ////                        print(categoryString)
//    //
//    //                    }
//    //
//    //
//    //
//    //                }
//    //
//    //
//    ////                for i in excelData.feed.entry {
//    ////                    self.entryList.append(i.gsCell)
//    ////                }
//    //
//    //
//    //
//    //            }
//    //        }.resume()
//    //    }
//    //
//
//
//    //    private func loadDataByAlamofire() {
//    //        Alamofire.request("\(api_url_base)\(api_key)")
//    //            .responseJSON{ response in
//    //                guard let data = response.data else { return }
//    //                let movies = try! JSONDecoder().decode(MovieList.self, from: data)
//    //                DispatchQueue.main.async {
//    //                    self.movies = movies
//    //                    self.loading = false
//    //                }
//    //        }
//    //    }
//}
