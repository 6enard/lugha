/*
  # Update Kalenjin to Kipsigis Dialect
  
  Update the Kalenjin language record to specify Kipsigis as the dialect.
  
  Changes:
  - Update tribe_name from "Kalenjin" to "Kipsigis"
  - Add Kipsigis dialect specification to description
*/

UPDATE languages
SET 
  tribe_name = 'Kipsigis',
  description = 'Kipsigis dialect of the Kalenjin language spoken in the Rift Valley region'
WHERE name = 'Kalenjin';