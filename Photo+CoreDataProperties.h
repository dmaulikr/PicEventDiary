//
//  Photo+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"
#import "Comment.h"
#import "Event.h"
#import "User.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) UIImage *image;
@property (nullable, nonatomic, retain) NSString *imageName;
@property (nonatomic) int32_t likeCount;
@property (nullable, nonatomic, retain) NSOrderedSet<Comment *> *commentPhoto;
@property (nullable, nonatomic, retain) Event *event;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)insertObject:(Comment *)value inCommentPhotoAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentPhotoAtIndex:(NSUInteger)idx;
- (void)insertCommentPhoto:(NSArray<Comment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentPhotoAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentPhotoAtIndex:(NSUInteger)idx withObject:(Comment *)value;
- (void)replaceCommentPhotoAtIndexes:(NSIndexSet *)indexes withCommentPhoto:(NSArray<Comment *> *)values;
- (void)addCommentPhotoObject:(Comment *)value;
- (void)removeCommentPhotoObject:(Comment *)value;
- (void)addCommentPhoto:(NSOrderedSet<Comment *> *)values;
- (void)removeCommentPhoto:(NSOrderedSet<Comment *> *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
