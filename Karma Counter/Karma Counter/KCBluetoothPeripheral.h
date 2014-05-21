//
//  KCBluetoothPeripheral.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol KCBluetoothPeripheralDelegate <NSObject>
- (void)didReceiveKarma;
@end

@interface KCBluetoothPeripheral : NSObject <CBPeripheralManagerDelegate>

#define UUID_KARMA_SERVICE_STRING @"11C1226B-281D-4666-8798-A7F7A54972BF"

#define UUID_KARMA_CHARACTERISTIC_STRING @"F711ECAD-C397-426B-A28B-3B068AD7D10C"
#define UUID_NAME_CHARACTERISTIC_STRING @"5E9D69A0-9BB4-4591-A62A-CBCE1C57CA13"

@property (nonatomic, weak) id <KCBluetoothPeripheralDelegate> delegate;
@property (nonatomic, strong) NSString *nickname;

@end
