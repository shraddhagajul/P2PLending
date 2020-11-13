pragma solidity >0.4.0 <=0.7.0;
contract BankTransaction{
    // Store Loan Satte
    enum LoanState {
        ACCEPTING,
        LOCKED,
        SUCCESSFUL,
        FAILED
    }
    // Structure of Loan info against a borrower
    struct Loan{
        address borrower;
        LoanState state;
        uint dueDate;
        uint amount;
        uint proposalCount;
        uint collected;
        uint startDate;
        bytes32 mortgage;
        // mapping (uint=>uint) proposal;
    }
    //loanList-Flat structure of Loan to store data of multiple borrowers
    Loan[] public loanList;

    mapping(address=>uint) loanMap;
    constructor(){

    }

    //newLoan - checks if borrower has existenting loan, 
    // if not then adds him in Loan List(which will be displayed to Bank
   function newLoan(uint amount ,uint duedate, bytes32 mortgage)  public{
       // check if borower has existing loan
       if(hasActiveLoan(msg.sender)) return;
       uint currentDate = block.timestamp;
    //    loanList.push(Loan(msg.sender, LoanState.ACCEPTING, duedate, amount, 0, 0, currentDate, mortgage));
       loanList.push(Loan(msg.sender, LoanState.ACCEPTING, duedate, amount, 0, 0, currentDate, mortgage));
    // set flag = 1 if sender has taken loan
       loanMap[msg.sender]=1;

   } 

    //hasActiveLoan- checks if borrower has existing loans
    function hasActiveLoan(address borrower) view public returns (bool){
        uint validLoans = loanMap[borrower];
        if (validLoans == 0 ) return false;

    }

    // Oracles are services that send and verify real world occurrences 
    // and submit this information to smart contracts, triggering state changes on the blockchain
    function generateLoanId(address borrower) public returns (uint8){
        if(hasActiveLoan(borrower)) return 0;

        // return uint(keccak256(abi.encodePacked(now, msg.sender, nonce))) % 100;
    }

    function getActiveLoanId(address borrower) view public returns (uint){

    }


}
