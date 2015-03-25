//
//  ViewController.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 09/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerLoggedIn.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize userFiedl;
@synthesize passFiedl;
@synthesize signInBtn;
@synthesize grayView;



- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"email address %@",[user objectForKey:@"email"]);
    NSLog(@"Token Return %@",[FBSession activeSession].accessTokenData);
    [self performSegueWithIdentifier:@"profile" sender:self];

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
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(50, 420, loginView.frame.size.width, loginView.frame.size.height);
   // loginView.center = self.view.center;
    [self.view addSubview:loginView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signInClicked:(id)sender {
    [self performSegueWithIdentifier:@"profile" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"profile"])
    {
        //ViewControllerLoggedIn *RVC = [segue destinationViewController];
        
    }
    
}


@end
