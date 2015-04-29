//
//  ViewControllerLogOut.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerLogOut : ViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *picker;
}
@property (strong, nonatomic) IBOutlet UIImageView *accountPicture;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UIButton *changePic;
- (IBAction)actionChangePicture:(id)sender;
- (IBAction)goBackToProfileFromAccount:(id)sender;
- (IBAction)logOut:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *numberOfTrips;

@end
