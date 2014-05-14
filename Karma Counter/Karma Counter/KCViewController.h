//
//  KCViewController.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import <UIKit/UIKit.h>
#import "KCChooseNickController.h"

@interface KCViewController : UIViewController <KCChooseNickControllerDelegate>

@property (strong, nonatomic) NSString* nickname;

@property (weak, nonatomic) IBOutlet UILabel *nickname_label;
@property (weak, nonatomic) IBOutlet UILabel *karma_value;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end
