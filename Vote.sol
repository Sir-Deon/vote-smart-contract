//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote {
    // Stuct which defines the properties of a nominee
    struct Nominee {
        string name;
        uint256 age;
        bool adult;
        uint256 votes;
    }
    address owner; // Is the deployer of this smart contract
    mapping(string => Nominee) public Nominees; // Stores the Nominees
    mapping(address => bool) voters; // Stores the voters

    Nominee[] nominees;

    uint256 public winningVote; // The amount of votes needed to win

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not allowed !!");
        _;
    }

    modifier voted() {
        require(voters[msg.sender] != true, "Already Voted !!");
        _;
    }

    Nominee person; // Instanciating a nominee instance

    function nominate(string memory _name, uint256 _age) public {
        require(_age >= 18, "Not Qualified");
        require(
            keccak256(abi.encodePacked((Nominees[_name].name))) !=
                keccak256(abi.encodePacked((_name))),
            "Already Nominated !!"
        );
        person = Nominee(_name, _age, true, 0);
        Nominees[_name] = person;
        nominees.push(person);
    }

    function vote(string memory _name) public voted {
        Nominees[_name].votes += 1;
        voters[msg.sender] = true;
    }

    function selectWinner()
        public
        view
        onlyOwner
        returns (string memory _name)
    {
        for (uint256 i = 0; i <= nominees.length; i++) {
            if (nominees[i].votes >= winningVote) {
                _name = nominees[i].name;
                break;
            }
        }
        return _name;
    }

    function setWinningVote(uint256 _value) public onlyOwner returns (uint256) {
        winningVote = _value;
        return winningVote;
    }
}
