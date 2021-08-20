// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract CampaignFactory{
    Campaign [] deployedCampaigns;

    function createCampaign (uint minium )  public{
        Campaign  newCampaign  = new Campaign(minium, msg.sender);
        deployedCampaigns.push(newCampaign);

    }
    
    function getDeployedCampaign() public view returns( Campaign [] memory ) {

        return   deployedCampaigns;
    }
}

contract Campaign {
    

    //شكل الاسركت للريكويست لانشاء الكامبين
    struct Request{
        string  description;
         uint value;
         address recipient;
         bool complete;
         uint approvalCount;
             mapping(address=>bool) approvals;

    }
    


       //لسته من الطلبات
         Request [] public requests;
        //مدير الحساب
        address public manager;
        
        //اقل مبلغ يمكن التبرع بة
        uint public minimumContributionMoney;
        
        //عناوين مجموعة المساهمين
      mapping (address=>bool) public approvers;
      uint public approversCount ;
            
     
            
    //لابد من ادخال اقل مبلغ للمساهمة قبل عمل العقد او نسخة منه
    constructor(uint minimum,address creator){
        //اعطاء القيم لمدير العقد و تسجيل اقل قيمة للتبرع
        manager = creator;
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
        approvers[msg.sender] = true;
        approversCount ++;
    }
    
    //الداله الخاصة بأنشاء ريكويست  لانشاء كمبين
    
    function createRequest(string  memory description,uint value,address recipient) public restricted{
  Request memory newRequest = Request ({
           description: description,
           value:value,
           recipient :recipient,
           complete:false,
           approvalCount: 0
        });
        
        requests.push(newRequest);
    }
    
    //الداله الخاصة بالتصويت لاتاحة السحب لصاحب الحملة من قبل الاعضاء 
    
    function approverequest(uint index)public{
        //الفرق بين الsorage and memory ان الاستوردج تاخد نسخة جديده موقته  ولا تسبدال الذي بالذاكرة
        Request storage request = requests[index];
        
        require(request[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
        
    }
    
    function finalizeRequest(uint index)  public restricted{
        Request storage request = requests[index];
        require(request.approvalCount >(approversCount/2));
        require(!request.complete);
        request.recipient.transfer(request.value);
        request.complete=true;
        
    }
    
}
