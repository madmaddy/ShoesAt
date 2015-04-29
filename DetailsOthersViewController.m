//
//  DetailsOthersViewController.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 29/04/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "DetailsOthersViewController.h"
#import "ViewControllerTrips.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <GLKit/GLKit.h>


@implementation DetailsOthersViewController{
    NSArray *objectsOthers;
    NSArray *objectComments;
}

@synthesize tripImage;
@synthesize descriptionLabel;
@synthesize countryLabel;
@synthesize comment;
@synthesize allComments;
@synthesize noComments;

-(void) viewDidLoad{
    
    
    
    self.comment.delegate = self;
    
    self.allComments.delegate = self;
    self.allComments.dataSource = self;
    
    if(objectComments.count == 0){
        NSLog(@"empty");
        allComments.hidden = TRUE;
        noComments.hidden = FALSE;
    }else{
        allComments.hidden = FALSE;
        noComments.hidden = TRUE;
    }
    
    CALayer *shLayer = tripImage.layer;
    shLayer.masksToBounds = NO;
    shLayer.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer.shadowColor = [[UIColor grayColor] CGColor];
    shLayer.shadowRadius = 2.0f;
    shLayer.shadowOpacity = 0.80f;
    
    CALayer *shLayer2 = allComments.layer;
    shLayer2.masksToBounds = NO;
    shLayer2.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer2.shadowColor = [[UIColor grayColor] CGColor];
    shLayer2.shadowRadius = 2.0f;
    shLayer2.shadowOpacity = 0.80f;
    
    CALayer *shLayer3 = comment.layer;
    shLayer3.masksToBounds = NO;
    shLayer3.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer3.shadowColor = [[UIColor grayColor] CGColor];
    shLayer3.shadowRadius = 2.0f;
    shLayer3.shadowOpacity = 0.80f;
    
    PFQuery *query = [PFQuery queryWithClassName:@"trip"];
    
    [query whereKey:@"objectId" equalTo:idForSelectedCell];
    
    objectsOthers = [query findObjects];

    NSLog(@"object:%@", objectsOthers);
    
    PFFile *imageFile = [[objectsOthers objectAtIndex:0] valueForKey:@"picture1"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            tripImage.image = [self image:[UIImage imageWithData:data] scaledToSize:CGSizeMake(120,120)];}
    }];
    
    descriptionLabel.text = [[objects objectAtIndex:0] valueForKey:@"tripDetails"];
    countryLabel.text = [[objects objectAtIndex:0] valueForKey:@"country"];
    
    
}


- (IBAction)goBackToTripsOthers:(id)sender {
    [self performSegueWithIdentifier:@"goBackToTripsFromOthers" sender:self];
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
    comment.text = @"";
    [self animateTextField: textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField down:YES];
}

- (IBAction)addComment:(id)sender {
    [comment resignFirstResponder];
    if(!([comment.text isEqualToString:@""] && [comment.text isEqualToString:@"What do you think?"])){
        PFObject *commentO = [PFObject objectWithClassName:@"comment"];
        commentO[@"username"] = usernameGlobal;
        commentO[@"message"] = comment.text;
        commentO[@"tripObjectId"] = idForSelectedCell;
        
        [commentO saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                [allComments reloadData];
                comment.text = @"What do you think?";
                [self alertStatus:@"Congrats" :@"Comment posted!"];
                
            } else {
                NSLog(@"error:%@", error.description);
                [self alertStatus:@"Error":error.description];
            }
        }];
        
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PFQuery *query = [PFQuery queryWithClassName:@"comment"];
    
    [query whereKey:@"tripObjectId" equalTo:idForSelectedCell];
    
    objectComments = [query findObjects];
    
    NSLog(@"objects comments:%@", objectComments);
    
    return objectComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellComment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellComment"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *commentDateStr = [NSString stringWithFormat:@"%@", [[objectComments objectAtIndex:indexPath.row] valueForKey:@"createdAt"]];
    NSUInteger length = [commentDateStr length] - 5;
    NSLog(@"le:%lu", (unsigned long)length);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@ at %@",[[objectComments objectAtIndex:indexPath.row] valueForKey:@"username"],[commentDateStr substringToIndex:length]];
    cell.textLabel.text = [[objectComments objectAtIndex:indexPath.row] valueForKey:@"message"];
    if(indexPath.row > [objectComments count]){
       allComments.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        allComments.separatorColor = [UIColor clearColor];
    }
    
    if(objectComments.count == 0){
        NSLog(@"empty");
        allComments.hidden = TRUE;
        noComments.hidden = FALSE;
    }else{
        allComments.hidden = FALSE;
        noComments.hidden = TRUE;
    }
    
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.comment resignFirstResponder];
    if ([comment.text isEqualToString:@""]){
        comment.text = @"What do you think?";
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField){
        [textField resignFirstResponder];
    }
    return NO ;
}

- (UIImage *) image:(UIImage *)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (IBAction)appreciateTrip:(id)sender {
    PFObject* like = [PFObject objectWithClassName:@"liked"];
    like[@"username"] = usernameGlobal;
    like[@"tripObjectId"] = idForSelectedCell;
    [self alertStatus:@"YEY" :@"You like this trip!"];
    
}
@end
