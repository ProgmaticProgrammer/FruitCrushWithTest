import QtQuick 2.0
import QtTest 1.0
import "../FruitCrush/qml/game"

TestCase {
    id: root
    name: "BlockTest"

    GameBlock {
        id: block
        width: 10
        height: 10
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

    function cleanup() {}

    function initTestCase() {}

    function cleanupTestCase() {}

    function test_moveTo() {
        var spy = Qt.createQmlObject("import QtTest 1.0;
                                        SignalSpy {
                                            target: block;
                                        signalName: 'swapFinished'}", root, "dynamicItem");
        verify(spy.count===0, "pending signal found.")

        block.moveTo(1, 0)
        spy.wait()

        compare(spy.count, 1)
        let args = spy.signalArguments[0]
        compare(args[0], 0)// previous row and column
        compare(args[1], 0)
        compare(args[2], 1)// new row and column
        compare(args[3], 0)
        spy.destroy();
    }

    function test_fadeOut() {
        var spy = Qt.createQmlObject("import QtTest 1.0;
                                        SignalSpy {
                                            target: gameLogic;
                                        signalName: 'fadedout'}", root, "dynamicItem");
        verify(spy.count===0, "pending signal found.")

        block.fadeOut()
        spy.wait()

        compare(spy.count, 1)
        //        compare(spy.signalArguments[0], block.entityId)
        spy.destroy();
    }

    function test_fallDown() {
        var spy = Qt.createQmlObject("import QtTest 1.0;
                                        SignalSpy {
                                            target: block;
                                        signalName: 'falldownFinished'}", root, "dynamicItem");
        let y = block.y
        let distance = 2

        block.fallDown(distance)
        spy.wait()
        compare(block.y, y+block.height*distance)
        spy.destroy();
    }
}
