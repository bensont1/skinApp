//
//  Product.m
//  Skin
//
//  Created by intel on 10/4/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithJSONDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.brand = dict[@"brand"];
        self.productName = dict[@"product_name"];
        self.ingredients = dict[@"ingredients"];
        
        NSArray *images = dict[@"image_urls"];
        self.thumbnailURL = images[0];
    }
    return self;
}

@end
