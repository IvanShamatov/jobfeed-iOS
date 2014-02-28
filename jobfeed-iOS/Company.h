//
//  Company.h
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 28.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSSet *jobs;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addJobsObject:(Job *)value;
- (void)removeJobsObject:(Job *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

@end
