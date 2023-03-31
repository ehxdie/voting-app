// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
   // In order to keep record of voters
   using Counters for Counters.Counter;
   Counters.Counter public voterID;


   // Candidate information
   struct Candidate {
      uint256 candidateID;
      string age;
      string name;
      uint256 votecount;
      address _address;
   }  
   
 
}
