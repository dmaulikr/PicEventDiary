//
//  Comment+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comment.h"
#import "Event.h"
#import "Photo.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comment;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSOrderedSet<Event *> *events;
@property (nullable, nonatomic, retain) NSOrderedSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Comment (CoreDataGeneratedAccessors)

- (void)insertObject:(Event *)value inEventsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEventsAtIndex:(NSUInteger)idx;
- (void)insertEvents:(NSArray<Event *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEventsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEventsAtIndex:(NSUInteger)idx withObject:(Event *)value;
- (void)replaceEventsAtIndexes:(NSIndexSet *)indexes withEvents:(NSArray<Event *> *)values;
- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSOrderedSet<Event *> *)values;
- (void)removeEvents:(NSOrderedSet<Event *> *)values;

- (void)insertObject:(Photo *)value inPhotosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPhotosAtIndex:(NSUInteger)idx;
- (void)insertPhotos:(NSArray<Photo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePhotosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPhotosAtIndex:(NSUInteger)idx withObject:(Photo *)value;
- (void)replacePhotosAtIndexes:(NSIndexSet *)indexes withPhotos:(NSArray<Photo *> *)values;
- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSOrderedSet<Photo *> *)values;
- (void)removePhotos:(NSOrderedSet<Photo *> *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
