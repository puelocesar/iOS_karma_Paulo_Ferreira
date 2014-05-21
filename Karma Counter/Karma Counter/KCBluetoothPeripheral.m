//
//  KCBluetoothPeripheral.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothPeripheral.h"

@implementation KCBluetoothPeripheral

CBPeripheralManager *peripheralManager;
CBUUID* karma_service_id;
CBMutableCharacteristic *karmaCharacteristic;

-(id)init
{
    karma_service_id = [CBUUID UUIDWithString:UUID_KARMA_SERVICE_STRING];
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    return self;
}

bool already_added_service = false;

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (!already_added_service) {

        //creating the karma characteristic
        CBUUID *characteristicUUID = [CBUUID UUIDWithString:UUID_KARMA_CHARACTERISTIC_STRING];

        karmaCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID
                                                                 properties:CBCharacteristicPropertyWrite
                                                                      value:nil
                                                                permissions:CBAttributePermissionsReadable|CBAttributePermissionsWriteable];

        //creating the characteristic that informs the name of the user
        characteristicUUID = [CBUUID UUIDWithString:UUID_NAME_CHARACTERISTIC_STRING];
        CBMutableCharacteristic *nameCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID
                                                                properties:CBCharacteristicPropertyRead
                                                                     value:[self.nickname dataUsingEncoding:NSUTF8StringEncoding]
                                                               permissions:CBAttributePermissionsReadable];

        //publishing the service
        CBMutableService *myService = [[CBMutableService alloc] initWithType:karma_service_id primary:YES];
        myService.characteristics = @[karmaCharacteristic, nameCharacteristic];
        [peripheral addService:myService];
        
        already_added_service = true;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error {

    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    [peripheral startAdvertising:@{CBAdvertisementDataServiceUUIDsKey: @[karma_service_id],
            CBAdvertisementDataLocalNameKey: idfv}];
    
    if (error) {
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {
    
    NSLog(@"is advertising");

    if (error) {
        NSLog(@"Error advertising: %@", [error localizedDescription]);
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests {
    
    for (CBATTRequest *request in requests) {
        if ([request.characteristic.UUID isEqual:karmaCharacteristic.UUID]) {
            [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
            [self.delegate didReceiveKarma];
        }
    }
}

@end
