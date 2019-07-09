Content-Type: multipart/mixed; boundary="===============2520158251357708802=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: harmonize locking on all socket
 operations.
Date: Tue, 09 Jul 2019 12:00:20 +0200
Message-ID: <20190709100020.5zbyi4oyhrbj3ato@breakpoint.cc>
In-Reply-To: b2543913dce2fa3b501537ce5e71a6b280b984d9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1477

--===============2520158251357708802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-07-08 at 17:20 -0700, Peter Krystad wrote:
> > Thanks for this patch, I agree some work on the locking was required.
> > As a general comment I wonder if the structure would be more clear if
> > the usage of the msk->subflow field had not been overloaded, currently =
it can
> > point to either an subflow that is an in-progress outgoing connection, a
> > regular TCP socket (fallback case, empty msk->conn_list implied) or a s=
ocket =

> > listening for incoming connections. Do you think splitting this into mu=
ltiple

Yes, I think it would help.

I'd like to get rid if the "fallback case", lets see if that works out.
That leaves "in-progress outgoing" and "listening for incoming" cases.

> I agree that the current subflow usage is a bit confusing. AFAIK
> Florian is currently looking into cleaning subflow usage. But he is at =

> a conference (NFWS) and then on holiday, so his replies will be
> delayed, I guess ;)

Yes, I will likely not be able to work on it until start of august.

> I hope that this two tasks can be orthogonal/carried on concurrently.

Yes, don't wait for me, please just go ahead with your patch.

--===============2520158251357708802==--
