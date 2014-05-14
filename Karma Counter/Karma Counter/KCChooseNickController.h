//
//  KCChooseNickController.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import <UIKit/UIKit.h>
#import "KCViewController.h"

@interface KCChooseNickController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nick_field;

@end
