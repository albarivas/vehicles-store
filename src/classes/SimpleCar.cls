public class SimpleCar
{
	public static final Set<String> allowedColours = new Set<String>{'RED','WHITE'};

	public Car__c myCar;

	 public SimpleCar(Id carId)
	 {
	 	myCar = [SELECT Id, Name, Colour__c FROM Car__c where Id = :carId];
	 }

	 public String getColour()
	 {
	 	return myCar.Colour__c;
	 }

	 public void setColour(String colour)
	 {
	 	if (!allowedColours.contains(colour))
	 		throw new VehicleException('Wrong Colour');

	 	try
	 	{
	 		myCar.Colour__c = colour;
	 		update myCar;
	 	}
	 	catch (Exception e)
	 	{
	 		System.debug('Update failed');
	 	}
	 }
}