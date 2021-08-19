// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Campaign{
    
    //شكل الاسركت للريكويست لانشاء الكامبين
    struct Request{
        string  description;
         uint value;
         address recipient;
         bool complete;
    }
    


       //لسته من الطلبات
         Request [] public requests;
        //مدير الحساب
        address public manager;
        
        //اقل مبلغ يمكن التبرع بة
        uint public minimumContributionMoney;
        
        //عناوين مجموعة المساهمين
        address []  public approvers;
            
     
            
    //لابد من ادخال اقل مبلغ للمساهمة قبل عمل العقد او نسخة منه
    constructor(uint minimum){
        //اعطاء القيم لمدير العقد و تسجيل اقل قيمة للتبرع
        manager = msg.sender;
        minimumContributionMoney = minimum;
        
        
    }
    
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    
    
    //دالة المساهمة بالتبرع والتاكد ان المبلغ  اكثر من او يساوي المبلغ المخزن للتبرعه بة
    
    function contribute() public payable {
        require(msg.value >= minimumContributionMoney);
        //اضاة المتبرع لمجموعه عناوين المتبرعين
        approvers.push(msg.sender);
    }
    
    //الداله الخاصة بأنشاء ريكويست  لانشاء كمبين
    
    function createRequest(string  memory description,uint value,address recipient) public restricted{
        Request memory newRequest = Request ({
           description: description,
           value:value,
           recipient :recipient,
           complete:false
        });
        
        requests.push(newRequest);
    }
}