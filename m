Content-Type: multipart/mixed; boundary="===============5572452873742896595=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Part 2 - Cover Letter
Date: Fri, 17 Jan 2020 08:12:16 -0800
Message-ID: <20200117161216.GZ30818@MacBook-Pro-64.local>
In-Reply-To: 8c780fbe-d06a-3959-c360-66908a50d18b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3394

--===============5572452873742896595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 17/01/20 - 16:58:07, Matthieu Baerts wrote:
> Hi Christoph, Mat,
> =

> On 17/01/2020 02:33, Mat Martineau wrote:
> > =

> > On Thu, 16 Jan 2020, Christoph Paasch wrote:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Jan 16, 2020, at 10:07 AM, Christop=
h Paasch
> > > <cpaasch(a)apple.com> wrote:
> > > =

> > > Hello,
> > > here is the proposed cover-letter for Part 2. I assume that it will
> > > be "v3" as Mat already sent out the v2 before Christmas.
> > > =

> > =

> > Yes, it should be v3.
> > =

> > Cover letter additions for RFC8684 look good, thanks Christoph.
> =

> For me too. Just a few questions here below, only details.
> =

> > > Please let me know what should be changed.
> > > =

> > > =3D=3D=3D=3D=3D=3D
> > > =

> > > Subject: [PATCH net-next v3 ...]=C2=A0Multipath TCP part 2: Single su=
bflow
> =

> Should we change the title to?
> =

>   Multipath TCP part 2: Single subflow & RFC8684 support

Done!

> =

> > > v2 -> v3: Added RFC8684-style handshake and some minor fixes
> =

> Do you think that we should give more detail about this change? I mean we
> said in the previous cover letter that we were going to have 3 parts but
> here we decided to merge the last two parts.
> =

> Maybe adding something like: "(see below fore more details)"

Yes, and I added another paragraph to explain that we merged the two sets.

> =

> > > v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
> > > =

> > > This set adds MPTCP connection establishment, writing & reading MPTCP
> > > options on data packets, a sysctl to allow MPTCP per-namespace, and s=
elf
> > > tests. This is sufficient to establish and maintain a connection with=
 a
> > > MPTCP peer, but will not yet allow or initiate establishment of
> > > additional MPTCP subflows.
> > > =

> > > We also add the necessary code for the RFC8684-style handshake.
> > > RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> > > version 1.
> > > =

> > > The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> > > deployments are currently based on RFC 6824, future deployments will =
be
> > > migrating to MPTCP version 1. 3GPP's 5G standardization also solely
> > > supports RFC 8684. Also, we believe that this initial submission of
> > > MPTCP
> =

> (detail: to avoid another "Also", should we say: "In addition"?)

Done.

> =

> > > will be cleaner by solely supporting RFC 8684. If later on support for
> > > the old MPTCP-version is required it can always be added in the futur=
e.
> > > =

> > > The major difference between RFC 8684 and RFC 6824 is that it has a
> > > better
> > > support for servers using TCP SYN-cookies by reliably retransmitting =
the
> > > MP_CAPABLE option.
> > > =

> > > =

> > I forgot the Twitter reference! Matth, any good ideas for a joke? :-)
> =

> If you agree with that, I would propose to say something like this but on=
ly
> for this v3 (not after if there is no reaction) ;-)
> =

>     Before ending this cover letter with some refs, it is worth mentioning
> that we promise David Miller that merging this series will be rewarded by
> Twitter dopamine hits :-D

Looks good to me! :)

Here is the current version:

=3D=3D=3D

Subject: [PATCH net-next v3 ...]=C2=A0Multipath TCP part 2: Single subflow =
& RFC8684 support

v2 -> v3: Added RFC8684-style handshake (see below fore more details) and s=
ome minor fixes
v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series

This set adds MPTCP connection establishment, writing & reading MPTCP
options on data packets, a sysctl to allow MPTCP per-namespace, and self
tests. This is sufficient to establish and maintain a connection with a
MPTCP peer, but will not yet allow or initiate establishment of
additional MPTCP subflows.

We also add the necessary code for the RFC8684-style handshake.
RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
version 1.

Originally our plan was to submit single-subflow and RFC8684 support in
two patchsets, but to simplify the merging-process and ensure that a cohere=
nt
MPTCP-version lands in Linux we decided to merge the two sets into a single
one.

The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
deployments are currently based on RFC 6824, future deployments will be
migrating to MPTCP version 1. 3GPP's 5G standardization also solely supports
RFC 8684. In addition, we believe that this initial submission of MPTCP wil=
l be
cleaner by solely supporting RFC 8684. If later on support for the old
MPTCP-version is required it can always be added in the future.

The major difference between RFC 8684 and RFC 6824 is that it has a better
support for servers using TCP SYN-cookies by reliably retransmitting the
MP_CAPABLE option.

Before ending this cover letter with some refs, it is worth mentioning
that we promise David Miller that merging this series will be rewarded by
Twitter dopamine hits :-D

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v3-part2)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream

=3D=3D=3D


Cheers,
Christoph


--===============5572452873742896595==--
