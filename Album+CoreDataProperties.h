//
//  Album+CoreDataProperties.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Album.h"

NS_ASSUME_NONNULL_BEGIN

@interface Album (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *albumName;
@property (nullable, nonatomic, retain) NSManagedObject *event;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *photo;

@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addPhotoObject:(NSManagedObject *)value;
- (void)removePhotoObject:(NSManagedObject *)value;
- (void)addPhoto:(NSSet<NSManagedObject *> *)values;
- (void)removePhoto:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
