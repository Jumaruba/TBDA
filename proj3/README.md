## Questions

*a. Which are the facilities where the room type description contains ‘touros’ and have ‘teatro’ as one of their activities? Show the id, name, description and
activity.*

**Type**: Facility/RoomType/Activity 

*b. How many facilities with ‘touros’ in the room type description are there in each region?*

**Type**: Region/Facility/RoomType

*c. How many municipalities do not have any facility with an activity of
‘cinema’?*

**Type**: Municipality/Facility/Activity

*d. Which is the municipality with more facilities engaged in each of the six kinds of activities? Show the activity, the municipality name and the corresponding number of facilities.* 

**Type**: Municipality/Facility/Activity 

*e. Which are the codes and designations of the districts with facilities in all the municipalities?*

**Type**: District/Municipality/Facility

*f. Ask the database a query you think is interesting*

## Schema 

### Creating only one collection 

We could create a schema such as Region/District/Municipality/Facility/Activity, but since some facilities doesn't have any region, it's natural that the Region is not a good candidate to encapsulate our schema.  

We could also create something like District/Region and District/Municipality/Facility/Activity, but some district doesn't have any region. However, every municipality has a region, thus, we can save the region inside the municipality. 

