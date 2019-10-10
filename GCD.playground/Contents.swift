import Foundation

private class Concurrency {

    let mainQueue = DispatchQueue.main
    let backgroundQueue = DispatchQueue(label: "com.app.backgroundQueue", qos: .background)

    func getDeadlockWithTwoQueues() {
        mainQueue.async {
            print("This print will be executed synchronously")
            mainQueue.sync {
                print("This print should also be executed synchronously and on the same queue")
            }
        }
    }

    func getCancelToDispatchWorkItem() {

        var dispatchItem: DispatchWorkItem!

        dispatchItem = DispatchWorkItem(block: {
            while true {
                if dispatchItem.isCancelled { break }
                print("0")
            }
            dispatchItem = nil
        })

        mainQueue.async(execute: dispatchItem)
        backgroundQueue.asyncAfter(deadline: .now() + 2) {
                        dispatchItem.cancel()
            print("Exit operation")
        }
    }
}

let concurrency = Concurrency()
//concurrency.getDeadlockWithTwoQueues()
//concurrency.getCancelToDispatchWorkItem()
