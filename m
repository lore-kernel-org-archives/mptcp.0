Content-Type: multipart/mixed; boundary="===============0205809326987054015=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 10:19:29 -0800
Message-ID: <20191213181929.GA9430@MacBook-Pro-64.local>
In-Reply-To: 99dcfe95-7358-226d-54ba-12284edd5ba8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2972

--===============0205809326987054015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sure, here is the update:

=3D=3D=3D=3D

Subject: [PATCH net-next 0/0] Multipath TCP part 3: MPTCPv1 (RFC 8684) supp=
ort

These patches depend on the "Multipath TCP part 2: Single subflow"
patch set sent earlier.

In this set we add the necessary code for the RFC8684-style handshake.
RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on the
version 1.

The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
deploiments are currently based on RFC 6824, future deploiments will be
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

=3D=3D=3D=3D



Christoph


On 13/12/19 - 12:04:24, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On 13/12/2019 02:19, Christoph Paasch wrote:
> > for part 3:
> =

> Thank you for sharing this!
> =

> > Subject: [PATCH net-next 0/0] Multipath TCP part 3: MP_CAPABLE handshake
> =

> Should we call it:
> =

>   Multipath TCP part 3: MPTCPv1 (RFC 8684) support
> =

> > These patches depend on the "Multipath TCP part 2: Single subflow"
> > patch set sent earlier.
> > =

> > In this set we add the necessary code for the MP_CAPABLE exchange,
> > negotiating the MPTCP-version, keys and some flags. The handshake
> > has been specified such that it works reliably with servers using TCP
> > SYN-cookies
> > although the current implementation does not yet support SYN cookies.
> Should we give more details about MPTCPv1?
> - What it is: RFC 8684, obsoleting RFC 6824
> - Why we want to support it on drop the previous support: ease the code, =
RFC
> 6824 is obsolete and should not be used in new deployment, e.g. 5G, link =
to
> the 3GPP document
> - Why we did it like that: some deployments only support MPTCPv0 and didn=
't
> switch to the new version yet. If really needed, with this history it wou=
ld
> be easier to re-add MPTCPv0 support in addition to the v1.
> =

> What do you think?
> =

> Cheers,
> Matt
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0205809326987054015==--
