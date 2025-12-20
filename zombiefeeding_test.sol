pragma solidity >=0.5.0 <0.6.0;    //solidity version 

import "./zombie_test.sol";    //import other file

contract KittyInterface {    //its an interface, its like a PLAN, tells us what other contract has, type of communication
    function getKitty(uint256 _id) external view returns (    //f() named getKiity that call kitty of certain Id, can be read only by exterior contracts, and only for view
        bool isGestating,    //bool = true or false, Is kitty gestating?
        bool isReady,     //bool = is kitty ready? 
        uint256 cooldownIndex,    //long number named cooldownIndex
        uint256 nextActionAt,    // 
        uint256 siringWithId, 
        uint256 birthTime, 
        uint256 matronId, 
        uint256 sireId, 
        uint256 generation, 
        uint256 genes, 
    );
}

contract ZombieFeeding is ZombieFactory {

address ckAddress = //write a made up address key ;
KittyInterface kittyContract = KittyInterface(ckAddress); 

function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus; 
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99; 
        }
        _createZombie("NoName", newDna); 
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint KittyDna; 
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty"); 
    }

} 
