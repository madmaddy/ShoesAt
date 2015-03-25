//
//  ViewControllerLogOut.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerLogOut.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation ViewControllerLogOut

@synthesize accountName;
@synthesize accountPicture;

-(void)viewDidLoad
{
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(50, 420, loginView.frame.size.width, loginView.frame.size.height);
    [self.view addSubview:loginView];
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"user_birthday",@"user_hometown",@"user_location",@"email",@"basic_info", @"picture.type(large)",nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                  }];
    
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@", [result objectForKey:@"gender"]);
        NSLog(@"%@", [result objectForKey:@"hometown"]);
        NSLog(@"%@", [result objectForKey:@"birthday"]);
        NSLog(@"%@", [result objectForKey:@"email"]);
        NSLog(@"%@", result);
        accountName.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"name"] ];
        NSString *imageUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"] ];
        //[accountPicture setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"profile.jpg"]];
        NSURL * imageURL = [NSURL URLWithString:imageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        accountPicture.image = [UIImage imageWithData:imageData];
    }];
    
  
    CALayer *shLayer4 = self.accountPicture.layer;
    shLayer4.masksToBounds = NO;
    shLayer4.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer4.shadowColor = [[UIColor grayColor] CGColor];
    shLayer4.shadowRadius = 2.0f;
    shLayer4.shadowOpacity = 0.80f;
   
    self.accountPicture.layer.cornerRadius = self.accountPicture.frame.size.width/2 - 1;
    self.accountPicture.clipsToBounds = YES;
}

- (IBAction)backToProfileFromAccount:(id)sender {
    [self performSegueWithIdentifier:@"backToProfileFromAccount" sender:self];
}

@end
