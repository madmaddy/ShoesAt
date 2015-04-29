//
//  ViewControllerLoggedIn.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomCell.h"

@interface ViewControllerLoggedIn : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *addTripBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableViewTrips;
- (IBAction)goToAccount:(id)sender;


@end
