//
//  AddAProductViewController.h
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ProductSearchTableViewController.h"
#import "Product.h"



@interface AddAProductViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, ProductSearchTableDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


@end