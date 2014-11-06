//
//  List.m
//  Skin
//
//  Created by intel on 10/14/14.
//  Copyright (c) 2014 klcrozie. All rights reserved.
//

#import "List.h"


//List holds copy of all lists for use without cloud - populating currents and favorites lists
@implementation List

-(id)init
{
    if(self = [super init])
    {
        self.currentsList = [[NSMutableArray alloc]init];
        self.favoritesList = [[NSMutableArray alloc] init];
        self.dislikesList = [[NSMutableArray alloc] init];
    }
    return self;
}

static List *theLIST = nil;

//THANK THE GODS OF CODE FOR SINGLETONS
+ (List *) sharedList {
    // Initialize our global variable if needed.
    if (theLIST == nil) {
        theLIST = [[ List alloc ] init ];
    }
    return theLIST;
}

@end
