//
//  Job.h
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 28.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company, Keyword;

@interface Job : NSManagedObject

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * published;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * external_id;
@property (nonatomic, retain) NSNumber * unique;
@property (nonatomic, retain) NSSet *keywords;
@property (nonatomic, retain) Company *company;
@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(Keyword *)value;
- (void)removeKeywordsObject:(Keyword *)value;
- (void)addKeywords:(NSSet *)values;
- (void)removeKeywords:(NSSet *)values;

@end
