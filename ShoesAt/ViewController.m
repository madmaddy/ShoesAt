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
@synthesize backImageView;

/*
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"email address %@",[user objectForKey:@"email"]);
    NSLog(@"Token Return %@",[FBSession activeSession].accessTokenData);
    [self performSegueWithIdentifier:@"goToProfile" sender:self];

   }*/


-(void)viewWillAppear:(BOOL)animated{
    PFUser *currentUser = [PFUser currentUser];
    usernameGlobal = currentUser.username;
    NSLog(@"will");
    if (currentUser) {
        grayView.hidden = YES;
        backImageView.hidden = NO;
        backImageView.image = [UIImage imageNamed:@"Untitled-2.png"];
    }

}
-(void)viewDidAppear:(BOOL)animated{
   
    NSLog(@"dest %@",self.presentingViewController.class);
    PFUser *currentUser = [PFUser currentUser];
    usernameGlobal = currentUser.username;
    
    NSString *classCurrent = [NSString stringWithFormat:@"%@", self.presentingViewController.class];
    
    if (currentUser && ![classCurrent isEqualToString:@"ViewControllerLoggedIn"]) {
        
      [self performSegueWithIdentifier:@"profile" sender:self];
    } else if(currentUser){
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
    NSLog(@"pfuser");
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
              
                 info = [NSUserDefaults standardUserDefaults];
                 [info setObject:userFiedl.text forKey:@"username"];
                 [info setObject:passFiedl.text forKey:@"password"];
                 [info setObject:emailFiedl.text forKey:@"email"];
                usernameGlobal = user.username;
           
                 [self performSegueWithIdentifier:@"profile" sender:self];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                [self alertStatus:@"Error":errorString];
            }
        }];
    
   

}


- (void) alertStatus:(NSString *)msg : (NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message: msg
                                                       delegate: self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) animateTextField: (UITextField *) textField up: (BOOL) up
{
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    
    int movement = ( up ? -movementDistance : movementDuration ) ;
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void) animateTextField: (UITextField *) textField down: (BOOL) down
{
    const int movementDistance = -80;
    const float movementDuration = 0.3f;
    
    int movement = ( down ? -movementDistance : movementDuration ) ;
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField down:YES];
}



@end
