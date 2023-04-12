pragma solidity ^0.4.18;


contract Owned {
    address owner;
   
    function Owned() public {
        owner = msg.sender;
    }
   
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}


contract AttendanceSheet is Owned {
   
    struct Student {
        uint256 age;
        string subject;
        string fName;
        string lName;
        string date;
        uint256 attendanceValue;
    }
   
    mapping (uint256 => Student) studentList;
    uint256[] public studIdList;
   
    event studentCreationEvent(
       string subject,
       string fName,
       string lName,
       uint256 age,
       string date
    );


   
    function createStudent(uint256 _studId, uint256 _age, string _subject,string _fName, string _lName, string _Date) onlyOwner public {
        var student = studentList[_studId];
        student.subject = _subject;
        student.age = _age;
        student.fName = _fName;
        student.lName = _lName;
        student.date = _Date;
        student.attendanceValue = 0;
        studIdList.push(_studId) -1;
        studentCreationEvent(_subject,_fName, _lName, _age,_Date);
    }
   
    function incrementAttendance(uint256 _studId) onlyOwner public {
        studentList[_studId].attendanceValue = studentList[_studId].attendanceValue+1;
    }
   
      function decrementAttendance(uint256 _studId) onlyOwner public {
        studentList[_studId].attendanceValue = studentList[_studId].attendanceValue-1;
    }




    function getStudents() view public returns(uint256[]) {
        return studIdList;
    }
   




    function getParticularStudent(uint256 _studId) public view returns (string,string, string, uint256, uint256,string) {
        return (studentList[_studId].subject,studentList[_studId].fName, studentList[_studId].lName, studentList[_studId].age, studentList[_studId].attendanceValue,studentList[_studId].date);
 
    }


   
    function countStudents() view public returns (uint256) {
        return studIdList.length;
    }
   
}