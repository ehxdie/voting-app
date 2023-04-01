// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
   address votingOrganizer

   constructor (){
      votingOrganizer = msg.sender;
   }

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


    /*VOTERS BLOCK*/

   // In order to keep record of voters 
    using Counters for Counters.Counter;
    Counters.Counter public voterID;
  

   // Voters information
    struct Voter {
        uint256 voterID;
        address voter_address;
        bool voted;
        uint256 voter_allowed;
    }

   // Creating an address array with all the addresses of each voter
    address[] public votersAddress;
  
   // Mapping the voter address with voter info
    mapping(address => Voter) public voters;
   
   // Function that gets voter details and creates voters
   function voterInfo( Unit memory _voterID address _voterAddress bool memory _voted) public
   {
      //Important // Checking if the person executing the smart contract is the voting organizer
      require( votingOrganizer == msg.sender, "Only Organizer can create voter");

      // Increments the voter id each time the function is executed
      _voterID.increment();
      // Sets the idnumber variable to whatever the current idnumber is (number of times function has been called)
      uint256 idNumber = _voterID.current();

      // Creating a copy of Voter structure
      Voter storage voter = voters[_voterAddress];

      //Important // Second check ensuring voter has not already voted 
      require(voter.voter_allowed === 0);

      voter.voter_allowed = 1;
      voter.voterID = _voterID;
      voter.voter_address = _voterAddress;
      voter.voted = _voted;

      // pushing collected voters address to voteraddress array
      votersAddress.push(_voterAddress);

      //emiting collated voter data 
      emit VoterCreated (
      _voterID,
      _voterAddress,
      _voted,
      voter.voter_allowed
      )

   }

   // Act 

}
