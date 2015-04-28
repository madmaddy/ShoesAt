//
//  ViewControllerAddTrip.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerAddTrip : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate>
{
    UIImagePickerController *picker;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *yourTable;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UILabel *destination;
@property (strong, nonatomic) IBOutlet UILabel *visitedLabel;
@property (strong, nonatomic) IBOutlet UILabel *andLabel;
@property (strong, nonatomic) IBOutlet UITextView *dsriptionField;

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIButton *addPicBtn;

@property (nonatomic, strong) NSMutableArray *searchResult;
@end
