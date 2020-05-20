//
//  WebServices.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class WebServices {
    
static let instance = WebServices()

// MARK: - REGISTER USER

    func register(zoneID :String,gender :String,name: String, email: String,  password: String, completion: @escaping (_ status: Bool , _ error: String) -> ())
    {
        var gen :Int?
        if gender == "Female".localized{
            gen = 2
        }
        else if gender == "Male".localized{
            gen = 1
        }
        let parameters = ["fullname":name,"email":email,"password":password,"zoneID":zoneID,"gender":gen ?? 0] as [String : Any]
    print(parameters)
    Alamofire.request(APIKeys().REGISTER_URL, method: .post ,parameters: parameters,  encoding: URLEncoding.default).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            
            print("-->USER",json)
            if json["message"].stringValue == "sorry is email exsist" {
                completion(false, "")
            }else if json["message"].stringValue == "sorry is mobile exsist" {
                completion(false, "")
            }else{
                completion(true, "")
            }
        case .failure(let error):
            print(error)
            completion(false, "")
        }
    }
}
    //GET ALL PLACES
    func Allplacesmap()
    {
        MAPPLACE = []
        Alamofire.request(APIKeys().ALL_PLACES_MAP, method: .get ,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->ALL-PLACES",json)
                for place in json {
                    let single = mapplace()
                    single._id = place["_id"].stringValue
                    single.lang = place["lang"].doubleValue
                    single.lat = place["lat"].doubleValue
                    single.logo = place["logo"].stringValue
                    MAPPLACE.append(single)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // UPDATE USER
    func update(email:String,mobile:String,name:String,proImage:String, completion: @escaping(_ status: Bool, _ error: String) ->()){
        let parameters = ["fullname":name,"email":email,"mobile":mobile,"personalImg":proImage]
        print(parameters)
        let UserID = UserDefaults.standard.value(forKey: "id")
        let url = APIKeys().UPDATE_URL
        Alamofire.request("\(url)\(UserID!)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                if json["message"].stringValue == "sorry is email exsist" {
                    completion(false, "")
                }else if json["message"].stringValue == "sorry is mobile exsist" {
                    completion(false, "")
                }else{
                    completion(true, "")
                    let status = json["status"].stringValue
                    let fullname = json["fullname"].stringValue
                    let email = json["email"].stringValue
                    let id = json["_id"].stringValue
                    let mobile = json["mobile"].stringValue
                    let password = json["password"].stringValue
                    UserDefaults.standard.set(status, forKey: "status")
                    UserDefaults.standard.set(fullname, forKey: "fullname")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(mobile, forKey: "mobile")
                    UserDefaults.standard.set(password, forKey: "password")
                }
            case .failure(let error):
                print(error)
                completion(false, "")
            }
        }
        }
    func update(name:String,proImage:String, completion: @escaping(_ status: Bool, _ error: String) ->()){
        let parameters = ["fullname":name,"personalImg":proImage]
        print(parameters)
        let UserID = UserDefaults.standard.value(forKey: "id")
        let url = APIKeys().UPDATE_URL
        Alamofire.request("\(url)\(UserID!)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                if json["message"].stringValue == "sorry is email exsist" {
                    completion(false, "")
                }else if json["message"].stringValue == "sorry is mobile exsist" {
                    completion(false, "")
                }else{
                    completion(true, "")
                    let status = json["status"].stringValue
                    let fullname = json["fullname"].stringValue
                    let email = json["email"].stringValue
                    let id = json["_id"].stringValue
                    let mobile = json["mobile"].stringValue
                    let password = json["password"].stringValue
                    UserDefaults.standard.set(status, forKey: "status")
                    UserDefaults.standard.set(fullname, forKey: "fullname")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(mobile, forKey: "mobile")
                    UserDefaults.standard.set(password, forKey: "password")                }
            case .failure(let error):
                print(error)
                completion(false, "")
            }
        }
    }
    func update(name:String,mobile:String,proImage:String, completion: @escaping(_ status: Bool, _ error: String) ->()){
        let parameters = ["fullname":name,"mobile":mobile,"personalImg":proImage]
        print(parameters)
        let UserID = UserDefaults.standard.value(forKey: "id")
        let url = APIKeys().UPDATE_URL
        Alamofire.request("\(url)\(UserID!)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                if json["message"].stringValue == "sorry is email exsist" {
                    completion(false, "")
                }else if json["message"].stringValue == "sorry is mobile exsist" {
                    completion(false, "")
                }else{
                    completion(true, "")
                    let status = json["status"].stringValue
                    let fullname = json["fullname"].stringValue
                    let email = json["email"].stringValue
                    let id = json["_id"].stringValue
                    let mobile = json["mobile"].stringValue
                    let password = json["password"].stringValue
                    UserDefaults.standard.set(status, forKey: "status")
                    UserDefaults.standard.set(fullname, forKey: "fullname")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(mobile, forKey: "mobile")
                    UserDefaults.standard.set(password, forKey: "password")                }
            case .failure(let error):
                print(error)
                completion(false, "")
            }
        }
    }
    func update(name:String,email:String,proImage:String, completion: @escaping(_ status: Bool, _ error: String) ->()){
        let parameters = ["fullname":name,"email":email,"personalImg":proImage]
        print(parameters)
        let UserID = UserDefaults.standard.value(forKey: "id")
        let url = APIKeys().UPDATE_URL
        Alamofire.request("\(url)\(UserID!)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                if json["message"].stringValue == "sorry is email exsist" {
                    completion(false, "")
                }else if json["message"].stringValue == "sorry is mobile exsist" {
                    completion(false, "")
                }else{
                    completion(true, "")
                    let status = json["status"].stringValue
                    let fullname = json["fullname"].stringValue
                    let email = json["email"].stringValue
                    let id = json["_id"].stringValue
                    let mobile = json["mobile"].stringValue
                    let password = json["password"].stringValue
                    UserDefaults.standard.set(status, forKey: "status")
                    UserDefaults.standard.set(fullname, forKey: "fullname")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(mobile, forKey: "mobile")
                    UserDefaults.standard.set(password, forKey: "password")                }
            case .failure(let error):
                print(error)
                completion(false, "")
            }
        }
    }
    func changepassword(password:String , completion: @escaping (_ status:Bool, _ error:String) -> ()){
        let UserID = UserDefaults.standard.value(forKey: "id")
        let parameters = ["password":password]
        let url = APIKeys().UPDATE_URL
        Alamofire.request("\(url)\(UserID!)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                let password = json["password"].stringValue
                UserDefaults.standard.set(password, forKey: "password")
                completion(true,"")
            case .failure(let error):
                print(error)
                completion(false,"")
            }
        }
    }
    func getCategory()
    {
        APPCATEGORIES = []
        Alamofire.request(APIKeys().GET_CATEGORY, method: .get , encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->APPCATEGORIES",json)
                for category in json {
                    let singleCategory = Category()
                    singleCategory.id = category["_id"].stringValue
                    singleCategory.titleAR = category["titleAr"].stringValue
                    singleCategory.titleEN = category["titleEN"].stringValue
                    APPCATEGORIES.append(singleCategory)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getZones()
    {
        APPZONES = []
        Alamofire.request(APIKeys().GET_ZONES, method: .get , encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->APPZONES",json)
                for zone in json {
                    let singlezone = Zone()
                    singlezone.id = zone["_id"].stringValue
                    singlezone.titleAR = zone["titleAr"].stringValue
                    singlezone.titleEN = zone["titleEN"].stringValue
                    APPZONES.append(singlezone)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    // upload image
    func uploadImage(image: UIImage, completion: @escaping  (String?) -> Void) {
        guard let data = UIImageJPEGRepresentation(image, 0.9) else {
            return
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let imageName = formatter.string(from: date)
        Alamofire.upload(multipartFormData: { (form) in
            form.append(data, withName: "file", fileName: "\(imageName).jpg", mimeType: "image/jpg")
            
        }, to: APIKeys().UPLOAD_FILE, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                
                upload.responseString { response in
                    //print(response.value!)
                    if let val = response.value {
                        completion(val)
                    }
                    
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    // Check favorite Place
    func Checkfavorite(completion: @escaping (_ status: Int) -> ())
    {
        let placeID = UserDefaults.standard.value(forKey: "placeID")! as! String
        let UserID = UserDefaults.standard.value(forKey: "id") ?? ""
        let parameters = ["placeID":placeID,"userID":UserID]
        print(parameters)
        Alamofire.request(APIKeys().CHECK_FAV_PLACE, method: .get ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("user", UserID)
                print(json)
                if json["message"].intValue == 1 {
                    print("fav")
                    completion(json["message"].intValue)
                }else if json["message"].intValue == -1 {
                    print("Not fav")
                    completion(json["message"].intValue)
                }
                print("Done")
                completion(0)
            case .failure(let error):
                print(error)
                completion(0)
            }
        }
    }
    
    // Add Place To Favorite
    func addPlaceTofavorite(placeID:String,completion: @escaping (_ status: Bool, _ error: String) -> ())
    {
        let UserID = UserDefaults.standard.value(forKey: "id")!
        let parameters = ["placeID":placeID,"userID":UserID]
        print(parameters)
        Alamofire.request(APIKeys().ADDPLACE_FAV, method: .get ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                print("Done")
                completion(true,"")
            case .failure(let error):
                print(error)
                completion(false,"")
            }
        }
    }
    // GET ALL FAV PLACES
    func Allfavplaces(completion: @escaping (_ status: [Favorite]) -> ())
    {
        let UserID = UserDefaults.standard.value(forKey: "id") ?? ""
        let parameters = ["id":UserID]
        print(parameters)
        Alamofire.request(APIKeys().ALL_FAVPLACES, method: .get ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->FavoritePLACES",json)
                var userPlaces: [Favorite] = []
                for place in json {
                    let single = Favorite()
                    if let place  = place["placeID"].dictionary{
                        if let title = place["title"]?.stringValue {  single.titlename = title}
                        if let title = place["_id"]?.stringValue
                            {  single._id = title}

                        if let title = place["logo"]?.stringValue {  single.logoPath = title}
                        if let title = place["totalFav"]?.stringValue {  single.totalFav = title}
                        if let title = place["totalRate"]?.doubleValue {  single.totalRate = title}
                        if let category  = place["categoryID"]?.dictionary{
                            if let categoryEN = category["titleEN"]?.string {  single.categoryID = categoryEN}
                        }
                        if let zone  = place["zoneID"]?.dictionary{
                            if let zoneEN = zone["titleEN"]?.string {  single.zoneID = zoneEN}
                        }
                    }
                    userPlaces.append(single)
                }
                completion(userPlaces)
            case .failure(let error):
                print(error)
                completion([])
                
            }
        }
    }
    // Remove Place From Favorite
    func RemovePlaceFromfavorite(placeID:String,completion: @escaping (_ status: Bool, _ error: String) -> ())
    {
        let UserID = UserDefaults.standard.value(forKey: "id")!
        let parameters = ["userID":UserID,"placeID":placeID]
        print(parameters)
        Alamofire.request(APIKeys().REMOVEPLACE_FAV, method: .get ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                print("Done")
                completion(true,"")
            case .failure(let error):
                print(error)
                completion(false,"")
            }
        }
    }

   
    // Add Place
    func addPlace(logoPath: String, img1: String, img2: String, img3: String, img4: String, img5: String, img6: String,  title: String,  desc: String,face: String,insta: String,whatsapp: String,website: String,twitter: String,youtube: String,lang: Double,lat: Double,categoryID:String,zoneID:String,mobile:String,email:String,completion: @escaping (_ status: Bool, _ error: String) -> ())
    {
        let UserID = UserDefaults.standard.value(forKey: "id")!
        let parameters = ["logo":logoPath,"img1":img1,"img2":img2,"img3":img3,"img4":img4,"img5":img5,"img6":img6,"description":desc,"insta":insta,"face":face,"twit":twitter,"whats":whatsapp,"website":website,"lang":lang,"lat":lat,"categoryID":categoryID,"zoneID":zoneID,"mobile":mobile,"email":email,"userID":UserID,"title":title]
        print(parameters)
        Alamofire.request(APIKeys().ADD_PLACE, method: .post ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if json["message"].stringValue == "complete"{
                    completion(true,"")
                    print("Done")
                    print("Hello Succcess")
                }else{
                    completion(false,"")
                }
            case .failure(let error):
                print(error)
                print("Hello Error")
                completion(false,"")
            }
        }
    }
    //rate place
    func ratePlace(userID: String,placeID: String , rate: Double,completion: @escaping (_ status: Bool) -> ())
    {
        let parameters = ["userID":userID, "placeID":placeID,"rate":rate] as [String : Any]
        Alamofire.request(APIKeys().RATE_PLACE, method: .post ,parameters: parameters,  encoding: URLEncoding.default).validate().responseJSON { response in
            print("--Parameters", parameters)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(true)
            case .failure(let error):
                print(error)
                completion(true)
            }
        }
    }
    // get user image
    
    func getUserData(userID: String ,completion: @escaping (_ status: String) -> ())
    {
         let url = APIKeys().GET_USER_DATA
        Alamofire.request("\(url)?id=\(userID)", method: .get ,  encoding: URLEncoding.default).validate().responseJSON { response in
            print("--url", "\(url)?id=\(userID)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("json jso json",json)
                let image = json["personalImg"].stringValue
                completion(image)
            case .failure(let error):
                print(error)
                completion("")
            }
        }
    }

    
    
    
    //get place
    func getUserRate(userID: String,placeID: String ,completion: @escaping (_ status: Double) -> ())
    {
        let parameters = ["userID":userID, "placeID":placeID] as [String : Any]
        Alamofire.request(APIKeys().USER_RATE_PLACE, method: .get ,parameters: parameters,  encoding: URLEncoding.default).validate().responseJSON { response in
            print("--Parameters", parameters)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let rate = json["message"].doubleValue
                completion(rate)
            case .failure(let error):
                print(error)
                completion(0.0)
            }
        }
    }
    // edit place
    func editPlace(logoPath: String, img1: String, img2: String, img3: String, img4: String, img5: String, img6: String,  title: String,  desc: String,face: String,insta: String,whatsapp: String,website: String,twitter: String,youtube: String,lang: Double,lat: Double,categoryID:String,zoneID:String,mobile:String,email:String,id:String,completion: @escaping (_ status: Bool, _ error: String) -> ())
    {
        let parameters = ["logo":logoPath,"img1":img1,"img2":img2,"img3":img3,"img4":img4,"img5":img5,"img6":img6,"description":desc,"insta":insta,"face":face,"twit":twitter,"whats":whatsapp,"website":website,"lang":lang,"lat":lat,"categoryID":categoryID,"zoneID":zoneID,"mobile":mobile,"email":email,"title":title] as [String : Any]
        print(parameters)
        let url = APIKeys().UPDATE_PLACE
        Alamofire.request("\(url)\(id)", method: .put ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                print(value)
                completion(true,"")

            case .failure(let error):
                print(error)
                print("Hello Error")
                completion(false,"")
                print(response.result)

                print(id)
            }
        }
    }
    // MARK: - Get Terms
    func getTerms()
    {
        APPTERMS = []
        Alamofire.request(APIKeys().TERMS_URL, method: .get ,  encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->APPTERMS",json)
                for term in json {
                    let single = AppData()
                    single.id = term["_id"].stringValue
                    single.titleAR = term["titleAr"].stringValue
                    single.titleEN = term["titleEN"].stringValue
                    APPTERMS.append(single)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //Search For Places
    func searchForPlaces(searchText: String,completion: @escaping (_ status: [SearchResult]) -> ())
    {
        let escapedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlstring = "\("http://139.59.158.10:7000/api/user/getZoneSearch?name=\(escapedString!)")"

        Alamofire.request(urlstring,method: .get ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                var resultValue :[SearchResult] = []
                let json = JSON(value).arrayValue
                print("--->",json)
                for item in json {
                    let single  = SearchResult()
                    single.createdAt = item["createdAt"].stringValue
                    single.id = item["_id"].stringValue
                    single.status = item["status"].intValue
                    single.titleAr = item["titleAr"].stringValue
                    single.titleEN = item["titleEN"].stringValue
                    single.updatedAt = item["updatedAt"].stringValue
                    resultValue.append(single)
                    print(single.updatedAt!)

                }
                completion(resultValue)
                print(resultValue)

            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    // filter by name
    func filterbyname(searchText: String,zoneID:String,completion: @escaping (_ status: [Places]) -> ())
    {
        let searchtextString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlstring = "\("http://139.59.158.10:7000/api/user/filterPlaceByName?name=\(searchtextString!)&zoneID=\(zoneID)")"
        Alamofire.request(urlstring,method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                print(urlstring)
                var userPlaces: [Places] = []
                let json = JSON(value).arrayValue
                print("--->",json)
                for place in json {
                    let single = Places()
                    single._id = place["_id"].stringValue
                    if let category  = place["categoryID"].dictionary{
                        if let categoryEN = category["titleEN"]?.string {  single.categoryID = categoryEN}
                    }
                    single.lang = place["lang"].stringValue
                    single.lat = place["lat"].stringValue
                    single.logoPath = place["logo"].stringValue
                    single.titlename = place["title"].stringValue
                    single.totalwatch = place["totalWatech"].stringValue
                    single.totalFav = place["totalFav"].stringValue
                    single.rate = place["totalRate"].stringValue
                    userPlaces.append(single)
                }
                completion(userPlaces)
                print(userPlaces)
                
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    // Filter By Category
    func filterbycategory(categoryID: String,zoneID:String,completion: @escaping (_ status: [Places]) -> ())
    {
        let urlstring = "\("http://139.59.158.10:7000/api/user/filterPlaceByCategory?categoryID=\(categoryID)&zoneID=\(zoneID)")"
        Alamofire.request(urlstring,method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                print(urlstring)
                var userPlaces: [Places] = []
                let json = JSON(value).arrayValue
                print("--->",json)
                for place in json {
                    let single = Places()
                    single._id = place["_id"].stringValue
                    if let category  = place["categoryID"].dictionary{
                        if let categoryEN = category["titleEN"]?.string {  single.categoryID = categoryEN}
                    }
                    single.lang = place["lang"].stringValue
                    single.lat = place["lat"].stringValue
                    single.logoPath = place["logo"].stringValue
                    single.titlename = place["title"].stringValue
                    single.totalwatch = place["totalWatech"].stringValue
                    single.totalFav = place["totalFav"].stringValue
                    single.rate = place["totalRate"].stringValue
                    userPlaces.append(single)
                }
                completion(userPlaces)
                print(userPlaces)
                
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }

    
    // Get Added Place
    func getplaces(completion: @escaping (_ status: [Places]) -> ())
    {
        let UserID = UserDefaults.standard.value(forKey: "id")
        let url = APIKeys().PLACES
        Alamofire.request("\(url)?userID=\(UserID!)", method: .get ,  encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->PLACES",json)
                var userPlaces: [Places] = []
                for place in json {
                    let single = Places()
                    
                    single._id = place["_id"].stringValue
                   // single.categoryID = place["categoryID"].stringValue
                    if let category  = place["categoryID"].dictionary{
                            if let categoryEN = category["titleEN"]?.string {  single.categoryID = categoryEN}
                    }
                    if let zone  = place["zoneID"].dictionary{
                        if let zoneEN = zone["titleEN"]?.string {  single.zoneID = zoneEN}
                    }
                    single.lang = place["lang"].stringValue
                    single.lat = place["lat"].stringValue
                    single.logoPath = place["logo"].stringValue
                    single.titlename = place["title"].stringValue
                   // single.zoneID = place["zoneID"].stringValue
                    single.totalFav = place["totalFav"].stringValue
                    single.totalRate = place["totalRate"].doubleValue
                    single.status = place["status"].intValue
                    userPlaces.append(single)
                }
                completion(userPlaces)
            case .failure(let error):
                print(error)
                completion([])

            }
        }
    }
    // Remove User Place
    func removeuserplace(id:String,completion: @escaping (_ status: Bool, _ error: String) -> ()){
        let url = "\("http://139.59.158.10:7000/api/user/deletePlace?id=\(id)")"
        Alamofire.request(url, method: .get ,encoding: URLEncoding.default).responseJSON { response in
            print(url)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(true,"")
            case .failure(let error):
                print(error)
                completion(false,"")
            }
        }
    }

    // Place By Zone
    func getplacebyzone(ZoneID:String,completion: @escaping (_ status: [Places]) -> ())
    {
        let url = "\("http://139.59.158.10:7000/api/user/PlacesByZone?zoneID=\(ZoneID)")"
        Alamofire.request(url, method: .get , encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->PLACES_BY_ZONES",json)
                var userPlaces: [Places] = []
                for place in json {
                    let single = Places()
                    single._id = place["_id"].stringValue
                    if let category  = place["categoryID"].dictionary{
                        if let categoryEN = category["titleEN"]?.string {  single.categoryID = categoryEN}
                    }
                    single.lang = place["lang"].stringValue
                    single.lat = place["lat"].stringValue
                    single.logoPath = place["logo"].stringValue
                    single.titlename = place["title"].stringValue
                    single.totalwatch = place["totalWatech"].stringValue
                    single.totalFav = place["totalFav"].stringValue
                    single.rate = place["totalRate"].stringValue
                    userPlaces.append(single)
                }
                completion(userPlaces)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }

    // MARK: - Get About
    func getAbout()
    {
        APPABOUT = []
        Alamofire.request(APIKeys().ABOUT_APP, method: .get ,  encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->APPAbOUT",json)
                for term in json {
                    let single = AppData()
                    single.id = term["_id"].stringValue
                    single.titleAR = term["titleAr"].stringValue
                    single.titleEN = term["titleEN"].stringValue
                    APPABOUT.append(single)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getPolicy()
    {
        APPPOLICY = []
        Alamofire.request(APIKeys().POLICY, method: .get ,  encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print("-->POLICY",json)
                for term in json {
                    let single = AppData()
                    single.id = term["_id"].stringValue
                    single.titleAR = term["titleAr"].stringValue
                    single.titleEN = term["titleEN"].stringValue
                    APPPOLICY.append(single)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //contact us
    func contactus(imgpath:String,title:String,message:String,completion: @escaping (_ status: Bool, _ error: String) -> ()){
        let UserID = UserDefaults.standard.value(forKey: "id")!
        let parameters = ["imgPath":imgpath,"msg":message,"title":title,"userID":UserID]

        Alamofire.request(APIKeys().CONTACT_US, method: .post ,parameters:parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(parameters)
                print(json)
                print("asd")
                completion(true,"")
            case .failure(let error):
                print(error)
                completion(false,"")

            }
        }
    }
    //login
    func login(email: String ,password: String ,  completion: @escaping (_ status: Bool, _ error: String) -> ())
    {
        let parameters = ["val":email,"password":password]
        Alamofire.request(APIKeys().LOGIN_URL, method: .get ,parameters: parameters,  encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("-->USER",json)
                let status = json["status"].stringValue
                let fullname = json["fullname"].stringValue
                let email = json["email"].stringValue
                let id = json["_id"].stringValue
                let mobile = json["mobile"].stringValue
                let password = json["password"].stringValue
                UserDefaults.standard.set(status, forKey: "status")
                UserDefaults.standard.set(fullname, forKey: "fullname")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(id, forKey: "id")
                UserDefaults.standard.set(mobile, forKey: "mobile")
                UserDefaults.standard.set(password, forKey: "password")
                print("------>",fullname)
                if json["message"].stringValue == "Authentication failed. User not found." {
                    completion(false, "")
                }else if json["message"].stringValue == "Authentication failed. Wrong password." {
                    completion(false, "")
                }else if json["message"].stringValue == "this account is suspend !!!" {
                    completion(false, "")
                }else{
                completion(true,"")
                   
                }
            case .failure(let error):
                print(error)
                completion(false,"")
            }
        }
    }
}
