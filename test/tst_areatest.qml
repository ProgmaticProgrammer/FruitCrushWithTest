import QtQuick 2.0
import QtTest 1.0
import "../FruitCrush/qml/game"

TestCase {
    id: root
    name: "AreaTest"

    property var field

    BlockExplorer {
        id: explorer
    }

    function init() {
        field = [
                [{row: 0, column: 0, type:0}, {row: 0, column: 1, type:1}, {row: 0, column: 2, type:0}],
                [{row: 1, column: 0, type:1}, {row: 1, column: 1, type:1}, {row: 1, column: 2, type:1}],
                [{row: 2, column: 0, type:0}, {row: 2, column: 1, type:1}, {row: 2, column: 2, type:0}]]
        explorer.rows = 3
        explorer.columns = 3
    }

    function cleanup() {}

    function initTestCase() {}

    function cleanupTestCase() {}

    function test_findHorizontalBlocks() {
        var block = field[1][0]
        var result = explorer.findHorizontalSpan(field, block)
        compare(result, [0, 3])

        block = field[1][1]
        result = explorer.findHorizontalSpan(field, block)
        compare(result, [-1, 2])

        block = field[1][2]
        result = explorer.findHorizontalSpan(field, block)
        compare(result, [-2, 1])

        block = field[0][0]
        result = explorer.findHorizontalSpan(field, block)
        compare(result, [0, 1])

        result = explorer.findHorizontalSpan(field, {row: 0, column: 0, type: 1})
        compare(result, [0, 2])

        block = field[0][1]
        result = explorer.findHorizontalSpan(field, block)
        compare(result, [0, 1])

    }

    function test_findVerticalBlocks() {
        var block = field[1][1]
        var result = explorer.findVerticalSpan(field, block)
        compare(result, [-1, 2])

        block = field[0][1]
        result = explorer.findVerticalSpan(field, block)
        compare(result, [0, 3])

        block = field[2][1]
        result = explorer.findVerticalSpan(field, block)
        compare(result, [-2, 1])
    }
}
