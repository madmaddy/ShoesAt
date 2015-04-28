//
//  ViewController.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 09/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userFiedl;
@property (strong, nonatomic) IBOutlet UITextField *passFiedl;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIView *grayView;
@property (strong, nonatomic) IBOutlet UITextField *emailFiedl;
- (IBAction)loginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;


@end

NSString *usernameGlobal;
NSArray *objects;
int selectedRow;