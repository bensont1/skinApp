//
//  List.m
//  Skin
//
//  Created by intel on 10/14/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "List.h"

@implementation List

-(id)init
{
    if(self = [super init])
    {
        self.currentsList = [[NSMutableArray alloc]init];
        self.favoritesList = [[NSMutableArray alloc] init];
        self.dislikesList = [[NSMutableArray alloc] init];
        //self.listofLists =[[NSMutableArray alloc] initWithObjects:self.currentsList, self.favoritesList, self.dislikesList, nil];
    }
    return self;
}

static List *theLIST = nil;

+ (List *) sharedList {
    // Initialize our global variable if needed.
    if (theLIST == nil) {
        theLIST = [[ List alloc ] init ];
    }
    return theLIST;
}

@end
