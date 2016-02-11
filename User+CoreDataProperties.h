//
//  User+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Event.h"
#import "Photo.h"
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *username;
@property (nonatomic) BOOL signedIn;
@property (nullable, nonatomic, retain) NSSet<Event *> *eventuser;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photouser;
@property (nullable, nonatomic, retain) NSSet<Comment *> *commentuser;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addEventuserObject:(Event *)value;
- (void)removeEventuserObject:(Event *)value;
- (void)addEventuser:(NSSet<Event *> *)values;
- (void)removeEventuser:(NSSet<Event *> *)values;

- (void)addPhotouserObject:(Photo *)value;
- (void)removePhotouserObject:(Photo *)value;
- (void)addPhotouser:(NSSet<Photo *> *)values;
- (void)removePhotouser:(NSSet<Photo *> *)values;

- (void)addCommentuserObject:(Comment *)value;
- (void)removeCommentuserObject:(Comment *)value;
- (void)addCommentuser:(NSSet<Comment *> *)values;
- (void)removeCommentuser:(NSSet<Comment *> *)values;

@end

NS_ASSUME_NONNULL_END
