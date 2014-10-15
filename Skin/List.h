//
//  List.h
//  Skin
//
//  Created by intel on 10/14/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject

//@property NSMutableArray *listofLists;

@property NSMutableArray *currentsList;
@property NSMutableArray *favoritesList;
@property NSMutableArray *dislikesList;

+ (List *) sharedList;

@end
