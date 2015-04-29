//
//  CustomCell.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 24/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *curvedImage;
@property (strong, nonatomic) IBOutlet UIImageView *pinTrip;
@property (strong, nonatomic) IBOutlet UIButton *detailButton;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *photoFromTrip;
@property (strong, nonatomic) IBOutlet UILabel *title2;
@property (strong, nonatomic) IBOutlet UIImageView *photoFromTrip2;

@end
