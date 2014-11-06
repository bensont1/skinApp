//
//  ProductSearchTableViewController.h
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@class ProductSearchTableViewController;

@protocol ProductSearchTableDelegate <NSObject>
//passing back selected product
- (void)ProductSearchTableViewController:(ProductSearchTableViewController *)controller didFinishAddingItem:(Product *)item;

@end


@interface ProductSearchTableViewController : UITableViewController

@property NSString *query;


@property (weak, nonatomic) id<ProductSearchTableDelegate> delegate;

@end
