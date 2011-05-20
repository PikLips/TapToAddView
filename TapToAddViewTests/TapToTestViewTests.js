/* PikLips:
 * This script drives the UI to inventory the views created by tapping.
 */

// PikLips: a recurve walk through the elements --
function grepElements (checkElement)
{
    if (checkElement.isValid())
    {
        checkElement.logElement();
        var visi = " NOT";
        var enbld = " NOT";
        var chkValid = " NOT";
        if (checkElement.isVisible()) visi = "";
        if (checkElement.isEnabled()) enbld = "";
        if (checkElement.checkIsValid()) chkValid = "";
        
        UIALogger.logPass("Element has " + checkElement.elements().length.toString() + " sub-elements, and " + checkElement.activityIndicators().length.toString() + " activity indicators,  is" + visi + " visible, " + enbld + " enabled, and" + chkValid + " valid.");
        for (var j=0; j < checkElement.ancestry().length; j++)
        {
            UIALogger.logPass("Element " + checkElement.name() + " has a " + checkElement.ancestry()[j] + " : " + checkElement.ancestry()[j].name() + " as an ancestor.");
        }
        for (var i=0; i < checkElement.elements().length; i++)
        {
            grepElements(checkElement.elements()[i]);
        }
    }
}
UIALogger.logStart("UIAutomation testing has begun");

// PikLips: list the element hierarchy --
if (UIATarget != null)
{
    UIALogger.logPass("This is the element log:");
    UIATarget.localTarget().logElementTree();
    UIALogger.logPass("That was the element log.");
}
else
{
    UIALogger.logFail("UIATarget is null.  What's with that?");
}

// PikLips: view a more detailed list --
UIALogger.logPass("*** initiate grep ***.");
grepElements(UIATarget.localTarget());
UIALogger.logPass("*** grep complete ***.");

// PikLips: add some new views --
var window = UIATarget.localTarget().frontMostApp().mainWindow();
var oldLength = window.elements().length;
for (var k=0; k < window.elements().length && k < 5; k++)
{
    window.elements()[0].tapWithOptions({x:0.5, y:0.5});
    UIATarget.localTarget().delay(1);
    if (window.elements()[oldLength].checkIsValid)
        UIALogger.logPass("Number of Views is " + window.elements().length);
    else UIALogger.logFail("New View" + window.elements().length.toString() + " has not materialized.");

    if (window.elements().length == oldLength)
    { 
        UIALogger.logFail("Subview not added to index " + k);
    }
    else
    {
        UIALogger.logPass("elements().length increased from " + oldLength + " to " + window.elements().length.toString() + " elements.");
        oldLength++;
    }
}
// PikLips: this will only work when the tests are run on a device, not the simulator -
UIATarget.localTarget().captureScreenWithName("MainView");
// PikLips: see the chages --
UIALogger.logPass("*** initiate 2nd grep ***.");
grepElements(UIATarget.localTarget());
UIALogger.logPass("*** 2nd grep complete ***.");

UIALogger.logPass("UIAutomation testing has ended");