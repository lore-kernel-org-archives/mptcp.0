Content-Type: multipart/mixed; boundary="===============7785948496251615457=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Tue, 27 Aug 2019 17:13:48 -0700
Message-ID: <37a464035422e94ef7e9e3330451c479ea7eaa4c.camel@linux.intel.com>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1726

--===============7785948496251615457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Thanks for doing this Florian.

I feel somewhat guilty providing a few suggestions regarding how you re-
factored this code, please see individual PATCH comments.

Peter.

On Sun, 2019-08-25 at 20:59 +0200, Florian Westphal wrote:
> This series is intentionally marked RFC so noone bothers
> to squash all of this into the mptcp tree.
> =

> The idea is to first do a review-friendly series, with
> each change done in an individual patch.
> =

> Then, once consensus is reached (maybe over several iterations),
> I would send a few larger patches suitable for squashing (rather
> than being review friendly...).
> =

> The patches remove unneeded small helpers, add 'mptcp' prefix
> to non-static functions, add error handling to those that may
> fail and adds a few comments.
> =

> Feedback welcome.
> =

>  pm.c       |    6 =

>  protocol.c |    5 =

>  protocol.h |   27 +--
>  subflow.c  |   76 ++++++++--
>  token.c    |  447 +++++++++++++++++++++++++++---------------------------=
-------
>  5 files changed, 278 insertions(+), 283 deletions(-)
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============7785948496251615457==--
