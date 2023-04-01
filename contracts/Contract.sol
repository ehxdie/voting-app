// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
    
   constructor (){
      votingOrganizer = msg.sender;
   }

    // In order to keep record of voters and candidates
    using Counters for Counters.Counter;
    Counters.Counter public voterID;
    Counters.Counter public candidateID;

    // Candidate information
    struct Candidate {
        uint256 candidateID;
        string age;
        string name;
        uint256 votecount;
        address _address;
    }

   /* CREATING THE CANDIDATES */
    Candidate public Candidate1 = Candidate({
      uint256 candidateID : int 1;
      string age: int 50;
      string name: String "James";
      uint256 votecount = int 0;
      address _address;
    })

    Candidate public Candidate2 = Candidate({
      uint256 candidateID : int 2;
      string age: int 63;
      string name: String "";
      uint256 votecount = int 0;
      address _address;
    })

    // Creating an address array with all the addresses of each candidate
    address[] public candidateAddress;

    // Mapping the candidate address with candidate info
    mapping(address => Candidate) public candidate;

    /*VOTERS BLOCK*/

    // Voters information
    struct Voter {
        uint256 voterID;
        address voter_address;
        bool voted;

    }

   // Creating an address array with all the addresses of each voter
    address[] public votersaddress;
   // Mapping the candidate address with candidate info
    mapping(address => Voter) public voters;

    function setCandidate

}
