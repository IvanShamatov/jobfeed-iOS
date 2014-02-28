//
//  Keyword.h
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 28.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job;

@interface Keyword : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) Job *jobs;

@end
