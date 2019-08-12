Content-Type: multipart/mixed; boundary="===============4791566379182221179=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 07/10] Move setting request_ fields of subflow
 to MPTCP layer helper
Date: Mon, 12 Aug 2019 21:36:12 +0200
Message-ID: <1ae8d035-3d87-ac5a-2f4b-4c1595a50ebe@tessares.net>
In-Reply-To: 20190807224434.2829-8-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1622

--===============4791566379182221179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 00:44, Peter Krystad wrote:
> For secondary subflows different request_ fields will
> be added that will be set differently based on subflow type
> (initial vs secondary).
> =

> squashto: Associate MPTCP context with TCP socket

Thank you for the patch and the reviews!

I had to split it in 3 parts:
- a831a5f64a0d: part 1: "squashed" in "mptcp: Associate MPTCP context
with TCP socket"
- 4dff4a3c37ec: conflict in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- 7a108cfff657: part 2: "squashed" in "mptcp: Create SUBFLOW socket for
incoming connections"
- ff3b994f4b4c: conflict in
t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets
- 987b6d7366be: conflict in
t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- b99045fe03e0: part 3: "squashed" in "mptcp: harmonize locking on all
socket operations."
- 64fb32edc6b2: signed-off
- b81ff8d90de3..f7938dd15948: result.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4791566379182221179==--
