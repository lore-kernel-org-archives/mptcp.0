Content-Type: multipart/mixed; boundary="===============1730174817559276449=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 12:04:24 +0100
Message-ID: <99dcfe95-7358-226d-54ba-12284edd5ba8@tessares.net>
In-Reply-To: 7E333AF6-9EBB-4809-B3B2-EE633A5A89C6@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2927

--===============1730174817559276449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 13/12/2019 02:19, Christoph Paasch wrote:
> for part 3:

Thank you for sharing this!

> Subject: [PATCH net-next 0/0] Multipath TCP part 3: MP_CAPABLE handshake

Should we call it:

   Multipath TCP part 3: MPTCPv1 (RFC 8684) support

> These patches depend on the "Multipath TCP part 2: Single subflow"
> patch set sent earlier.
> =

> In this set we add the necessary code for the MP_CAPABLE exchange,
> negotiating the MPTCP-version, keys and some flags. The handshake
> has been specified such that it works reliably with servers using TCP =

> SYN-cookies
> although the current implementation does not yet support SYN cookies.
Should we give more details about MPTCPv1?
- What it is: RFC 8684, obsoleting RFC 6824
- Why we want to support it on drop the previous support: ease the code, =

RFC 6824 is obsolete and should not be used in new deployment, e.g. 5G, =

link to the 3GPP document
- Why we did it like that: some deployments only support MPTCPv0 and =

didn't switch to the new version yet. If really needed, with this =

history it would be easier to re-add MPTCPv0 support in addition to the v1.

What do you think?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1730174817559276449==--
