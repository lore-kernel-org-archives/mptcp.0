Content-Type: multipart/mixed; boundary="===============6347463277335254902=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Part 2 - Cover Letter
Date: Fri, 17 Jan 2020 09:11:41 -0800
Message-ID: <20200117171141.GA30818@MacBook-Pro-64.local>
In-Reply-To: 6fc92b1e-99b5-ba7b-0d55-96b079b6c3fd@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3400

--===============6347463277335254902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 17/01/20 - 17:32:21, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On 17/01/2020 17:12, Christoph Paasch wrote:
> =

> [...]
> =

> > Here is the current version:
> =

> Thank you for this v2!
> =

> > =3D=3D=3D
> > =

> > Subject: [PATCH net-next v3 ...]=C2=A0Multipath TCP part 2: Single subf=
low & RFC8684 support
> > =

> > v2 -> v3: Added RFC8684-style handshake (see below fore more details) a=
nd some minor fixes
> > v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
> > =

> > This set adds MPTCP connection establishment, writing & reading MPTCP
> > options on data packets, a sysctl to allow MPTCP per-namespace, and self
> > tests. This is sufficient to establish and maintain a connection with a
> > MPTCP peer, but will not yet allow or initiate establishment of
> > additional MPTCP subflows.
> > =

> > We also add the necessary code for the RFC8684-style handshake.
> > RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> > version 1.
> > =

> > Originally our plan was to submit single-subflow and RFC8684 support in
> > two patchsets, but to simplify the merging-process and ensure that a co=
herent
> > MPTCP-version lands in Linux we decided to merge the two sets into a si=
ngle
> > one.
> > =

> > The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> > deployments are currently based on RFC 6824, future deployments will be
> > migrating to MPTCP version 1. 3GPP's 5G standardization also solely sup=
ports
> > RFC 8684. In addition, we believe that this initial submission of MPTCP=
 will be
> > cleaner by solely supporting RFC 8684. If later on support for the old
> > MPTCP-version is required it can always be added in the future.
> > =

> > The major difference between RFC 8684 and RFC 6824 is that it has a bet=
ter
> > support for servers using TCP SYN-cookies by reliably retransmitting the
> > MP_CAPABLE option.
> > =

> > Before ending this cover letter with some refs, it is worth mentioning
> > that we promise David Miller that merging this series will be rewarded =
by
> > Twitter dopamine hits :-D
> =

> Sorry, I maybe added too many "that":
> =

>     (...) it is worth mentioning ~that~ we promise David Miller that merg=
ing
> this series (...)

Hmmm... removing the that makes it sound incorrect to me though. I don't
know... :)

Maybe some of the native speakers here have a better wording ;-)


Christoph

> =

> (feel free to fix English issues :) )
> =

> The rest looks good to me!
> =

> Cheers,
> Matt
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6347463277335254902==--
