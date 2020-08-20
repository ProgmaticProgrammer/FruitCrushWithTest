import QtQuick 2.0
import QtTest 1.0
import "../FruitCrush/qml/game"

TestCase {
    name: "GameTest"

    GameBlock {
            id: block
          type: 0
           row: 0
        column: 0
    }
    Fruits {
        id: fruits
    }

    SignalSpy {
            id: spy
        target: block
    signalName: "swapFinished"
    }

    function initTestCase() {

    }

    function cleanupTestCase() {
    }

    function test_fruitsTotal() {
        compare(Fruits.FruitType.Total, 5, "Fruit's total type wrong!")
    }

    function test_moveTo() {
        block.moveTo(1, 0)
        spy.wait()
        compare(spy.count, 1)
    }
}
