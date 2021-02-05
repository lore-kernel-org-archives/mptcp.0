Content-Type: multipart/mixed; boundary="===============8796546231048853660=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: better msk receive window updates
Date: Fri, 05 Feb 2021 12:47:47 +0100
Message-ID: <fcdc881ffcbb714ca8693f3c2cbfd15f623d969c.camel@redhat.com>
In-Reply-To: d19542587611b4c1b841e5e37c3d2432e516a59e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7634

--===============8796546231048853660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-05 at 09:26 +0100, Paolo Abeni wrote:
> On Thu, 2021-02-04 at 23:23 +0100, Paolo Abeni wrote:
> > Move mptcp_cleanup_rbuf() related checks inside the mentioned
> > helper and extend them to mirror more closely TCP ones. To implement
> > them we need to track the subflows mss and the ack_seq delta.
> > Do not relay anymore on tcp_cleanup_rbuf() and send ack explicitly.
> =

> The more I think a about this, the more it looks like a workaround
> instead of a real fix for the still vague root cause. Please keep this
> on-hold.

This is targeting issues/147.

The timeout happens on monodirectional connections (the other way has
already shutdown) when the sender fills completely the MPTCP snd wnd
and the peer, by it's own logic -
mptcp_cleanup_rbuf()+tcp_cleanup_rbuf(), decides to not send the ack
after that for the chunk filling the window has been read by the user-
space.

The above should be possible even for plain TCP, where retransmission
will save the day - but I was unable to trigger that scenario easily.

In teory, even MPTCP level retransmissions should kick-in, but the
current pkt scheduler implementation for re-injection
(mptcp_subflow_get_retrans) always decice to do nothing, as the subflow
is _not_ in a lossy CA state.

I'm unsure how to proceeed. The proposed patch should address the
issue, but likely introduces a lot of unneeded acks and is quite an
hack.

A possible alternative would be scheduling 0win probes even with
pending data - likely an even uglier hack.

Or we could rework mptcp_subflow_get_retrans() to fit this scenario,
but that will possibly (likely???) break active backup.

Or ... ????

Any suggestion more then welcome!

/P

--===============8796546231048853660==--
