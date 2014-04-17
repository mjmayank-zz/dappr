//
//  AddPurchaseViewController.m
//  Dappr
//
//  Created by Mayank Jain on 4/14/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import "AddPurchaseViewController.h"

@interface AddPurchaseViewController ()

@end

@implementation AddPurchaseViewController

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
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    
    UIFont *bebas = [UIFont fontWithName:@"Bebas Neue" size:17.0f];
    UIFont *proximaSmall = [UIFont fontWithName:@"ProximaNova-Regular" size:14.0];
    UIFont *proximaBig = [UIFont fontWithName:@"ProximaNova-Regular" size:17.0];
    UIFont *avenir = [UIFont fontWithName:@"Avenir Medium" size:17.0];
    
#pragma clang diagnostic pop
    
    [self.priceLabel setFont:avenir];
    [self.tagsLabel setFont:avenir];
    [self.tagsField setFont:avenir];
    
    self.tagsField.layer.borderWidth = 1.0f;
    self.tagsField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    [self.titleTextField setDelegate:self];
    [self.priceTextField setDelegate:self];
    
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [self.chooseButton setHidden:YES];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
            [self.navigationController popViewControllerAnimated:YES];
    }];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)saveButtonPressed:(id)sender {
    NSLog(@"Save pressed");
    PFObject *item = [[PFObject alloc] initWithClassName:@"ClothingItem"];

    // Save the photo
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile = [PFFile fileWithName:@"clothing.png" data:imageData];

    // Split up the tags based on semicolons.
    NSArray *tags = [_tagsField.text componentsSeparatedByString:@";"];
    
    
    
    item[@"clothingImage"] = imageFile;
    item[@"title"] = _titleTextField.text;
    item[@"price"] = _priceTextField.text;
    item[@"timesWorn"] = @0;
    [item addUniqueObjectsFromArray:tags forKey:@"tags"];
    
    [item saveInBackground];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Outfit saved." message:@"" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [alert show];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    [self animateTextField:self.view up:YES withInfo:notification.userInfo];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self animateTextField:self.view up:NO withInfo:notification.userInfo];
}

- (void) animateTextField: (UIView*) view up: (BOOL) up withInfo:(NSDictionary *)userInfo
{
    const int movementDistance = 215; // tweak as needed
    NSTimeInterval movementDuration;
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&movementDuration]; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationCurve: animationCurve];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)showChooser:(id)sender {
    [self selectPhoto];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextFieldDelegate


- (void) viewTapped{
    [self.titleTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.tagsField resignFirstResponder];
}

@end
