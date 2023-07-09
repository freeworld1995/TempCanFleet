//
//  File.swift
//  
//
//  Created by groo on 09/07/2023.
//

import Foundation

enum TaskStatus: String, Codable {
    case delivering = "delivering"
    case pendingPickup = "pending_pickup"
    case returning = "returning"
}

public struct DriverTask: Codable, Identifiable {
    public let id: String?
    let pickup: TaskLocation?
    let delivery: TaskLocation?
    let barcode: String?
    let note: String?
    let deliveryIndex: Int?
    let pickupIndex: Int?
    let returnIndex: Int?
    let skipPickup: Bool?
    let contactlessDelivery: Bool?
//    let executorType: ExecutorType?
//    let executorID: ExecutorID?
//    let requirements: Requirements?
//    let executorOrgID: OrgID?
    let assignedAt: String?
    let assignedBy: String?
    let createdOrgID: String?
    let merchantOrgID: String?
    let number: Int?
    let name: String?
    let trackingURL: String?
    let createdAt: String?
    let createdBy: String?
    let updatedAt: String?
    let status: TaskStatus?
    let estimatedDeliveryTime: Int?
    let etaAnnounce: Bool?
    let outForDelivery: Bool?
    let cleanPickupHubID: Bool?
    let outForDeliveryTime: String?
    let manualPickupOnly: Bool?
    let manualRoute: Bool?
    let expectedDeliveryBefore: String?
    let pickupHubID: String?
    let distance: Int?
    let duration: Int?
    let isAlerted: Bool?
    let pickedUpAt: String?
    let pickedUpBy: String?
    let pickedUpDetails: TaskPickupDetails?
    let preferredTeamID: String?
    let expectedDeliveryAfter: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pickup = "pickup"
        case delivery = "delivery"
        case barcode = "barcode"
        case note = "note"
        case deliveryIndex = "delivery_index"
        case pickupIndex = "pickup_index"
        case returnIndex = "return_index"
        case skipPickup = "skip_pickup"
        case contactlessDelivery = "contactless_delivery"
//        case executorType = "executor_type"
//        case executorID = "executor_id"
//        case requirements = "requirements"
//        case executorOrgID = "executor_org_id"
        case assignedAt = "assigned_at"
        case assignedBy = "assigned_by"
        case createdOrgID = "created_org_id"
        case merchantOrgID = "merchant_org_id"
        case number = "number"
        case name = "name"
        case trackingURL = "tracking_url"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case updatedAt = "updated_at"
        case status = "status"
        case estimatedDeliveryTime = "estimated_delivery_time"
        case etaAnnounce = "eta_announce"
        case outForDelivery = "out_for_delivery"
        case cleanPickupHubID = "clean_pickup_hub_id"
        case outForDeliveryTime = "out_for_delivery_time"
        case manualPickupOnly = "manual_pickup_only"
        case manualRoute = "manual_route"
        case expectedDeliveryBefore = "expected_delivery_before"
        case pickupHubID = "pickup_hub_id"
        case distance = "distance"
        case duration = "duration"
        case isAlerted = "is_alerted"
        case pickedUpAt = "picked_up_at"
        case pickedUpBy = "picked_up_by"
        case pickedUpDetails = "picked_up_details"
        case preferredTeamID = "preferred_team_id"
        case expectedDeliveryAfter = "expected_delivery_after"
    }
}

// MARK: - Delivery
public struct TaskLocation: Codable {
    let name: String?
    let phone: String?
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let country: String?
    let postcode: String?
    let lng: Double?
    let lat: Double?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case phone = "phone"
        case address1 = "address_1"
        case address2 = "address_2"
        case city = "city"
        case state = "state"
        case country = "country"
        case postcode = "postcode"
        case lng = "lng"
        case lat = "lat"
        case email = "email"
    }
}

public struct TaskPickupDetails: Codable {
    let photos: [String]?
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}
