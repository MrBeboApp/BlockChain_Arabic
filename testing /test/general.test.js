const assert = require('assert')
 age = require("../age")
class userName {

     myName(){
        return "bahaa taha";
    }
}

beforeEach(()=>{

    console.log("We are in Before testing function")

})

describe("will testing the use name",()=>{

    //All fuction test for all user name

    it('wll return bahaa taha',()=>{
        user = new userName

        assert.equal(user.myName(), "bahaa taha");
    }),

    it("my age is 35",()=>{
        age = new age
        assert.ok(age.myAge())
        assert.equal(age.myAge(), 35);
    })

});
