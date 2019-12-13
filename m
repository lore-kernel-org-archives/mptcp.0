Content-Type: multipart/mixed; boundary="===============6181103675241268292=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 10:32:35 -0800
Message-ID: <20191213183235.GC9430@MacBook-Pro-64.local>
In-Reply-To: 36e4c35d-924c-ba5c-e092-d3a8010fe7d1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2975

--===============6181103675241268292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for catching these! Update:

=3D=3D=3D=3D=3D


Subject: [PATCH net-next 0/0] Multipath TCP part 3: MPTCPv1 (RFC 8684) supp=
ort

These patches depend on the "Multipath TCP part 2: Single subflow"
patch set sent earlier.

In this set we add the necessary code for the RFC8684-style handshake.
RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
version 1.

The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
deployments are currently based on RFC 6824, future deployments will be
migrating to MPTCP version 1. 3GPP's 5G standardization also solely supports
RFC 8684. Also, we believe that this initial submission of MPTCP will be
cleaner by solely supporting RFC 8684. If later on support for the old
MPTCP-version is required it can always be added in the future.

The major difference between RFC 8684 and RFC 6824 is that it has a better
support for servers using TCP SYN-cookies by reliably retransmitting the
MP_CAPABLE option.

<git tree references at github>

Thank your for your review. You can find us at mptcp(a)lists.01.org <mailto=
:mptcp(a)lists.01.org> and
https://is.gd/mptcp_upstream <https://is.gd/mptcp_upstream>.


=3D=3D=3D=3D=3D


Christoph

On 13/12/19 - 19:28:11, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On 13/12/2019 19:19, Christoph Paasch wrote:
> > Sure, here is the update:
> > =

> > =3D=3D=3D=3D
> > =

> > Subject: [PATCH net-next 0/0] Multipath TCP part 3: MPTCPv1 (RFC 8684) =
support
> > =

> > These patches depend on the "Multipath TCP part 2: Single subflow"
> > patch set sent earlier.
> > =

> > In this set we add the necessary code for the RFC8684-style handshake.
> > RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on the
> =

> I think a word is missing at the end here, maybe:
> =

>   (...) makes MPTCP move onto version 1.
> =

> or "move-on to version 1"?
> =

> > version 1.
> > =

> > The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> > deploiments are currently based on RFC 6824, future deploiments will be
> =

> Small detail: s/deploiments/deployments/g (2 times)
> =

> The rest is good, thank you for the update! :)
> =

> Cheers,
> Matt
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6181103675241268292==--
