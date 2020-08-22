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
        explorer.rows = 3
        explorer.columns = 3
        field = [
                    [{row: 0, column: 0, type:0}, {row: 0, column: 1, type:1}, {row: 0, column: 2, type:0}],
                    [{row: 1, column: 0, type:1}, {row: 1, column: 1, type:1}, {row: 1, column: 2, type:1}],
                    [{row: 2, column: 0, type:0}, {row: 2, column: 1, type:1}, {row: 2, column: 2, type:0}]]
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

    function test_findConnectedBlocks() {
        var block = field[1][1]
        var result = explorer.findConnectedComponent(field, block)
        compare(result.origin, {x: block.row, y: block.column})
        compare(result.xSpan, [-1, 2])
        compare(result.ySpan, [-1, 2])

        result = explorer.findConnectedComponent(field, {row: 0, column: 0, type: 1})
        compare(result.origin, {x: 0, y: 0})
        compare(result.xSpan, [0, 2])
        compare(result.ySpan, [0, 2])
    }

    function test_nullConnectedBlocks() {
        var block = field[1][1]
        explorer.nullConnectedBlocks(field, block)
        compare(field[block.row][block.column], null)
        compare(field[block.row-1][block.column], null)
        compare(field[block.row][block.column-1], null)
        compare(field[block.row][block.column+1], null)
        compare(field[block.row+1][block.column], null)
    }

    function test_array() {
        var i,j;
        var maintable = new Array(3);
        for(i=0;i<3;i++){
            maintable[i]=new Array(3);
            for(j=0;j<3;j++){
                maintable[i][j]={row: i, column: j, type:0}
            }
        }

        var block = maintable[1][1]
        var result = explorer.findVerticalSpan(maintable, block)
        compare(result, [-1, 2])
    }
}
