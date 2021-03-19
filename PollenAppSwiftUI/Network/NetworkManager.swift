//
//  NetworkManager.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 3/11/21.
//
//

//import Alamofire
import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var excelData = ExcelDataList(results: [])
    @Published var sheetsData = DataArrayModel(titleLincoln: "LINCOLN CENTER (Department of NATURAL SCIENCES)  NYC, NY", pollenDatesLincoln: [], pollenNamesLincoln: [], pollenCountLincoln: [])
    @Published var datesArray = [String]()
    @Published var loading = false
    
    private let range = "A20:B23"
    private let api_url_base = "https://spreadsheets.google.com/feeds/list/1JgdxwstIJVet8rVMbegqCS72kFtFLt8jr8v_y-3gVos/1/public/full?alt=json"
    init() {
        loading = true
//        loadData()
     
    }
    
    public func loadData(onCompletion: @escaping (Bool) -> Void, onError: @escaping (NSError) -> Void) {
        guard let url = URL(string: "\(api_url_base)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("some error occured")
            } else {
                
                if let urLincolnontent =  data {
                    
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urLincolnontent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        guard let newValue = jsonResult as? [String: Any] else {
                            print("invalid format")
                            return
                        }
                        
                        let feedValues = newValue["feed"]! as! Dictionary<String,Any>
                        //                        print(String(describing: type(of: post_paramsValue)))
                        let entryValues = feedValues["entry"] as! NSArray
                        
                        let dateLincoln = entryValues[1] as! Dictionary<String,Any>
                        let valuesDateLincoln = dateLincoln["content"] as! Dictionary<String,Any>
                        let castString = valuesDateLincoln["$t"] as! String
                        let parsedValuesDate = castString.components(separatedBy: ", ")
                        
                        let pollenCountLincoln = entryValues[2] as! Dictionary<String,Any>
                        let valuesPollenCountLincoln = pollenCountLincoln["content"] as! Dictionary<String,Any>
                        let castString2 = valuesPollenCountLincoln["$t"] as! String
                        let parsedValuesPollenCount = castString2.components(separatedBy: ", ")
                        
                        let pollenNameLincoln = entryValues[4] as! Dictionary<String,Any>
                        let valuesPollenNameLincoln = pollenNameLincoln["content"] as! Dictionary<String,Any>
                        let castString3 = valuesPollenNameLincoln["$t"] as! String
                        let parsedValuesPollenName = castString3.components(separatedBy: ", _")
                         
                                                
                        DispatchQueue.main.async {
                            self.loading = false
                           

                            for i in 0 ..< parsedValuesPollenCount.count - 1 {
                                if let index = (parsedValuesDate[i].range(of: ":")?.upperBound)
                                {
                                  //prints "value"
                                    self.sheetsData.pollenDatesLincoln.append(String(parsedValuesDate[i].suffix(from: index)).trimmingCharacters(in: .whitespacesAndNewlines))

                                    self.sheetsData.pollenNamesLincoln.append(String(parsedValuesPollenName[i].suffix(from: index).trimmingCharacters(in: .whitespacesAndNewlines)))
                                    self.sheetsData.pollenCountLincoln.append(String(parsedValuesPollenCount[i].suffix(from: index).trimmingCharacters(in: .whitespacesAndNewlines)))
                                }
//                                self.sheetsData.pollenDatesLincoln.append(String(parsedValuesDate[i]))
                                
                                
                                
//                                print("\(parsedValuesDate[i].dropFirst(8)) || \(parsedValuesPollenCount[i].dropFirst(8)) || \(parsedValuesPollenName[i].dropFirst(8))")

                            }
                          
                            
//                            print(self.sheetsData.pollenDatesLincoln)
                        
                            print("data appended")
                            onCompletion(true)
                        }
                        
                        
                    }catch {
                        print("JSON Preocessing failed")
                    }
                }
            }
        }
        task.resume()
    }
   
}
