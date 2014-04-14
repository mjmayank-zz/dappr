//
//  AddPurchaseViewController.h
//  Dappr
//
//  Created by Mayank Jain on 4/14/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddPurchaseViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
