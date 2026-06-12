Clickops Manage instance group (MIG) 

The goal is to create a fully configured, manage instance group using the gcp console. The MIG will automatically scale, heal and distribute instances across multiple zones. 

In order to do this, you must have a gcp product with billing enabled, IAM roles, compute admin or something equivalent, A predefined instance template and a configured network and sub network, and knowledge of the GCP console UI. 

Step 1: Create the MIG

Navigate the compute engine to the instant groups to create an instant group. Then select manage instant group and choose your instance template. Select multiple zones and pick the zones or region for the group. Then, set the target size 

Step 2: Enabling auto scaling 
Find Auto scaling and then enable it. When you find it, set the min/max number of instances. Choose a scaling metric either CPU utilization or load balancing capacity. Confirm and then save. 

Step 3: enable autohealing 

Search for auto healing in the MIG page. Specify a health check and set an initial delay. 

Step 4: verifying multi-zone distribution. 

Check that the instance distribution shows the instances and all the selected zones. The “regional” will automatically balance instances across all the zones. Observe the instances in each zone after a scale-up scale down event.

Step 5: Additional configurations

Configure for instance template updates and health checks. Monitor and inspect for downtime.
