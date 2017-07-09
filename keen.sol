pragma solidity ^0.4.10;

contract EducoinIco {
 mapping (address => uint) tokensOf;
}

contract EducoinContract {

  struct Lesson {
    uint uid;
    address teacher;
    address student;
    uint price;
    string description;
    uint rating;
    bool accepted;
  }

  mapping (uint => Lesson) lessons;
  uint counter = 0;

  function createLesson(uint _price, string desc){
    Lesson lesson = lessons[counter];
    lesson.price = _price;
    lesson.teacher = msg.sender;
    lesson.description = desc;

    counter++;
  }

  //a student books a lesson
  function bookLesson(uint _uid) payable {

    Lesson lesson = lessons[_uid];
    if(msg.value == lesson.price){
        lesson.student = msg.sender;
        lesson.accepted = false;
    }
    else{
        throw;
    }

  }

  //teacher accepts lesson
  function acceptLesson(uint _uid) {
    if (lessons[_uid].teacher == msg.sender) {
      lessons[_uid].accepted = true;
      lessons[_uid].teacher = msg.sender;
    } else {
      throw;
    }
  }

  function rate(uint _uid, uint _rating) {
    if (lessons[_uid].student == msg.sender) {
      lessons[_uid].rating = _rating;
      lessons[_uid].teacher.transfer(lessons[_uid].price);
    } else {
      throw;
    }
  }

  function checkLesson (uint _id) constant returns (uint, uint, bool, string) {
    Lesson lesson = lessons[_id];
    return (lesson.price, lesson.rating, lesson.accepted, lesson.description);
  }

}
