//
//  ViewController.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 09/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerLoggedIn.h"
#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface ViewController (){
    NSUserDefaults *info;
    int logged;
}

@end

@implementation ViewController

@synthesize userFiedl;
@synthesize passFiedl;
@synthesize signInBtn;
@synthesize grayView;
@synthesize emailFiedl;
/*
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"email address %@",[user objectForKey:@"email"]);
    NSLog(@"Token Return %@",[FBSession activeSession].accessTokenData);
    [self performSegueWithIdentifier:@"goToProfile" sender:self];

   }*/

-(void)viewDidAppear:(BOOL)animated{

    PFUser *currentUser = [PFUser currentUser];
    usernameGlobal = currentUser.username;
    NSLog(@"logged:%d", logged);
    if (currentUser) {
      [self performSegueWithIdentifier:@"profile" sender:self];
        
    } else {
        NSLog(@"user not okei");
    }
    
   
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = self.grayView.layer;
    [layer setCornerRadius:30.0f];
    
    // border
    [layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [layer setBorderWidth:1.5f];
    
    // drop shadow
    [layer setShadowColor:[UIColor blackColor].CGColor];
    [layer setShadowOpacity:0.5];
    [layer setShadowRadius:2.0];
    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    // Do any additional setup after loading the view, typically from a nib.
   // UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 1)];
   // lineView.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:lineView];
    /*
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(50, 420, loginView.frame.size.width, loginView.frame.size.height);
   // loginView.center = self.view.center;
    [self.view addSubview:loginView];*/
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userFiedl resignFirstResponder];
    [self.passFiedl resignFirstResponder];
    [self.emailFiedl resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField){
        [textField resignFirstResponder];
    }
    return NO ;
}
- (IBAction)signInClicked:(id)sender {
   
        PFUser *user = [PFUser user];
        user.username = userFiedl.text;
        user.password = passFiedl.text;
        user.email = emailFiedl.text;
    
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                 info = [NSUserDefaults standardUserDefaults];
                 [info setObject:userFiedl.text forKey:@"username"];
                 [info setObject:passFiedl.text forKey:@"password"];
                 [info setObject:emailFiedl.text forKey:@"email"];
            
                // [self performSegueWithIdentifier:@"goToProfile" sender:self];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                [self alertStatus:@"Error":errorString];
            }
        }];
    
   

}


- (IBAction)loginClicked:(id)sender {
    NSString *theUsername = [info stringForKey:@"username"];
    NSString *thePass = [info stringForKey:@"password"];
    NSLog(@"%@ %@", theUsername, thePass);
    if(![theUsername isEqualToString:@""]){
        // NSString *theEmail = [info stringForKey:@"email"];
        [PFUser logInWithUsernameInBackground:theUsername password:thePass
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                               // [self performSegueWithIdentifier:@"profile" sender:self];
                                            } else {
                                                NSLog(@"Login failed");
                                                userFiedl.text = @"";
                                                passFiedl.text = @"";
                                                emailFiedl.text = @"";
                                            }
                                        }];
    }
}

- (void) alertStatus:(NSString *)msg : (NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message: msg
                                                       delegate: self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
