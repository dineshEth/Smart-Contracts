// SPDX License Identifier : MIT

pragma solidity >= 0.5.0 < 0.9.0;

// Event organise

contract EventOrganise
{
    uint public nextID;
    struct Event 
    {
        address organiser;
        string name;
        uint256 date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }

    mapping (uint=> Event) public events;
    mapping (address=> mapping (uint => uint )) public tickets;
    function createEvent
    (string memory name,uint256 date ,uint price, uint ticket_count) external
    {
        require(date > block.timestamp , "organise an event on valid date");
        require(ticket_count > 0 , "Introduce valid numbers of ticket or make it accessible for everyone");
        require(price > 0 ,"enter valid price or make it free for everyone");
        events[nextID] = Event(msg.sender, name, date, price, ticket_count,ticket_count);
        nextID++;
    }

    function buyTicket 
    (address buyer,uint id , uint quantity) external payable
    {
        require(events[id].ticketRemain> quantity , "seats are limited and it is housefulled, better try nextime");
        require(msg.value== events[id].price*quantity , "enter a valid amount");
        require(events[id].date > block.timestamp , "Apply for future events");
        Event storage _event = events[id];
        _event.ticketRemain -=quantity;
        tickets[buyer][id] +=quantity;
    }

    function transferTicket 
    (address from, uint id, address to, uint quantity) external 
    {
        require(tickets[from][id]> quantity, "do not have enough tickets");
        require(events[id].date > block.timestamp , "Apply for future events");
    
        tickets[from][id] -=quantity;
        tickets[to][id] +=quantity;
    }
}