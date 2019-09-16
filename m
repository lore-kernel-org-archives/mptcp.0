Content-Type: multipart/mixed; boundary="===============6829676539815815761=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/4] mptcp sparse "fixes"
Date: Mon, 16 Sep 2019 13:43:45 -0700
Message-ID: <6fdfba964c0e7455f3992ec2bfdcd3680c8e9665.camel@linux.intel.com>
In-Reply-To: 20190909231725.4952-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1854

--===============6829676539815815761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Florian -

This all looks good to me, thanks.

Peter.

On Tue, 2019-09-10 at 01:17 +0200, Florian Westphal wrote:
> NB: these patches don't fix anything because nothing is broken.
> =

> The "sparse" checker complains about various constructs, this fixes
> some of those.  All of these can be squashed, I've
> placed the name of the target commit in the change logs.
> =

> There are more sparse warnings in the code base, I am intentionally
> skipping those for now as its in code that is still "in flux".
> =

> For example the icsk ulp data pointer now has an __rcu annotation upstream
> so sparse complains because we don't use rcu_dereference() or similar.
> =

> In any case, I think those can be fixed once the code has stabilized more.
> I am sending these now because they are in more "mature" areas and it
> reduces the delta between my working tree and the "export" branch.
> =

> Thanks,
> Florian
> =

>  crypto.c   |    2 ++
>  options.c  |    4 ++--
>  pm.c       |    2 +-
>  protocol.h |    2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============6829676539815815761==--
