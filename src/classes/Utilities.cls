public with sharing class Utilities {

	public static String getFieldListAsString(List<String> fields)
	{
		return String.join(fields, ',');
	}

	public static List<String> getSObjectFields(String sObjectName)
	{
		List<String> fields = new List<String>();

		Map<String, Schema.SObjectType> allSObjectTypes = Schema.getGlobalDescribe();
		Schema.SObjectType sObjectType = allSObjectTypes.get(sObjectName.toLowerCase());

		if (sObjectType != null)
		{
			Schema.DescribeSObjectResult sObjectResult = sObjectType.getDescribe();
			Map<String, Schema.SObjectField> allSObjectFields = (Map<String, Schema.SObjectField>)sObjectResult.fields.getMap();

			for (Schema.SObjectField field : allSObjectFields.values())
			{
				fields.add(field.getDescribe().getName());
			}
		}
		return fields;
	}
}