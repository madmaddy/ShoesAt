//
//  ViewControllerLogOut.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerLogOut.h"
#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@implementation ViewControllerLogOut

@synthesize accountName;
@synthesize accountPicture;
@synthesize numberOfTrips;

-(void)viewDidLoad

{
     PFUser *currentUser = [PFUser currentUser];
    
    accountName.text = currentUser.username ;
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    
    [query whereKey:@"username" equalTo:usernameGlobal];
    
    NSLog(@"usernameGl:%@", usernameGlobal);
    
    objects = [query findObjects];
    
    PFQuery *queryTrips = [PFQuery queryWithClassName:@"trip"];
    
    [queryTrips whereKey:@"username" equalTo:usernameGlobal];
    
    
    NSArray *objects2 = [queryTrips findObjects];
    
    if ((unsigned long)objects2.count ==0) {
        numberOfTrips.text = @"You haven't shared any trips!";
    }else{
    
    numberOfTrips.text = [NSString stringWithFormat:@"You have shared %lu trips!", (unsigned long)objects2.count];
    }
    if (currentUser) {
        NSLog(@"current:%@", currentUser);
        
        if (!([currentUser objectForKey:@"userPhoto"] == NULL)) {
            NSLog(@"a verificat");
            PFFile *imageFile = [currentUser objectForKey:@"userPhoto"];
            
            
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    accountPicture.image = [UIImage imageWithData:data];}
            }];
        }
            
        
    } else {
     
    }
    
   
    
    /*
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
    
  */
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
    [self performSegueWithIdentifier:@"backToprofile" sender:self];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    
    accountPicture.image = image;
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"aici in logged");
        NSData* data = UIImageJPEGRepresentation(accountPicture.image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        [currentUser addObject:imageFile forKey:@"userPhoto"];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // The image has now been uploaded to Parse. Associate it with a new object
                PFObject* newPhotoObject = [PFObject objectWithClassName:@"PhotoObjectUser"];
                [newPhotoObject setObject:imageFile forKey:@"image"];
                [currentUser setObject:imageFile forKey:@"userPhoto"];
                [[PFUser currentUser] saveInBackground]; 
                [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        NSLog(@"Saved");
                    }
                    else{
                        // Error
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }
        }];

        }
    [self dismissModalViewControllerAnimated:YES];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)actionChangePicture:(id)sender {
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)goBackToProfileFromAccount:(id)sender {
    [self performSegueWithIdentifier:@"goBackToProfileFromAccount" sender:self];
}

- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"backToProfileAfterLogOut" sender:self];
}
@end
