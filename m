Content-Type: multipart/mixed; boundary="===============3612880694736115984=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: bugfix for RM_ADDR option parsing
Date: Mon, 08 Jun 2020 18:59:29 +0800
Message-ID: <20200608105929.GA24487@OptiPlex>
In-Reply-To: 41246875-febc-e88d-304b-2a6692f590ac@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4605

--===============3612880694736115984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 12:10:23PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> =

> On 08/06/2020 09:48, Geliang Tang wrote:
> > In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
> > "Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:
> > =

> >    +-------+-------+---------------+
> >    |Subtype|(resvd)|   Address ID  |
> >    +-------+-------+---------------+
> >    |               |
> >   ptr            ptr+1
> > =

> > We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This pa=
tch
> > will fix this bug.
> =

> Thank you for the patch, good catch!
> Indeed "ptr" should be incremented.
> =

> Because this is a bug-fix for net, may you clearly indicate that in the
> subject to help -net maintainers please? [PATCH net v2]
> =

> Also, may you add a "Fixes" tag as well as it is for -net ? I guess it
> should be:
> =

>     Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
> =

> The rest is good!
> =

> Cheers,
> Matt
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Hi Matt,

Thanks for your reply.

I have already resend patch v2 to you.

-Geliang
--===============3612880694736115984==--
