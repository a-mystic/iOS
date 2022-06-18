//
//  main.swift
//  Error Handling
//
//  Created by mystic on 2022/06/18.
//

import Foundation

let connectionOK = true
let connectionSpeed = 30.00
let fileFound = false

enum FileTransferError: Error {
    case noConnection
    case lowBandwidth
    case fileNotfound
}

func fileTransfer() throws {
    if !connectionOK{
        throw FileTransferError.noConnection
    }
    if connectionSpeed > 30{} else{
        throw FileTransferError.lowBandwidth
    }
    guard fileFound else {
        throw FileTransferError.fileNotfound
    }
}

func sendFile() -> String {
    do{
        try fileTransfer()
    } catch FileTransferError.noConnection{
        return "No Network Connection"
    } catch FileTransferError.lowBandwidth{
        return "File Transfer Speed too Low"
    } catch FileTransferError.fileNotfound{
        return "File not found"
    } catch let error {
            return error.localizedDescription
    }
    return "Successful transfer"
}

let sendresult = sendFile()
print(sendFile())

