//
//  Product.h
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property NSString *brand;
@property NSString *productName;
@property NSArray *ingredients;
@property NSString *thumbnailURL;

-(id)initWithJSONDictionary:(NSDictionary *)dict;

@end
