Individual work:
Explain the differences and similarities between HA VPN and NCC?

According to the website, ([NCC overview  |  Network Connectivity Center  |  Google Cloud Documentation](https://docs.cloud.google.com/network-connectivity/docs/network-connectivity-center/concepts/overview) )  “Network Connectivity Center (NCC) is an orchestration framework that simplifies network connectivity among spoke resources that are connected to a central management resource called a hub.” 

According to ([Cloud VPN overview  |  Google Cloud Documentation](https://docs.cloud.google.com/network-connectivity/docs/vpn/concepts/overview)), HA VPN is a “high-availability (HA) Cloud VPN solution that lets you securely connect your on-premises network to your VPC network through an IPsec VPN connection.”
The difference between HA VPN and NCC:

1: HA VPN has A specific connectivity method for hybrid links while NCC has a centralized framework for hub and spoke topologies. 
([NCC overview  |  Network Connectivity Center  |  Google Cloud Documentation](https://docs.cloud.google.com/network-connectivity/docs/network-connectivity-center/concepts/overview) )

2: HA VPN has bgp-base routing exchange between endpoints, while NCC has a centralized routing domain.
HA VPN is a connectivity method like a bridge while MCC is a networking framework that can include a HA VPN. 


Explain the use cases of HA VPN vs NCC?

HA VPN: Quick, low‑cost on‑prem or partner cloud connectivity; failover or backup link.
 
NCC: Large‑scale, multi‑VPC, multi‑hub, multi‑cloud enterprise WAN; centralized routing and policy management. 




Explain the use cases of the Network Intelligence Center? 
One use case: NIC Connectivity tests verifies if a source can reach a destination and pinpoint where/why it has failed. ([Network Intelligence Center | Google Cloud](https://cloud.google.com/network-intelligence-center)) 

Firewall Insights: Provides data about firewall rules are used, exposes misconfigurations, and identifies rules that could be more strict ([Network Intelligence Center | Google Cloud](https://cloud.google.com/network-intelligence-center))

Flow Analyzer: Analyze VPC Flow logs quickly and efficiently with the need of complex SQL queries. Performs opinionated network traffic analysis with source IP, destination IP, source port, destination port, and protocol.  ( [Network Intelligence Center | Google Cloud ](https://cloud.google.com/network-intelligence-center))

Network Analyzer:  monitors the VPC network configuration and detects misconfigurations and suboptimal configurations. Identifies failures due to network problems. ([Network Intelligence Center | Google Cloud](https://cloud.google.com/network-intelligence-center))
