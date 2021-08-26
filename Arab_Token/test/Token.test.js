const Token = artifacts.require('./Token');
require('chai').use(require('chai-as-promised')).should()

contract("Token", ([owner,receiver])=>{
let token;
    beforeEach( async ()=>{
     token = await Token.new();

    })

    describe("Deployment ",()=>{

        it("Track the token name", async ()=>{
            const result = await token.name();
            result.should.equal("Arabic Token");
        }),

        it("Track the symbol ", async ()=>{
            const result = await token.symbol();
            result.should.equal("ARAB");
        }),
        it("Track the token decimals", async ()=>{
            const result = await token.decimals();
            result.toString().should.equal("10");
        }),
        it("Track the token TotalSupply", async ()=>{
            const result = await token.totalSupply();
            result.toString().should.equal("20000000000000");
        })



    })

    describe("Transfare Tokens",async()=>{

        it("chaeck token balances",async()=>{
            let balanceOf

            //Balances Before the transfare 
            balanceOf = await token.balanceOf(owner)

            balanceOf = await token.balanceOf(receiver)
            //Start Transfe
            await token.transfare(receiver,"20000000000000",{from:owner})
           //Balances After the transfare 
             balanceOf = await token.balanceOf(owner)
             balanceOf = await token.balanceOf(receiver)

        }),
        it("emit the transfar",async()=>{
            const result = await token.transfare(receiver,"20000000000000",{from:owner});
            const log = result.logs[0];
            log.event.should.equal("Transfer");
            console.log(log.args._from.toString());
            log.args._from.toString().should.equal(owner)

        }),
        it("invalid Reciver",async()=>{
            await token.transfare(0x0,"20000000000000",{from:owner}).should.be.rejected;
        }),
        it("invalid owner balance",async()=>{
            await token.transfare(receiver,"20000000000000",{from:receiver}).should.be.rejected;
        })


    })
})
