//
//  Event+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *eventName;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
