
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "MilitaryUnit.sol";
import "InterfaceGameObject.sol";

contract Warrior is MilitaryUnit{

constructor(address castle) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
     
        addressMilitaryBase = castle;

        setClass("Воин");
        setDefense(2);
        setDescription("Могучий воин");
        setHp(5);
        setCurHp(5);
        setAttack(2);
    }   

    function setAttackW(uint v) public{
        setAttack(v);
    }
    function setDefenseW(uint v) public{
        setDefense(v);
    }
 
  
    
}
