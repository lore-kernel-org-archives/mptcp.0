Content-Type: multipart/mixed; boundary="===============6846396082754954148=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 13/14] sendmsg: don't restart mptcp_sendmsg_frag
Date: Mon, 18 Nov 2019 13:11:11 +0100
Message-ID: <2fc61169c91b89ff9e096f18dc27f38ac53cb25b.camel@redhat.com>
In-Reply-To: 20191114173225.21199-14-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2577

--===============6846396082754954148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> This function calls do_tcp_sendpages which already has such a loop.
> =

> When tcp sendbuffer runs out of space and non-blocking io is used,
> do_tcp_sendpages will return early because it can't sleep.
> No -EAGAIN is returned, as some data was sent.
> =

> When mptcp_sendmsg_frag is called again, next call will either return
> -EAGAIN immediately or it will only send a few more bytes.

If I understand correctly, the goal here is setting the appropriate
return value when overall sendmsg() spooled a few bytes and than would
block, right? currently we can return erroneously  -EAGAIN instead of
the number of written bytes on some scenarios.

I think that there is a side effect with this change: before a
blocking, successful, write(<large val>) would always return <large
val>,

After this patch it will return min(<large val>, <max skb size>), as
mptcp_sendmsg_frag() is limited to a single skb.

Do we want to preserve the old behavior?

Cheers,

Paolo

--===============6846396082754954148==--
