Content-Type: multipart/mixed; boundary="===============3665629393751697017=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 13/14] sendmsg: don't restart mptcp_sendmsg_frag
Date: Mon, 18 Nov 2019 13:17:33 +0100
Message-ID: <20191118121733.GB2284@breakpoint.cc>
In-Reply-To: 2fc61169c91b89ff9e096f18dc27f38ac53cb25b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2579

--===============3665629393751697017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> > This function calls do_tcp_sendpages which already has such a loop.
> > =

> > When tcp sendbuffer runs out of space and non-blocking io is used,
> > do_tcp_sendpages will return early because it can't sleep.
> > No -EAGAIN is returned, as some data was sent.
> > =

> > When mptcp_sendmsg_frag is called again, next call will either return
> > -EAGAIN immediately or it will only send a few more bytes.
> =

> If I understand correctly, the goal here is setting the appropriate
> return value when overall sendmsg() spooled a few bytes and than would
> block, right? currently we can return erroneously  -EAGAIN instead of
> the number of written bytes on some scenarios.

No, the goal is to remove useless code.  The other solution would be
to teach mptcp_send_frag to be able to tell when it did hit EGAIN to
exit the loop earlier, for that it would need to be able to return
both errno and the number of queued bytes.  I didn't like adding
another int *err argument.

> I think that there is a side effect with this change: before a
> blocking, successful, write(<large val>) would always return <large
> val>,

Yes.

> After this patch it will return min(<large val>, <max skb size>), as
> mptcp_sendmsg_frag() is limited to a single skb.
> =

> Do we want to preserve the old behavior?

TCP doesn't guarantee that it consumes entire buffer either, why would
mptcp try to?
--===============3665629393751697017==--
