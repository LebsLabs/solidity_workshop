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

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; 
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}



