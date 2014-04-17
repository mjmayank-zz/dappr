//
//  FeedViewController.h
//  Dappr
//
//  Created by Mayank Jain on 4/14/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "customCell.h"
#import "TitleView.h"

@interface FeedViewController : UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray * array;
@property (strong, nonatomic) NSMutableDictionary * objs;

- (IBAction)cancelButtonClicked:(UIStoryboardSegue *)segue;

@end
