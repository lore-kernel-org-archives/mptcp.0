Content-Type: multipart/mixed; boundary="===============7379060015958932074=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 11:49:31 +0200
Message-ID: <36d92e6668d240a918436e5d5cdb38ed2fba23c9.camel@redhat.com>
In-Reply-To: 20190521090802.ypbgcfyvd2izs6fe@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1201

--===============7379060015958932074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-21 at 11:08 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > This introduces a few artifacts on the virtual network topology
> > via the netem scheduler and disabling features on some veth, so
> > that we exercise the MTCP stack more.
> =

> I would suggest to not do this unconditionally.
> =

> Perhaps we can make it so that the tests are run twice,
> once as-is and once with tc+tso off?
> =

> This way we might still catch tso-related bugs, as feature path
> is slightly different.

I thought about that. Currently we have a set of very similar test -
e.g. ns1 -> ns3, ns1 -> ns4 and the opposite directions should be
basically the same, with a little higher latencies for ns1<->ns4
compared to ns1 <-> ns3

With the proposed patch we still have some tests with no artifact (ns1
-> ns2) but we effectively lose the forwarding scenario with no
artifact.

I'd like to avoid the excessive grow (in term of time) of these tests.

What if we remove a ns (ns4) and we do 2 iteration of the remaining,
one with no TC/with TSO and the other with such artifacts?

The total number of tests should not change and we would cover any
scenario.

WDYT?

thanks,

Paolo


--===============7379060015958932074==--
