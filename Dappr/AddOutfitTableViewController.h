//
//  AddOutfitTableViewController.h
//  Dappr
//
//  Created by Mayank Jain on 4/15/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddOutfitTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) NSArray * searchResults;
@property (strong, nonatomic) NSMutableDictionary * tags;
@property (strong, nonatomic) NSMutableArray * selected;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonPressed:(id)sender;

@end
