pragma solidity ^0.5.16;

contract Voting{

    struct Candidate {
        uint id;
        string name;
    }

     address public Creator;

     bool public votingEnded;

     mapping (address => bool) public hasVoted;

     uint256 public totalVotes;

     mapping(uint => Candidate) public candidates;

    mapping (uint256 => uint256) private votesReceived;

     uint public candidatesCount;

     constructor() public {
        Creator = msg.sender;

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "Narendra Modi");

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "Rahul Gandhi");

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "Mamata Banerjee");

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "Yogi Adityanath");

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "Raj Thackeray");

        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, "NOTA");
    }

    function voteForCandidate(uint _candidate) public {
        
        require(!votingEnded);
        
        require(_candidate > 0 && _candidate <= candidatesCount);
        
        require(!hasVoted[msg.sender]);

        votesReceived[_candidate] += 1;
        hasVoted[msg.sender] = true;
        totalVotes += 1;
    }

    function endVoting() public returns (bool) {
        require(msg.sender == Creator);  
        require(!votingEnded);
        votingEnded = true;
        return true;
    }

    function totalVotesFor(uint _candidate) view public returns (uint256) {
        require(votingEnded);  
        return votesReceived[_candidate];
    }
}
