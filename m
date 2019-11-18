Content-Type: multipart/mixed; boundary="===============2439212122506355459=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 13/14] sendmsg: don't restart mptcp_sendmsg_frag
Date: Mon, 18 Nov 2019 22:35:26 +0100
Message-ID: <d93aafe7ca2a65d0e0ebaafc0e0d76eb917d6068.camel@redhat.com>
In-Reply-To: 20191118121733.GB2284@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2583

--===============2439212122506355459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-18 at 13:17 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> > > This function calls do_tcp_sendpages which already has such a loop.
> > > =

> > > When tcp sendbuffer runs out of space and non-blocking io is used,
> > > do_tcp_sendpages will return early because it can't sleep.
> > > No -EAGAIN is returned, as some data was sent.
> > > =

> > > When mptcp_sendmsg_frag is called again, next call will either return
> > > -EAGAIN immediately or it will only send a few more bytes.
> > =

> > If I understand correctly, the goal here is setting the appropriate
> > return value when overall sendmsg() spooled a few bytes and than would
> > block, right? currently we can return erroneously  -EAGAIN instead of
> > the number of written bytes on some scenarios.
> =

> No, the goal is to remove useless code.  The other solution would be
> to teach mptcp_send_frag to be able to tell when it did hit EGAIN to
> exit the loop earlier, for that it would need to be able to return
> both errno and the number of queued bytes.  I didn't like adding
> another int *err argument.

I see.

I have no objections on this change.

Cheers,

Paolo

p.s. we will likely have to touch sendmsg_frag() again to fix the issue
reported by Matt.

--===============2439212122506355459==--
