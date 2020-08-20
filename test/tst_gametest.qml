import QtQuick 2.0
import QtTest 1.0
import "../FruitCrush/qml/game"

TestCase {
    name: "BlockTest"

    GameBlock {
        id: block
        width: 10
        height: 10

    }

    SignalSpy {
        id: spyOnBlock
        target: block
        signalName: "swapFinished"
    }

    SignalSpy {
        id: spyOnFalldown
        target: block
        signalName: "falldownFinished"
    }

    SignalSpy {
        id: spy
        target: gameLogic
        signalName: "fadedout"
    }

    GameLogic {
        id: gameLogic
    }

    function init() {
        block.x = 0
        block.y = 0
        block.type = 0
        block.row = 0
        block.column = 0
    }

    function initTestCase() {

    }

    function cleanupTestCase() {
    }

    function test_moveTo() {
        verify(spyOnBlock.count==0, "pending signal found.")

        block.moveTo(1, 0)
        spyOnBlock.wait()

        compare(spyOnBlock.count, 1)
        let args = spyOnBlock.signalArguments[0]
        compare(args[0], 0)// previous row and column
        compare(args[1], 0)
        compare(args[2], 1)// new row and column
        compare(args[3], 0)
    }

    function test_fadeOut() {
        verify(spy.count==0, "pending signal found.")

        block.fadeOut()
        spy.wait()

        compare(spy.count, 1)
        //        compare(spy.signalArguments[0], block.entityId)
    }

    function test_fallDown() {

        let y = block.y
        let distance = 2

        block.fallDown(distance)
        spyOnFalldown.wait()
        compare(block.y, y+block.height*distance)

    }
}
