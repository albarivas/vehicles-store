public with sharing class CarController
{
	// Property
	public Car DomainObject {get; set;}

	public CarController(ApexPages.StandardController standardController)
	{
		DomainObject = new Car(standardController.getId());
	}

	public PageReference sell()
	{
		try
		{
			DomainObject.sell();
			return goBack();
		}
		catch (Exception e)
		{
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,e.getMessage()));
		}
		return null;
	}

	public PageReference rent()
	{
		try
		{
			DomainObject.rent();
			return goBack();
		}
		catch (Exception e)
		{
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,e.getMessage()));
		}
		return null;
	}

	public PageReference returnRentedVehicle()
	{
		try
		{
			DomainObject.returnRentedVehicle();
			return goBack();
		}
		catch (Exception e)
		{
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,e.getMessage()));
		}
		return null;
	}

	public PageReference goBack()
	{
		PageReference viewPage = DomainObject.getViewPage();
		viewPage.setRedirect(true);
		return viewPage;
	}
}