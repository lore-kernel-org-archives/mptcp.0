Content-Type: multipart/mixed; boundary="===============5422920440995168855=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 7/7] mptcp: implement and use MPTCP-level
 retransmission
Date: Thu, 19 Sep 2019 10:43:23 +0200
Message-ID: <8785f845f807cdee5425b7d36588016c42ee1bec.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1909182138400.40632@tvtrimel-mobl5.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1885

--===============5422920440995168855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-09-18 at 21:44 -0700, Mat Martineau wrote:
> On Wed, 11 Sep 2019, Paolo Abeni wrote:
[...]
> > +	release_sock(ssk);
> > +	sock_put(ssk);
> > +
> > +reset_unlock:
> > +	mptcp_set_timeout(sk, ssk);
> =

> mptcp_set_timeout() accesses a few members of ssk (icsk_pending and =

> icsk_timeout) when ssk is not NULL, and it looks like ssk should be locke=
d =

> when accessing those.

Thank you for the review.

You are right. I think it can be fixed simply moving the call a few
lines above.

Hopefully we can't get any really bad side effect here: UAF should not
be possible, as the last ssk reference should be released by
mptcp_close() under the msk lock. Btw if this last statemet helds we
can likely omit a good bunch of suck_hold() sock_put() in mptcp ops.

I'll send a patch after this is merged - hopefully simpler than resent
the whole series.

Cheers,

Paolo


--===============5422920440995168855==--
