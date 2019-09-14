pragma solidity 0.5.11;

contract Voting {

    mapping (string => uint8) public votesReceived;

    string public candidateList;

    function Voting(string [] candidateNames) {
        candidateList = candidateNames;
    }

    function totalVotes(string candidate) returns (uint8) {
        return votesReceived[candidate]
    }

    function voteFor(string candidate) {
        if(validCandidate(candidate) == false)
            throw;
        
        votesReceived[candidate] += 1;
    }

    function validcandidate(string candidate) returns (bool) {
        for (uint i = 0; i<candidateList.length; i++) {
            if (candidateList[i] == candidate)
                return true;
        }
        return false;
    }
}