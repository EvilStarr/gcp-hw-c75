Q&A

Availability vs. Fault tolerant

High availability goal is to minimize possible downtime. Systems can fail, but recover quickly. High availability can be achieved by using multiple instances, low balancing,  health checks and multizone deployments. Examples: an app running on VMS across two zones in a region. If one zone goes down the traffic shifts to the other zone. 

Fault tolerance goal is to have zero interruption. The system keeps working without any visible impact even during failure.  This requires the following real-time redundancy,  instant failover, often active active systems. An example of fault tolerance: two systems processing the same request at the same time. One of them will instantly take over. 

The key difference between high availability and false tolerance. Is that high systems that have high availability recover quickly but if your systems are false tolerant, they will not break.  You should design your systems by high availability by default, but you use fault tolerance for mission critical projects. High availability is also cheaper than fault tolerance. 

https://medium.com/@harshithgowdakt/high-availability-vs-fault-tolerance-the-crucial-distinction-in-distributed-systems-ac4947537cd2

https://youtu.be/V1dffu8QOlU?si=2GHuuNjhGpi_aM-S	

High Availability vs. Fault Tolerance | Cloud Academy


Auto scaling vs. Elasticity

Elasticity = The ability of the hardware layer to increase or shrink the amount of physical resources offered by that hardware layer (or cloud infrastructure).

Scalability = The ability of the software system to process higher amounts of workload on the current hardware resources (scale up) or on the current and additional hardware resources (scale out) without service interruption. 

Vertical scaling scales up and down while horizontal scaling scales out and in. It is better to use horizontal scaling because it supports higher availability at a large scale while vertical scaling is simpler but it is very limited.

https://www.geeksforgeeks.org/system-design/scalability-vs-elasticity/

Unmanaged versus managed instance groups 

Manage instant groups automatically. Create, update and heal instances. They also support Auto, scaling and rolling updates. They are best for uniform and stateless workloads. 

Unmanaged instant groups has no Auto scaling and automatic healing. They are useful and custom workloads and  you have to manage the instance manually.

https://docs.cloud.google.com/compute/docs/instance-groups

Health checks load balancer versus application 

Load balancer health checks decides which instances receive traffic and uses a simple http/tcp endpoint. While application health checks can determine internal health of the instances and have base connectivity through deep logic checking. These two are not the same and they are different APIs. The best practice for a load balancer check should be lightweight and application checks be more detailed. 

https://docs.cloud.google.com/compute/docs/instance-groups/autohealing-instances-in-migs#checking_whether_instances_are_healthy

Three- tier architecture 

Presentation layer = user interface 
Application layer = business processing 
Data layer = database systems 

The benefits of a three-tier architecture: The maintenance isn't very difficult and it has independent scaling. 

https://aws.amazon.com/blogs/architecture/building-a-three-tier-architecture-on-a-budget/

https://www.ibm.com/think/topics/three-tier-architecture



