//
//  EventDetailHeaderView.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *eventNameHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLocationHeaderLabel;

@end
