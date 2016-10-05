//
//  Projects.h
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 28/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectsManager : NSObject {
    NSMutableArray *dropdownItems;
    NSMutableArray *sharedProjectsArray;
}

@property (nonatomic,retain) NSMutableArray *dropdownItems;
@property (nonatomic,retain) NSMutableArray *sharedProjectsArray;

+(ProjectsManager *) sharedInstance ;

@end
