//
//  AddAProductViewController.m
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "AddAProductViewController.h"
#import "CurrentsTableViewController.h"
#import "FavoritesTableViewController.h"
#import "DislikesTableViewController.h"
#import "List.h"

@interface AddAProductViewController ()
- (IBAction)addAProduct:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *listPicker;
@property Product *productToAdd;
@property List *main;

@end


@implementation AddAProductViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in --an already set login is "test" with password "password"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.main = [List sharedList];
    self.productLabel.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Nav search

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"productSearch"]) {
        //set self as delegate and pass the query from the text field to the search
        ProductSearchTableViewController *controller = segue.destinationViewController;
        
        controller.query = self.productTextField.text;
        // set ourselves as its delegate
        controller.delegate = self;
    }

    
}

- (void)ProductSearchTableViewController:(ProductSearchTableViewController *)controller didFinishAddingItem:(Product *)item
{
    //product was selected on select tableview and will be saved and displayed on add product page

    self.productToAdd = item;
    self.productLabel.text = [NSString stringWithFormat:@"%@ %@", self.productToAdd.brand, self.productToAdd.productName];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Login Delegation

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Sign Up Delegation

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - Picker

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView {
    return 1;
}

-(NSInteger) pickerView :(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger) component {

    return 3; //number of lists
}

-(NSString *) pickerView : (UIPickerView *) pickerView titleForRow:( NSInteger)row forComponent: (NSInteger) component {
    
    NSArray *productLists = [NSArray arrayWithObjects:@"Current Products", @"Favorites", @"Dislikes", nil];
    
    return [productLists objectAtIndex:row];
}

- (IBAction)addAProduct:(id)sender {
    
    int index = [self.listPicker selectedRowInComponent:0];
    PFObject *testObject;
    
    if(index == 0)
    {
        //[self performSegueWithIdentifier:@"toCurrent" sender:self];
        
        //CurrentsTableViewController *dest = (CurrentsTableViewController *) [[(UINavigationController *) [[self.tabBarController viewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0];
        //[dest.currentsList addObject:self.productToAdd];
        
        //add to Parse
        testObject = [PFObject objectWithClassName:@"CurrentProducts"];
        testObject[@"productName"] = self.productToAdd.productName;
        testObject[@"brand"] = self.productToAdd.brand;
        //testObject[@"ingredients"] = self.productToAdd.ingredients;
        [testObject saveInBackground];
        
        //add to in program array (in case want to add to bundle)
        [self.main.currentsList addObject:self.productToAdd];
        
        //move to list that it was added to
        [self.tabBarController setSelectedIndex:1];
    }
    else
    {
        if(index == 1)
        {
            //[self performSegueWithIdentifier:@"toFavorites" sender:self];
            
            //add to Parse
            testObject = [PFObject objectWithClassName:@"FavoriteProducts"];
            testObject[@"productName"] = self.productToAdd.productName;
            testObject[@"brand"] = self.productToAdd.brand;
            //testObject[@"ingredients"] = self.productToAdd.ingredients;
            [testObject saveInBackground];
            
            //add to in program array (in case want to add to bundle)
            [self.main.favoritesList addObject:self.productToAdd];
            
            //move to list it was added to
            [self.tabBarController setSelectedIndex:2];
        }
        else
        {
            //add to Parse
            testObject = [PFObject objectWithClassName:@"DislikedProducts"];
            testObject[@"productName"] = self.productToAdd.productName;
            testObject[@"brand"] = self.productToAdd.brand;
            //testObject[@"ingredients"] = self.productToAdd.ingredients;
            [testObject saveInBackground];
            
            //[self performSegueWithIdentifier:@"toDislikes" sender:self];
            
            //add to in program array (in case want to add to bundle)
            [self.main.dislikesList addObject:self.productToAdd];
            
            //move to list it was added to
            [self.tabBarController setSelectedIndex:3];
        }
    }
    
    
}
@end
