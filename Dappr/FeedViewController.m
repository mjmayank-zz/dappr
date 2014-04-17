//
//  FeedViewController.m
//  Dappr
//
//  Created by Mayank Jain on 4/14/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = [[NSArray alloc] init];
    self.objs = [[NSMutableDictionary alloc] init];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Outfit"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded
            NSLog(@"Successfully retrieved %lu photos.", (unsigned long)objects.count);
            
            self.array = objects;
            
            [self.collectionView reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    query = [PFQuery queryWithClassName:@"ClothingItem"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded
            NSLog(@"Successfully retrieved %lu photos.", (unsigned long)objects.count);
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                
                for(PFObject * obj in objects){
                    
                    [self.objs setObject:obj forKey:obj.objectId];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.collectionView reloadData];
                    
                });
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self promptLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)promptLogin{
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (IBAction)cancelButtonClicked:(UIStoryboardSegue *)segue {
    NSLog(@"cancel button clicked");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.array objectAtIndex:section][@"Clothes"][0] count];
//    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [self.array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    customCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeedCell" forIndexPath:indexPath];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"ClothingItem"];
//    [query getObjectInBackgroundWithId:[self.array objectAtIndex:indexPath.section][@"Clothes"][0][indexPath.row] block:^(PFObject *clothing, NSError *error) {
//        PFFile *theImage = clothing[@"clothingImage"];
//        NSData *imageData = [theImage getData];
//        UIImage * data = [UIImage imageWithData:imageData];
//        [image setImage:data];
//    }];
    
    PFFile *theImage = [self.objs objectForKey:[self.array objectAtIndex:indexPath.section][@"Clothes"][0][indexPath.row] ][@"clothingImage"];
    NSData *imageData = [theImage getData];
    UIImage * data = [UIImage imageWithData:imageData];
    
    [cell.imageView setImage:data];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    TitleView * reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FeedTitleView" forIndexPath:indexPath];
    
    int sum = 0;
    
    for(NSString * objID in [self.array objectAtIndex:indexPath.section][@"Clothes"][0]){
        if([self.objs[objID][@"timesWorn"] integerValue]){
            sum = [self.objs[objID][@"price"] intValue]/[self.objs[objID][@"timesWorn"] integerValue];
        }
    }
    
    reuseableView.dateLabel.text = [self.array objectAtIndex:indexPath.section][@"date"];
    reuseableView.countLabel.text = [NSString stringWithFormat:@"Value: $%d", sum ];
    
    UIFont *avenir = [UIFont fontWithName:@"Avenir Medium" size:17.0];
    [reuseableView.dateLabel setFont:avenir];
    [reuseableView.countLabel setFont:avenir];
    
    return reuseableView;
}

@end
