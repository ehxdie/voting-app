// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
   // In order to keep record of voters and candidates 
    using Counters for Counters.Counter;
    Counters.Counter public voterID;
    Counters.Counter public candidateid;
  
   address public  votingOrganizer;

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

    // Storing candidate information in the blockchain
    event CandidateCreate (
       uint256 indexed candidateID,
       string age,
       string name,
       uint256 votecount,
       address _address

    );

   /* CANDIDATES BLOCK */
   // Here the an array is created to hold candidates address
    address[] public candidateAddress;

    mapping(address => Candidate) public candidates;

   function setCandidate (address _address, string memory _age, string memory _name) public
    {
      // This checks if the address executing this function is the organizers address
      require(votingOrganizer == msg.sender, "Only the organizer can execute this function");
      
      // Anytime a candidate is created the id is incremented and assigned to that candidates id
      candidateid.increment();

      uint256 idNumber = candidateid.current();

      Candidate storage candidate = candidates[_address];

      candidate.age = _age;
      candidate.name = _name;
      candidate.candidateID = idNumber;

      // Pushing all the candidates addresses to the candidate address array
      candidateAddress.push(_address);

     // Emitting the candidates information to the blockchain
      emit CandidateCreate (
         idNumber,
         _age,
         _name,
         candidate.votecount,
         _address ) ;
     } 

   // This returns the candidates address
   function getCandidate() public view returns (address[] memory) {
      return candidateAddress;
   }

   // This the number of candidates in the contest
   function getCandidateLength() public view returns (uint256) {
      return candidateAddress.length;
   }

   // Returns the data from a candidate 
   function getCandidatedata( address _address) public view returns ( string memory, string memory, uint256 , uint256, address) {
      return (
         candidates[_address].age,
         candidates[_address].name,
         candidates[_address].candidateID,
         candidates[_address].votecount,
         candidates[_address]._address
      );
   }  



    /*VOTERS BLOCK*/

 

   // Voters information 
    struct Voter {
        uint256 voter_voterID;
        address voter_address;
        bool voter_voted;
        uint256 voter_allowed;
        uint voter_vote;
    }

   // This is used to save data that would be sent straight to the blockchain and would not be need to be retrieved again
   event VoterCreated (
      uint256 indexed voter_voterID,
      address voter_address,
      bool voter_voted,
      uint256 voter_allowed,
      uint voter_vote

   );

   // Creating an address array for voters that have voted
   address[] public votedVoters;

   // Creating an address array with all the addresses of each voter
    address[] public votersAddress;
  
   // Mapping the voter address with voter info (would be used to set the voters information)
    mapping(address => Voter) public voters;
   
   // Function that gets voter details and creates voters
   function voterInfo( address _address, string memory _name) public
   {
      //Important // Checking if the person executing the smart contract is the voting organizer
      require( votingOrganizer == msg.sender, "Only Organizer can create voter");

      // Increments the voter id each time the function is executed
      voterID.increment();
      // Sets the idnumber variable to whatever the current idnumber is (number of times function has been called)
      uint256 idNumber = voterID.current();

      // Creating a copy of Voter structure
      Voter storage voter = voters[_address];

      //Important // Second check ensuring voter has not already voted 
      require(voter.voter_allowed == 0);

      // Creating the voters and storing their information on the voter str
      voter.voter_voterID = idNumber;
      voter.voter_address = _address;
      voter.voter_voted = false;
      voter.voter_allowed = 1;
      voter.voter_vote = 1000; 

      // pushing collected voters address to voteraddress array
      votersAddress.push(_address);

      //emiting collated voter data 
      emit VoterCreated (
      idNumber,
      _address,
      voter.voter_voted,
      voter.voter_allowed,
      voter.voter_vote
      );

     }

   // Function that actually does the voting process 
   function vote (address _candidateAddress, uint256 _candidateVoteId) external {
     // Creates a copy of the voter structure and grabs the address that executed the function
      Voter storage voter = voters[msg.sender];

    /*Checks*/
    // Checking if the voter had already voted
      require (!voter.voter_voted, "You have already voted");
      require(voter.voter_allowed !=0, "You have no right");

      voter.voter_voted = true;
      voter.voter_vote = _candidateVoteId;

      // saving the address of the voter who called this function to vote in a voted address array
      votedVoters.push(msg.sender);

      // Adding to the candidates vote count
      candidates[_candidateAddress].votecount += voter.voter_allowed;
       
   }

   // Function that returns the number of all the voters
   function getVoterLength() public view returns (uint256){
      return votersAddress.length;
   }

   // Function that returns the number of voters that have actually voted
   function getvotedVoterLength() public view returns (uint256){
      return votedVoters.length;
   }

  
}

