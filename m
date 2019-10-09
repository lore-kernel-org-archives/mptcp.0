Content-Type: multipart/mixed; boundary="===============4861990498681337931=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: mib: fix sparse warnings
Date: Wed, 09 Oct 2019 19:48:10 +0200
Message-ID: <8569f74d-ccc3-c063-a655-58ad95f1df56@tessares.net>
In-Reply-To: 20191009144703.30196-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2075

--===============4861990498681337931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 09/10/2019 16:47, Florian Westphal wrote:
> squashto: mptcp: add MIB counter infrastructure
> =

> get rid of:
> mib.c:31:33: sparse: warning: incorrect type in initializer (different ad=
dress spaces)
> mib.c:31:33: sparse:    expected struct mptcp_mib *mib
> mib.c:31:33: sparse:    got struct mptcp_mib [noderef] <asn:3> *
> mib.c:36:13: sparse: warning: incorrect type in initializer (different ad=
dress spaces)
> mib.c:36:13: sparse:    expected struct mptcp_mib [noderef] <asn:3> *__new
> mib.c:36:13: sparse:    got struct mptcp_mib *mib
> mib.c:37:29: sparse: warning: incorrect type in argument 1 (different add=
ress spaces)
> mib.c:37:29: sparse:    expected void [noderef] <asn:3> *__pdata
> mib.c:37:29: sparse:    got struct mptcp_mib *mib
> mib.c:42:6: sparse: warning: symbol 'mptcp_seq_show' was not declared. Sh=
ould it be static?
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for having looked at that!

Looks good to me!

- a46ee3d7aafa: "squashed" in "mptcp: add MIB counter infrastructure"
- signed-off already there
- 8b829e9415cf..140091ac68c1: result

Tests are still OK.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4861990498681337931==--
