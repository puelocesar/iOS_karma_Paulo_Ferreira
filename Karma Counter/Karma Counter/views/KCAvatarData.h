//
//  KCAvatarData.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface KCAvatarData : NSObject

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) CBPeripheral* peripheral;

@end