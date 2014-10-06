//
//  AddAProductViewController.h
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAProductViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

//@property NSObject *productToAddasObj;
-(void)createSelectedProduct:(NSString *) brand productName:(NSString *)productName ingredients:(NSArray *)ingredients thumbnailURL:(NSString *)thumbnailURL;

@end