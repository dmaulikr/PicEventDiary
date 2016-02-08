//
//  Event+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *eventName;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) Album *album;

@end

NS_ASSUME_NONNULL_END
