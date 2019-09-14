Content-Type: multipart/mixed; boundary="===============3682194690567558601=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to
 userspace
Date: Sat, 14 Sep 2019 12:09:02 +0200
Message-ID: <20190914100902.GH10656@breakpoint.cc>
In-Reply-To: c2abb5d4494fb687eb394f7e5b90c35ee01060e2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1847

--===============3682194690567558601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> wrote:
> On Thu, 2019-09-12 at 18:50 +0200, Davide Caratti wrote:
> > add ulp-specific diagnostic functions, so that subflow information can =
be
> > dumped to userspace programs like 'ss'.
> =

> for the record: iproute2 support is also on the way, but also in this case
> the first step will be in ktls. This patch exposes token, local/remote
> keys, and some of the bitfield members. What do you think it's reasonable
> exposing to users of 'ss -i' ?

The MPTCP (parent/meta) socket data, e.g. the DSS would be good.

Once Paolo retrans is in, we could also extend that to expose
information about MPTCP-Level events (rather than subflow stats).

This is a great start though.  I guess it might be good to expose
how much more data the current mapping expects.

Wrt. local/remote keys, what is the use case?

I'm asking because some people get nervous when you add an api to
expose 'secret keys'.

If there is no clear use-case i'd rather not expose them for now,
it can be added later if needed.

--===============3682194690567558601==--
