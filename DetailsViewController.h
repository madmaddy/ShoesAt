//
//  DetailsViewController.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 24/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailsViewController : ViewController <UIScrollViewDelegate, MKMapViewDelegate,  CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (strong, nonatomic) IBOutlet UIView *viewBackOfScroll;
@property (strong, nonatomic) IBOutlet UIButton *firstPic;
@property (strong, nonatomic) IBOutlet UIButton *lastPic;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIImageView *tripImage;
@property (strong, nonatomic) IBOutlet UILabel *destination;


@end
