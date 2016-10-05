//
//  Projects.m
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 28/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//

#import "Projects.h"

@implementation ProjectsManager

+(ProjectsManager *)sharedInstance {
    static ProjectsManager *projects = nil;
    static dispatch_once_t oncetoken ;
    dispatch_once(&oncetoken ,^{
        projects = [[self alloc]init];
    });
       return projects;
}

@synthesize dropdownItems , sharedProjectsArray ;

-(id) init {
    if (self = [super init]) {
        sharedProjectsArray = [[NSMutableArray alloc]init];
        dropdownItems = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
