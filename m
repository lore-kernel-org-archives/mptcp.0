Content-Type: multipart/mixed; boundary="===============1359825804973780100=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Fri, 27 Sep 2019 17:51:06 +0200
Message-ID: <20190927155106.GH9938@breakpoint.cc>
In-Reply-To: 0be9a3a0-5ced-d826-3fbc-79d4da477e61@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1939

--===============1359825804973780100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Hi Paolo,
> =

> On 26/09/2019 19:20, Paolo Abeni wrote:
> > On Thu, 2019-09-26 at 17:05 +0200, Florian Westphal wrote:
> =

> [...]
> =

> >> from Paolo.
> >>
> >> But I figured it would make sense to share this now and discuss
> >> how to proceed from here first.
> > =

> > The above branch is based on mptcp_net-next export branch hash
> > a45bdbe6701b
> =

> Great, still the last one. So everything is in it.
> =

> > There is a small diff vs such hash, see below. Mostily checkpack fixes,
> > a trivial functional fix in mptcp_setsockopt(), and a bunch of likely
> > not interesting debug messages dropped - side note: we may want remove
> > more of them.
> =

> I guess that we indeed need to remove most of these pr_debug() at some
> points. Thank you for having done that!
> Also great to have looked at checkpatch and making sure each commit can
> compile :-)
> =

> For the fix in mptcp_setsockopt(), was it due to a bad "squash"?

No, that is intentional -- I don't think returning 0 when nothing
was done is good.

I can fold Peters mptcp prefix patch for crypto where needed and push a
v2, let me know.

Thanks.

--===============1359825804973780100==--
