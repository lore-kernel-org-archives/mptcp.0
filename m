Content-Type: multipart/mixed; boundary="===============7823049534644625784=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 01/12] mptcp: msk is writable according to msk
 write space
Date: Tue, 04 Aug 2020 19:14:02 +0200
Message-ID: <9bc948928bd059e361e0faf6ce8cf56b519af877.camel@redhat.com>
In-Reply-To: 20200801222301.GA29169@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5473

--===============7823049534644625784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-08-02 at 00:23 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Currently, when checking for the 'msk is writable' condition,
> > we look at the individual subflows write space. That works
> > well while we sends data via a single subflow, but will not
> > as soon as we will enable concurrent xmit on multiple subflows.
> > =

> > Let's use the msk write space instead.
> =

> Why do we need MPTCP_SEND_SPACE bit after this change?

I'm testing without it, I see the following:

the msk is writable, but all the subflows have sk_stream_wspace() < 0.

The above can happen because we account the full truesize to ssk, while
only the page frag size to the msk.

Note that checking:

	sk_stream_wspace(sk) > 0 && sk_stream_is_writeable(parent)

in subflow_write_space() is not enough, we also need mptcp_poll()
returning a mask with EPOLLOUT cleared when all subflows have no write
space.

Overall I think that keeping the flag around is the simplest option.

Cheers,

Paolo

--===============7823049534644625784==--
