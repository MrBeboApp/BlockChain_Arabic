pragma solidity >=0.4.22 <0.9.0;

contract Todo{

    uint public taskCount = 0;

    constructor() public{
        createTask("This is fIsrt Task from Constractor");
    }

    //Model Task 
    struct Task{
        uint id;
        string taskContent;
        bool isCompleted;
    }


    event TaskCreated(
        uint id,
        string taskContent,
        bool isCompleted
    );

    event Taskcompleted (
        uint id,
        bool isCompleted
    );
       
    

    mapping(uint=> Task)public tasks;
    //list of tasks
    //create task method

    function createTask(string memory _taskContent)public{
        taskCount++;
        tasks[taskCount]=Task(taskCount,_taskContent,false);
        emit TaskCreated(taskCount, _taskContent, false);

    }  
      //complete task method

      function ToggleTask(uint _id) public{

         Task memory _task = tasks[_id];
         _task.isCompleted =!_task.isCompleted;
         tasks[_id] = _task;

         emit Taskcompleted(_id,_task.isCompleted);


      }

}