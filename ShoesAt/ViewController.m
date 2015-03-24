//
//  ViewController.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 09/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerLoggedIn.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize userFiedl;
@synthesize passFiedl;
@synthesize signInBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 1)];
   // lineView.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:lineView];
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
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
