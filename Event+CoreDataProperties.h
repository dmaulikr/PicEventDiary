//
//  Event+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"
#import "Comment.h"
#import "Photo.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *eventName;
@property (nonatomic) float locationLatitude;
@property (nonatomic) float locationLongitude;
@property (nullable, nonatomic, retain) NSString *locationName;
@property (nullable, nonatomic, retain) NSString *locationURL;
@property (nullable, nonatomic, retain) NSOrderedSet<Comment *> *commentEvent;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Event (CoreDataGeneratedAccessors)

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

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
