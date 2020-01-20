Content-Type: multipart/mixed; boundary="===============5955096940366956861=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: [martineau:kbuild-mptcp 22/38] subflow.c:undefined
 reference to `__crypto_memneq'
Date: Mon, 20 Jan 2020 17:20:41 +0100
Message-ID: <20200120162041.GD795@breakpoint.cc>
In-Reply-To: 48a83812-3670-ed88-7a75-7ea0a1c86438@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3434

--===============5955096940366956861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > > I prefer selecting CRYPTO over copy/paste.
> > =

> > I agree with 'select CRYPTO=3Dy'
> =

> Me too.
> =

> Florian: do you ask the question because you think we can have issues or
> comments from net maintainers when forcing the selection of CRYPTO for
> MPTCP?

I think its fine, tcpmd5 and ipsec select it too.

> Do we plan to do this modification in "mptcp: Add handling of incoming
> MP_JOIN requests" commit (part 3) or before (part 2, when starting using
> functions from CRYPTO, e.g. "mptcp: Add key generation and token tree")?

I'm currently travelling so I can't comment which commit makes the most
sense.  It should be added when the first crypto functions are used, I
think.
--===============5955096940366956861==--
