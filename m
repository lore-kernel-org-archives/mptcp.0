Content-Type: multipart/mixed; boundary="===============4963690951304513824=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 12:51:41 +0200
Message-ID: <20190521105141.6zcptk6sog4qt42r@breakpoint.cc>
In-Reply-To: 36d92e6668d240a918436e5d5cdb38ed2fba23c9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1202

--===============4963690951304513824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2019-05-21 at 11:08 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > This introduces a few artifacts on the virtual network topology
> > > via the netem scheduler and disabling features on some veth, so
> > > that we exercise the MTCP stack more.
> > =

> > I would suggest to not do this unconditionally.
> > =

> > Perhaps we can make it so that the tests are run twice,
> > once as-is and once with tc+tso off?
> > =

> > This way we might still catch tso-related bugs, as feature path
> > is slightly different.
> =

> I thought about that. Currently we have a set of very similar test -
> e.g. ns1 -> ns3, ns1 -> ns4 and the opposite directions should be
> basically the same, with a little higher latencies for ns1<->ns4
> compared to ns1 <-> ns3
> =

> With the proposed patch we still have some tests with no artifact (ns1
> -> ns2) but we effectively lose the forwarding scenario with no
> artifact.
> =

> I'd like to avoid the excessive grow (in term of time) of these tests.

Ah, thats right, we still have it enabled on other netns.

OK, thats fine then.

> What if we remove a ns (ns4) and we do 2 iteration of the remaining,
> one with no TC/with TSO and the other with such artifacts?

Thats another option, but I don't have a preference, your change is fine
as-is.

--===============4963690951304513824==--
