// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract TodoList {
    struct TODO {
        string title;
        string time;
        string date;
        bool done;
    }

    TODO[] public todos;
    TODO todo;

    function addTodo(
        string memory _title,
        string memory _time,
        string memory _date
    ) external {
        todo = TODO(_title, _time, _date, false);
        todos.push(todo);
    }

    function updateTodo(uint256 _index, string memory _title) external {
        todos[_index].title = _title;
    }

    function getTodos(uint256 _index) external view returns (TODO memory) {
        return todos[_index];
    }
}
