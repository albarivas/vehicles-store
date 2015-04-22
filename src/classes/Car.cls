public class Car
{
	// Property
	public Car__c Dto { get; set;}

	// Instance variable
	private static final List<String> fields = Utilities.getSObjectFields('Car__c');

	public Car()
	{
		Dto = new Car__c();
	}

	public Car(Id carId)
	{
		// Dynamic SOQL
		Dto = Database.query('SELECT ' + Utilities.getFieldListAsString(fields) + ' FROM Car__c where Id = :carId');
	}

	public void sell()
	{
		Savepoint sp = Database.setSavepoint();

		try
		{
			if ((boolean) Dto.Sold__c == false)
			{
				// Update sold checkbox
				Dto.Sold__c = true;
				update Dto;

				// Add transaction
				Decimal amount = (Decimal) Dto.Price__c;
				Transaction__c transact = new Transaction__c();
				transact.Amount__c = amount;
				insert transact;
			}
		}
		catch (Exception e)
		{
			Dto.Sold__c = false;
			Database.rollback(sp);
			throw e;
		}
	}

	public void rent()
	{
		Savepoint sp = Database.setSavepoint();

		try
		{
			if ((boolean) Dto.Rented__c == false)
			{
				// Update rent hours and rented checkbox
				Dto.Rented__c = true;
				update Dto;

				// Add transaction
				Decimal pricePerHour = (Decimal) Dto.RentingPrice__c;
				Decimal amount = pricePerHour * (Decimal) Dto.RentHours__c;
				Transaction__c transact = new Transaction__c();
				transact.Amount__c = amount;
				insert transact;
			}
		}
		catch (Exception e)
		{
			Dto.Rented__c = false;
			Database.rollback(sp);
			throw e;
		}
	}

	public void returnRentedVehicle()
	{
		if ((boolean) Dto.Rented__c == true)
		{
			// Update rent hours and rented checkbox
			Dto.Rented__c = false;
			Dto.RentHours__c = null;
			update Dto;
		}
	}

	public PageReference getViewPage()
	{
		return new ApexPages.StandardController(Dto).view();
	}
}