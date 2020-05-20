//
//  APIKeys.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import Foundation


class APIKeys: NSObject {
    var BASE_URL:String {
        return "http://139.59.158.10:7000/api/user/"
    }
    var REGISTER_URL: String { return BASE_URL + "register"}
    var LOGIN_URL: String { return BASE_URL + "loginUser"}
    var TERMS_URL: String { return BASE_URL + "getTerms"}
    var UPDATE_URL: String { return BASE_URL + "user/"}
    var GET_CATEGORY: String { return BASE_URL + "getCategory"}
    var GET_ZONES: String { return BASE_URL + "getZone"}
    var ADD_PLACE: String { return BASE_URL + "addPlace"}
    var UPLOAD_FILE: String { return BASE_URL + "uploadFile"}
    var CONTACT_US: String { return BASE_URL + "addContactUS"}
    var ABOUT_APP: String { return BASE_URL + "getAboutApp"}
    var POLICY: String { return BASE_URL + "getPolicy"}
    var PLACES: String { return BASE_URL + "userPlaces"}
    var ADDPLACE_FAV: String { return BASE_URL + "addPlaceToFav"}
    var GET_PLACE_ID: String { return BASE_URL + "placeByID"}
    var CHECK_FAV_PLACE: String { return BASE_URL + "isPlaceFav"}
    var REMOVEPLACE_FAV: String { return BASE_URL + "removeUserFav"}
    var ALL_FAVPLACES: String { return BASE_URL + "userFavPlaces"}
    var SEARCH_FOR_PLACES: String { return BASE_URL + "getZoneSearch"}
    var PLACES_BY_ZONES: String { return BASE_URL + "PlacesByZone"}
    var REMOVE_PLACE: String { return BASE_URL + "removeUserFav"}
    var UPDATE_PLACE: String { return BASE_URL + "place/"}
    var RATE_PLACE: String { return BASE_URL + "ratePlace"}
    var USER_RATE_PLACE: String { return BASE_URL + "getUserRate"}
    var ALL_PLACES_MAP: String {return BASE_URL + "PlacesMap"}
    var GET_USER_DATA: String {return BASE_URL + "getUserByID"}

    
}

