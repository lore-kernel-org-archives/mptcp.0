Content-Type: multipart/mixed; boundary="===============5387146968266632807=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 19:28:11 +0100
Message-ID: <36e4c35d-924c-ba5c-e092-d3a8010fe7d1@tessares.net>
In-Reply-To: 20191213181929.GA9430@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 2974

--===============5387146968266632807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 13/12/2019 19:19, Christoph Paasch wrote:
> Sure, here is the update:
> =

> =3D=3D=3D=3D
> =

> Subject: [PATCH net-next 0/0] Multipath TCP part 3: MPTCPv1 (RFC 8684) su=
pport
> =

> These patches depend on the "Multipath TCP part 2: Single subflow"
> patch set sent earlier.
> =

> In this set we add the necessary code for the RFC8684-style handshake.
> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on the

I think a word is missing at the end here, maybe:

   (...) makes MPTCP move onto version 1.

or "move-on to version 1"?

> version 1.
> =

> The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> deploiments are currently based on RFC 6824, future deploiments will be

Small detail: s/deploiments/deployments/g (2 times)

The rest is good, thank you for the update! :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5387146968266632807==--
