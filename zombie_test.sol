pragma solidity >=0.5.0 <0.6.0; //version of pragma

contract ZombieFactory { //program

    event NewZombie(uint zombieId, string name, uint dna); //call the program to run

    uint dnaDigits = 16;    //the number will have 16 digits 
    uint dnaModulus = 10 ** dnaDigits; //making sure that the number has 16 digits

    struct Zombie {    //label map Zombie 
        string name;    //string = word
        uint dna;       //uint = number, variable
    }

    Zombie[] public zombies; //indexing zombies

    mapping (uint => address) public zombieToOwner; //mapping numbers to addresses
    mapping (address => uint) ownerZombieCount;    //mapping addresses to numbers

    function _createZombie(string memory _name, uint _dna) private {    //a function named createZombie that receives _name and _dna and is private so only this contract can call it 
        uint id = zombies.push(Zombie(_name, _dna)) - 1;    //field of zombie structures that creates a new zombie with _name and _dna and if the new lenght of array becomes 1 the index of the new zombie will be always 0    
        zombieToOwner[id] = msg.sender; //the key-value pair zombieToOwner saves the ownership of id to the msg.sender
        ownerZombieCount[msg.sender]++;    //adds the plus 1 zombie to the sender who owns the zombies
        emit NewZombie(id, _name, _dna);    //send the this information on blockchain... where is readable to others eg. web3.js
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {    //this f(x) does change zero on blockchain, only readable within the contract, the name that user types 
        uint rand = uint(keccak256(abi.encodePacked(_str)));    //variable rand stores variable of a big number that converts the result of calculation of SHA-3 (256-bits number or 32 bytes), abi. ...
        return rand % dnaModulus;    //% operation for modul, dnaModulus is defined at the beginning of the contract, so the function returns variable rand limited to dnaModulus number of digits
    }

    function createRandomZombie(string memory _name) public {    //f(craeteRandomZombie) when user types name and f() is readable to anyone with eth address
        require(ownerZombieCount[msg.sender] == 0);      //condition that the messagesender owns zero zombies
        uint randDna = _generateRandomDna(_name);    //calls the f(generateRandomDna and based on the name calculate the dna number and stores it in randDna
        _createZombie(_name, randDna);    //calls the second f() that adds the new zombie and set the ownership and rise the number of zombies of the user and starts the event
    }

}






