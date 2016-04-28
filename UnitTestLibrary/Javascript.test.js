module("Javascript Tests",
    {
        setup: function () {
 
        },
        teardown: function(){
 


        }
    }
    );


// Logging call backs
QUnit.moduleDone(function (details) {

    console.log("Module Complete : " + details.name);
    console.log("Passed : " + details.passed);
    console.log("Failed : " + details.failed);
    console.log("Total : " + details.total);
    console.log("Runtime : " + details.runtime);
});

//Register a callback to fire whenever the test suite begins.
QUnit.begin(function( details ) {
   console.log( "Test amount:", details.totalTests );
});

// This function is a call back whenever an assertion completes.
QUnit.log(function (details) {
 //   console.log("Log: ", details.result, details.message);
});
 

// TESTS ------

QUnit.test("hello test", function (assert) {
    
    assert.ok(1 == "1", "Passed!");
});

QUnit.test("Get All Products", function (assert) {
    function square(x) {
        return x * x;
    }

    var result = square(2);
    assert.equal(result, 4, "square(2) equals 4");

});
 

 