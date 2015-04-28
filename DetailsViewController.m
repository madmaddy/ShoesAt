//
//  DetailsViewController.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 24/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "DetailsViewController.h"
#import "ViewControllerLoggedIn.h"

@implementation DetailsViewController
{
    CLLocationManager *locationManager;
}
@synthesize  scr;
@synthesize viewBackOfScroll;
@synthesize firstPic;
@synthesize lastPic;
@synthesize mapView;
@synthesize back;
@synthesize textView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *imgs=[NSMutableArray  arrayWithObjects:
                           
                            [UIImage imageNamed: @"pin.png"],
                            [UIImage imageNamed: @"pin2.png"],
                            [UIImage imageNamed: @"dash1.png"],
                            [UIImage imageNamed: @"dash2.png"],nil];
   
    [imgs addObject:[UIImage imageNamed:@"pin.png"]];
    [imgs addObject:[UIImage imageNamed:@"pin2.png"]];
    [imgs addObject:[UIImage imageNamed:@"dash1.png"]];
    [imgs addObject:[UIImage imageNamed:@"dash2.png"]];
    
    textView.text = [[objects objectAtIndex:selectedRow] valueForKey:@"tripDetails"];
   
    for(int i=0;i<imgs.count;i++)
    {
        CGRect frame;
        frame.origin.x=self.scr.frame.size.width *i;
        frame.origin.y=0;
        frame.size=self.scr.frame.size;
        UIImageView *subimg=[[UIImageView alloc]initWithFrame:frame];
        subimg.image=[imgs objectAtIndex:i];
        [self.scr  addSubview:subimg];
     
        self.scr.contentSize=CGSizeMake(self.scr.frame.size.width*imgs.count, self.scr.frame.size.height);
        
    }
    
    CALayer *shLayer4 = self.viewBackOfScroll.layer;
    shLayer4.masksToBounds = NO;
    shLayer4.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer4.shadowColor = [[UIColor grayColor] CGColor];
    shLayer4.shadowRadius = 2.0f;
    shLayer4.shadowOpacity = 0.80f;
    
    
    CLLocationCoordinate2D location;
    location.latitude = 44.4423606;
    location.longitude = 26.0987574;
    
    NSLog(@"%f-%f", location.latitude, location.longitude);
    
    [mapView setCenterCoordinate:location animated:YES];
    

    
    MKCoordinateSpan span =
    { .longitudeDelta = mapView.region.span.longitudeDelta / 450,
        .latitudeDelta  = mapView.region.span.latitudeDelta  / 450};
    
    
    
    MKCoordinateRegion region = { .center = location, .span = span };
    [mapView setRegion:region animated:YES];
    
    MKPlacemark *mPlacemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil] ;
    [mapView addAnnotation:mPlacemark];
  

}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = YES;
    int page = scr.contentOffset.x / scr.frame.size.width;
    
    NSLog(@"page:%d", page);
}*/

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scr.frame.size.width;
    int page = floor((self.scr.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}
- (IBAction)goBackToProfile:(id)sender {
    
}

@end
