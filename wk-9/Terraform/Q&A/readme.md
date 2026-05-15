# Q&A

## Load Balancers

##### How does load balancing contribute to Fault tolerance? What about high availability? 

- Load balancers contribute to Fault tolerance and high availability by issuing traffic across multiple systems and not just one server.
  
- For high availablility, load balancer continously monitor the backend health and end sending traffic to unhealthy network. 

- For fault tolerance, load balancers help applications survive failures without interruptions.

https://www.vmware.com/topics/fault-tolerance
https://aws.amazon.com/what-is/load-balancing/


##### Do global load balancers decrease latency for end users? Why or why not?

- Yes, global load balancers can reduce latency for end users. Global load balancers can route user requests to the nearest available backend server, which can reduce the time it takes for data to travel between the user and the server.

- By distributing traffic across multiple servers in different geographic locations, global load balancers can help users experience faster response times and improved performance, regardless of their location.

https://www.loadbalancer.org/blog/ultimate-guide-to-gslb/

##### What are LB health checks for? Do we always need them? Is a LB different from a reverse proxy?

- LB health checks whether the backend systems are heatlthy enough to receive traffic. 

- if the backend responds successfully, the traffic will continue. If the health check fails, the traffic is removed from the backend.
- Health checks are important to the network because traffic may continue going to failed instances, applications outrages become severe, and automatic failover is impossible.

- A load balanacer and reverse proxy are related but different: 
- A reverse proxy sits between clients and backend servers, receives requests on behalf of applications, and provide SSL termination and caching.
- A load balancer distributes traffic across multiple backends and focuses on scalability and availability. 


https://docs.cloud.google.com/load-balancing/docs/health-check-concepts

##### What are LB routing rules and URL maps for? Give an example or two of them in use. 

- LB routing rules and URL maps are used to define how incoming traffic should be directed to backend services based on specific criteria.
  
- There are two exapmples:
-- Requests for https://example.com/video go to one backend service.
-- Requests for https://example.com/audio go to a different backend service.


https://docs.cloud.google.com/load-balancing/docs/url-map-concepts



##### Explain what an anycast IP address is used for in the context of a global load balancer. 
 
- An anycast IP address is a IP address from multiple locations at the same time. 
- As with context with global load balancers:
--  The users to one global IP address. 
-- Google routes to the nearest healthy edge location.

https://docs.cloud.google.com/load-balancing/docs/anycast-ip-addresses

## Cloud Armor:
##### What does cloud armor offer?
- Google Cloud Armor provides
-- Web Application Firewall (WAF) Protection
-- DDoS mitigation
-- Request filtering
-- Rate limiting
--Threat intelligence integration
-- Geographic access controls
-- Bot mitigation capabilities 

##### Why is it used in the first place?
- Cloud Armor is used to protect applications and services from various types of cyber threats and attacks.
- Modern web applications are constantly targeted by:
-- DDoS attacks
-- SQL injection attempts
-- Cross-site scripting attacks
-- Credential stuffing
-- Automated bot traffic
  
##### What layer in the OSI model does it operate at? Why is this important and how is this firewall different from VPC firewall rules?
- Cloud Armor operates at Layer 7 (Application Layer) of the OSI model.
- Its important because Layer 7 security understands:
-- HTTP methods
-- URLs
-- Headers
-- Cookies
-- Request patterns 
##### What are rate based rules for? 
Rate‑based rules let Cloud Armor detect and control high‑volume traffic from a client (IP, header value, region, etc.) and take automated action when thresholds are exceeded. They are used to:

Prevent resource exhaustion — Stop a single client from consuming too many backend resources.

Protect against traffic spikes — Smooth out erratic or abusive request bursts.

Mitigate DDoS/DoS attacks — Block or throttle clients generating excessive traffic.

Control API or endpoint abuse — Limit requests to sensitive paths like /login, /checkout, or API endpoints.

https://docs.cloud.google.com/armor/docs/rate-limiting-overview

##### What is reCAPTCHA and how does it relate to this service? 
reCAPTCHA is a Google service that uses advanced risk analysis to distinguish humans from automated clients. It issues an encrypted token that represents the risk level of the request. Cloud Armor can read this token inline and act on it.

Cloud Armor and reCAPTCHA work together as part of Google’s bot management system:

reCAPTCHA evaluates the user and generates a risk token.

Cloud Armor deciphers the token inline (no extra network call).

Based on token attributes, Cloud Armor can:

Allow the request

Deny it

Rate‑limit it

Redirect it (e.g., to a challenge page)

This lets Cloud Armor enforce bot protections at the edge, before traffic reaches your application.

https://docs.cloud.google.com/armor/docs/bot-management

## Cloud CDN: 
##### What are POPs used for? 
- POPs in Google Cloud are the edge locations where Google terminates user traffic, applies security (like Cloud Armor), and routes requests onto Google’s private backbone. They’re the “front door” to Google’s global network.

1. Edge termination
User traffic hits a nearby Google POP first.
This is where:

--TLS is terminated
--Cloud Armor policies are evaluated
--reCAPTCHA challenges are triggered

2. Global load balancing
Google’s load balancer is truly global because it runs at POPs.
This gives:

--Anycast IPs
--Automatic failover
--Traffic steering to the closest healthy region

3. DDoS absorption
POPs are where Google absorbs massive L3/L4/L7 attacks.
Cloud Armor’s protections—including rate‑based rules—are enforced at the POP, not in your region.

This prevents:

--Resource exhaustion
--Backend overload
--Regional saturation

4. Low‑latency routing
Once traffic enters a POP, it travels across Google’s private fiber network, not the public internet.
This gives:

--Lower latency
--Higher reliability
--Fewer hops

5. Content caching
Cloud CDN uses POPs to cache static content close to users.
This reduces:

--Latency
--Backend load
--Egress costs

##### What kind of files are served with Cloud CDN? 
- Cloud CDN in Google Cloud serves static, cache‑friendly files that can be delivered efficiently from Google’s global edge POPs. These files are fetched from your origin (Cloud Storage, Compute Engine, Cloud Run, GKE, or external origins) and cached at the edge to reduce latency and backend load.

- The key takeaway: Cloud CDN serves static HTTP(S) content—anything that can be cached and delivered without needing dynamic computation.

- Cloud CDN is designed for static web assets and media, including:

--Images — JPG, PNG, GIF, WebP, SVG
--Videos — MP4, WebM, MOV (static or streaming segments)
--Stylesheets — .css
--JavaScript files — .js
--Static HTML — .html
--Fonts — WOFF, WOFF2, TTF
--Documents — PDFs, text files, etc.
--Large file downloads — ZIPs, binaries, installers

- These are explicitly supported as “static resources such as media files like images and videos, CSS stylesheets, JavaScript files, and so on” according to Google Cloud documentation

https://www.geeksforgeeks.org/cloud-computing/how-to-setup-google-cloud-cdn/

##### What services can be used with cloud CDN for the source of content (the origin)? 
- Cloud CDN can use Compute Engine, Cloud Storage, GKE, Cloud Run/Cloud Functions (via HTTPS load balancer), and ANY external HTTP(S) server (AWS, Azure, on‑prem, third‑party APIs) as origins.
- This is confirmed by Google Cloud’s documentation stating Cloud CDN supports “any HTTP‑capable origin, including Compute Engine, Cloud Storage, and Google Kubernetes Engine back ends and origins outside of Google Cloud.”

1. Compute Engine
VM instances behind an external HTTP(S) load balancer can serve as CDN origins.
This is the most common setup for web apps and APIs.

2. Cloud Storage buckets
Cloud CDN can cache objects from Cloud Storage when used with a backend bucket.
Ideal for static websites, images, downloads, and media.
Google documentation confirms Cloud Storage is a supported origin.

3. Google Kubernetes Engine (GKE)
GKE services exposed through an external HTTP(S) load balancer can be used as origins.
Useful for containerized web apps and microservices.

4. Cloud Run or Cloud Functions (via HTTPS load balancer)
Serverless backends can be fronted by Cloud CDN as long as they sit behind an external Application Load Balancer.

5. External origins (custom origins)
Cloud CDN can cache content from any internet‑reachable HTTP or HTTPS endpoint, including:

--AWS EC2
--Azure App Service
--On‑prem servers
--Third‑party APIs or CMS
--Any FQDN or IP‑based HTTP(S) server

This is explicitly supported via Internet NEGs (Network Endpoint Groups).
Cloud CDN “is not limited to serving content from GCP resources” and can point to any HTTP(S) backend on the internet.

6. External Application Load Balancer as an origin
For private or hybrid environments, Cloud CDN can use an external Application Load Balancer as the origin behind Media CDN or Cloud CDN.
Google documentation confirms private resources can be reached this way.

##### Does Cloud CDN help protect against any types of malicious actors or cyberattacks? Explain.
Yes — Cloud CDN does help protect against certain types of malicious actors and cyberattacks, even though its primary purpose is performance and caching. It provides edge‑level protection by absorbing, filtering, and rate‑limiting traffic before it reaches your backend.

1. Absorbs large volumes of traffic at the edge
Cloud CDN caches content in Google’s global POPs.
When attackers send huge volumes of requests for static assets, the POPs serve them without touching your backend.

This protects you from:

Bandwidth exhaustion

CPU/memory overload

Autoscaling cost spikes

2. Reduces attack surface
Attackers never reach your origin directly.
They only hit Google’s edge, which is built to withstand massive traffic.

Your backend IPs stay hidden behind:

The load balancer

Cloud CDN

Cloud Armor

3. Works with Cloud Armor for L7 protection
Cloud CDN doesn’t block malicious traffic by itself, but it pairs with Cloud Armor, which does.

Cloud Armor adds:

WAF rules

Rate‑based rules

IP allow/deny lists

reCAPTCHA bot detection

Cloud CDN ensures that only cache misses reach Cloud Armor, reducing the load on security filters.

4. Mitigates malicious scraping and repeated downloads
Because Cloud CDN serves cached content:

Attackers cannot overload your origin by repeatedly downloading files

Scrapers cannot force your backend to regenerate content

Bandwidth costs stay low

5. Helps absorb DDoS attacks
Google’s edge network is designed to handle terabit‑scale attacks.
Cloud CDN benefits from this automatically.

It helps mitigate:

Volumetric DDoS

HTTP GET floods

Static asset request floods

Dynamic attacks still require Cloud Armor, but CDN offloads the bulk of traffic.

Cloud CDN works together with Google’s global Points of Presence (POPs), Cloud Armor, and the external HTTP(S) load balancer to create a protective shield around your services.
 

##### Should an enterprise always use cloud CDN? Why or why not? 
Not always — an enterprise should use Cloud CDN when it fits the workload, not as a blanket rule.  
Cloud CDN is powerful, but it’s not universally beneficial. The right choice depends on what the enterprise serves, how dynamic the content is, and what the performance and cost goals look like.

Cloud CDN is ideal when an enterprise serves static or cache‑friendly content at scale.
It is not ideal when the workload is highly dynamic, personalized, or latency‑insensitive.
These scenarios almost always benefit:

Static websites — HTML, CSS, JS, images, fonts

Media delivery — videos, downloads, large files

Global audiences — users far from your regions

High traffic volumes — reduces backend load and cost

DDoS resilience — POPs absorb traffic spikes

APIs with cacheable responses — e.g., product catalogs, public data

In these cases, Cloud CDN improves:

Latency

Scalability

Reliability

Cost efficiency


These workloads don’t benefit much:

Highly dynamic content — personalized dashboards, real‑time data

Authenticated content with no cacheability

Internal‑only applications — intranet, private APIs

Low‑traffic workloads — caching adds cost without benefit

Content that must always be fresh — stock prices, bidding systems

If the content changes constantly or is user‑specific, caching provides little value.


##### What is TTL and how does it control content “freshness”? 
- TTL (Time To Live) is the setting that tells Cloud CDN how long a cached object should be considered “fresh” before the CDN must revalidate or refetch it from the origin.

It is the primary mechanism that controls content freshness, cache efficiency, and how often users see updated content.

1. Fresh period
During the TTL window, Cloud CDN serves the cached object immediately from the nearest POP.
--No origin request.
--No validation.
--Fastest possible delivery.

This is the “fresh” state.

2. Stale period
Once TTL expires, the object becomes stale.
Cloud CDN must either:

-- Revalidate it with the origin (using If-Modified-Since or ETag), or
Fetch a new copy

This ensures users eventually get updated content.

3. Cache-control headers
- TTL is usually controlled by HTTP headers such as:

--Cache-Control: max-age=3600

--Expires: <timestamp>

Cloud CDN respects these unless you override them with custom TTL settings.
