trigger Car on Car__c (before insert, before update, before delete, after insert, after update, after delete)
{
	if (Trigger.isBefore)
	{
		if (Trigger.isInsert)
		{
			// Before insert
			for (Car__c dto : Trigger.new)
			{
				if (dto.Sold__c == true || dto.Rented__c == true)
					throw new VehicleException('Cannot insert a sold / rented car.');
			}
		}
		else if (Trigger.isUpdate)
		{
			// Before update
			for (Car__c dto : Trigger.new)
			{
				Car__c oldDto = Trigger.oldMap.get(dto.Id);

				// Car is going to be sold
				if (dto.Sold__c == true)
				{
					if (oldDto.Rented__c == true)
						throw new VehicleException('The vehicle is already rented.');
				}

				// Car is going to be rented
				if (dto.Rented__c == true)
				{
					if (oldDto.Sold__c == true)
						throw new VehicleException('The vehicle is already sold.');
					if (dto.RentHours__c == null)
						throw new VehicleException('Must indicate the rent hours.');
				}
			}
		}
		else if (Trigger.isDelete)
		{
			// Before delete
		}
	}
	else if (Trigger.isAfter)
	{
		if (Trigger.isInsert)
		{
			// After insert
		}
		else if (Trigger.isUpdate)
		{
			// After update
		}
		else if (Trigger.isDelete)
		{
			// After delete
		}
	}
}