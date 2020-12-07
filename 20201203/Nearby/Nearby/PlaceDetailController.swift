//
//  PlaceDetailController.swift
//  Nearby
//
//  Created by akio0911 on 2020/12/03.
//

import Foundation
import UIKit
import Combine
import MapKit

final class PlaceDetailController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var openStatusLabel: UILabel!
    @IBOutlet private weak var placeImageView: UIImageView!
    @IBOutlet private weak var mapView: MKMapView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var viewModel: PlaceDetailViewModel! = PlaceDetailViewModel(
        place: NearbyPlace(
            name: "tokyo",
            openStatus: true,
            location: CLLocation(latitude: 35.658584, longitude: 139.7454316),
            imageURL: "https://www.enjoytokyo.jp/img/s_s/l/_26/l/lm_26IMG1.jpg"
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        subscriptions = [
            viewModel.$title.assign(to: \.text!, on: titleLabel),
            viewModel.$distance.assign(to: \.text!, on: distanceLabel),
            viewModel.$isOpen.map { $0 ? "Open" : "Close" }.assign(to: \.text!, on: openStatusLabel),
            viewModel.$isOpen.map { $0 ? UIColor.green : UIColor.red }.assign(to: \.textColor!, on: openStatusLabel)
        ]
        
        viewModel.$placeImageUrl
            .compactMap { URL(string: $0) }
            .flatMap { url in
                return URLSession.shared.dataTaskPublisher(for: url)
                    .catch { _ in
                        return Empty().setFailureType(to: Never.self)
                    }
            }
            .compactMap { UIImage(data: $0.data) }
            .assign(to: \.image, on: placeImageView)
            .store(in: &subscriptions)

        viewModel.$location
            .compactMap({ location -> (MKCoordinateRegion, MKPointAnnotation)? in
                guard let lat = location?.coordinate.latitude,
                      let long = location?.coordinate.longitude else { return nil }
                let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = center
                return (region, annotation)
            })
            .sink(receiveValue: { [weak self] in
                self?.mapView.setRegion($0.0, animated: true)
                self?.mapView.addAnnotation($0.1)
            })
            .store(in: &subscriptions)
    }
}
