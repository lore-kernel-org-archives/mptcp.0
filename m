Content-Type: multipart/mixed; boundary="===============0334448692420200361=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 00/10] mptcp: cleanup token code
Date: Thu, 29 Aug 2019 11:26:39 -0700
Message-ID: <353bb6b63e51866a3fc236aca7b8a973cb90739f.camel@linux.intel.com>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1763

--===============0334448692420200361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LGTM. I like the debug formatting too.

Peter.

On Thu, 2019-08-29 at 11:06 +0200, Florian Westphal wrote:
> This series again marked RFC so noone bothers to squash all of
> this into the mptcp tree.
> =

> In this second round, I've addressed all comments from Matthieu
> and Peter.  As a result, even more code was pruned from token.c
> and placed as static helper in subflow.c.
> =

> I've added a 'v2' mini-changelog to all affected patches.
> =

>  pm.c       |    6 =

>  protocol.c |    5 =

>  protocol.h |   23 +--
>  subflow.c  |  152 +++++++++++++++++++--
>  token.c    |  426 +++++++++++++++++++-----------------------------------=
-------
>  5 files changed, 277 insertions(+), 333 deletions(-)
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============0334448692420200361==--
