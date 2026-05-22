# Cloud Infrastructure Q&A
### DNS, SSL/TLS, Load Balancers, and Cloud DNS

---

## DNS and SSL/TLS

---

### `traceroute` and `dig` — What do they do, and how do they compare?

Both are command-line tools used to investigate network and DNS behavior

**`dig`** (Domain Information Groper) is a DNS lookup tool. It is used to query DNS.

**`traceroute`** is a network path tool. Its used in networking to show the route that is taken by data packets as they travel across the internet.
https://www.youtube.com/watch?v=up3bcBLZS74&list=PL7zRJGi6nMRzg0LdsR7F3olyLGoBcIvvg&index=30





**Comparing the two:**
`dig` Validates DNS records and checks domain names have the correct IP Address.`traceroute` tracks the physical route that data take from the device to the server.                                        


---

### The 3–4 Most Common DNS Record Types


**A Record (Address Record)**
It maps a domain name directly to an IPv4 address. When you type `example.com` into your browser.

**CNAME Record (Canonical Name)**
A CNAME maps one domain name to another domain name rather than directly to an IP. 

**MX Record (Mail Exchange)**
Tells the internet which server handles email for a domain.

**TXT Record (Text Record)**
A free-text record originally designed to hold human-readable notes. 


https://www.youtube.com/watch?v=HnUDtycXSNE&list=PL7zRJGi6nMRzg0LdsR7F3olyLGoBcIvvg&index=12

---

### Overview of the TLS Handshake

When your browser connects to a website over HTTPS, before any actual data is exchanged, the two sides go through a "handshake" — a brief negotiation that establishes trust and sets up encryption. Here's the simplified version:

1. **Client Hello** — Your browser reaches out to the server sending information to the server.

2. **Server Hello** — The server responds by picking one of the encryption methods from your list and sends back its **SSL/TLS certificate**.

3. **Certificate Verification** — Your browser checks the certificate. it generates from a trusted authority. 

4. **Key Exchange** — The client and server use the certificate to securely agree on a shared encryption key without ever sending that key over the wire in a way that could be intercepted.

5. **Handshake Complete** — Both sides confirm they're ready, and the encrypted session begins. All data from this point forward is scrambled using the shared key.



---

### How Does a SSL/TLS Certificate Know What Domain It Belongs To?

The domain is directly into the certificate itself when it's created. The certificate contains a field called the **Common Name (CN)** or, **Subject Alternative Names (SAN)** field. These fields hold the domain name(s) the certificate is valid for.

When your browser connects to a site, it checks if you're visiting `shop.example.com` and the certificate says `shop.example.com` 
https://www.youtube.com/watch?v=hExRDVZHhig&list=PL7zRJGi6nMRzg0LdsR7F3olyLGoBcIvvg&index=47

---

### What Is a Certificate Authority (CA)?

A Certificate Authority is a trusted third party whose entire job is to verify that you actually own the domain you're claiming to own — and then issue you a certificate that says so. CA lets you directly and programmatically request publicly trusted TLS certicates that are already in the root of trust stores used by major browsers, operating systems, and applications.
https://docs.cloud.google.com/certificate-manager/docs/public-ca
---

## Load Balancers

---

### How do application load balancers in GCP offload (decrypt) SSL?

**SSL offloading** (sometimes called SSL termination) means the load balancer is the one that decrypts incoming HTTPS traffic — not the backend servers. The client's encrypted connection ends at the load balancer, which then communicates with the backends in a separate connection.

In GCP's Application Load Balancer (ALB), this happens at a component called the **Target HTTPS Proxy**. Here's the chain:
The Target HTTPS Proxy is where you attach your SSL/TLS certificate. It's responsible for:
- Receiving encrypted HTTPS traffic from the client.
- Decrypting it using the private key from the attached certificate.
- Passing the now-decrypted (plain HTTP) request along to the URL Map and backend.

https://docs.cloud.google.com/load-balancing/docs/application-load-balancer
---

### Are There Cases Where You'd Want Encryption Between the Load Balancer and the Backend?

Common use cases include:

**Compliance requirements** — Industries like healthcare (HIPAA) or finance (PCI-DSS) may require that data is encrypted even on internal networks. Regulations don't care whether it's "inside" your infrastructure; if the data is sensitive, it must be encrypted in transit.

**Zero-trust security models** — The philosophy of "never trust, always verify" means you don't assume your internal network is safe. If an attacker somehow gets onto your internal network, in-flight encryption between the LB and backend means they still can't read the traffic.

**Multi-region or shared infrastructure** — If traffic between your LB and backends crosses network boundaries that you don't fully control, encryption adds an important layer of protection.

---

## Cloud DNS

---

### Can Multiple Domains Point to the Same Load Balancer?

Yes — A single GCP load balancer can serve traffic for multiple different domains simultaneously.

Each domain just needs a DNS record (typically an A record or CNAME) pointing to the load balancer's IP address. The load balancer receives incoming requests and uses the Host header in the HTTP request, telling the LB what domain the browser was trying to reach — to route the traffic to the right backend.

GCP's Application Load Balancer handles this through **URL Maps**, which let you write rules like "if the host is `api.example.com`, send traffic to this backend; if the host is `docs.example.com`, send to that backend."
https://docs.cloud.google.com/load-balancing/docs/application-load-balancer

---
### What Are Zones in the Context of Cloud DNS?

In Cloud DNS, a **zone** is a container that holds all the DNS records for a specific domain (or subdomain). Think of it like a folder or a filing cabinet dedicated to one domain's worth of DNS configuration.

There are two main types:

**Public Zones** — Visible to the entire internet. If you're managing the DNS for a public-facing website, your records live here. Anyone on the internet can query these records.

**Private Zones** — Only visible within your GCP Virtual Private Cloud (VPC). This is useful for internal service discovery — for example, having `database.internal` resolve to a private IP that's only reachable inside your network, with no public exposure.

https://docs.cloud.google.com/dns/docs/overview

