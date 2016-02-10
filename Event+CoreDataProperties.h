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
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *eventName;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSOrderedSet<Comment *> *commentEvent;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

- (void)insertObject:(Comment *)value inCommentEventAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentEventAtIndex:(NSUInteger)idx;
- (void)insertCommentEvent:(NSArray<Comment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentEventAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentEventAtIndex:(NSUInteger)idx withObject:(Comment *)value;
- (void)replaceCommentEventAtIndexes:(NSIndexSet *)indexes withCommentEvent:(NSArray<Comment *> *)values;
- (void)addCommentEventObject:(Comment *)value;
- (void)removeCommentEventObject:(Comment *)value;
- (void)addCommentEvent:(NSOrderedSet<Comment *> *)values;
- (void)removeCommentEvent:(NSOrderedSet<Comment *> *)values;

@end

NS_ASSUME_NONNULL_END
