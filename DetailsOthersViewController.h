//
//  DetailsOthersViewController.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 29/04/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsOthersViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *tripImage;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (strong, nonatomic) IBOutlet UITextField *comment;

- (IBAction)addComment:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *allComments;
@property (strong, nonatomic) IBOutlet UILabel *noComments;

- (IBAction)appreciateTrip:(id)sender;


@end
