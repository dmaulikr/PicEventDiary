//
//  Event+CoreDataProperties.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event+CoreDataProperties.h"

@implementation Event (CoreDataProperties)

@dynamic date;
@dynamic eventName;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic locationName;
@dynamic locationURL;
@dynamic commentEvent;
@dynamic photos;
@dynamic user;

@end
