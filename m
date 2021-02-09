Content-Type: multipart/mixed; boundary="===============8064956320653312611=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 09 Feb 2021 10:49:05 +0100
Message-ID: <e48e9c4f2328275779a7c54409764e4d5018ad34.camel@redhat.com>
In-Reply-To: 20210208234751.GI16570@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7696

--===============8064956320653312611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-09 at 00:47 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > In case of fallback, the subflow can be closed by the peer while there
> > are data pending in the subflow receive queue. Calling
> > mptcp_close_subflow() will discard such data and will corrupt the
> > stream.
> =

> This.
> =

> > I think that scenario is possible even with full msk, if the peer
> > closes a single subflow while the msk is still alive (before DATA_FIN).
> =

> You mean because there might be unprocessed data in subflow rx
> queue?

Yes. With the fallback scenario it happens quite easily. I think
because the subflow finds the msk receive queue exceeding msk-
>sk_rcvbuf, but I really did not investigate that much.

> > Or the NL event generation cold be de-coupled from the actual subflow
> > close() but I fear some side effect even there.
> =

> Hmm, why?

if the actual close is also in charge of subflow accounting (and
subflow limits enforcing), likely there will be no issue. If subflow
accounting is done at NL event generation time, a malicius peer could
open/close a subflow multiple times and "leeking" (not really leaking,
but still cause allocation with no free) a lot of subflow on this side.

> > Side note: it would be nice using the deferred actions to do the
> > netlink call, to avoid the workqueue usage.
> =

> Why?  How many events/s do you expect?

At least one per msk connection, I think. On a busy server with an high
ingress connection rate is likely significant. Yes, DATA_FIN (ack) will
weight twice (or 4x) more, so I think we should use delegated action
even for that ;) =


> Events try to prefer GFP_KERNEL allocations where possible.

yep, that is relevant. Delegated actions are handled at msk release_cb
time - depending on the lock status when they are fires - even in non
atomic/process context. We could use GFP_KERNEL when triggering the
event from release_cb and ATOMIC elsewhere. Would that inconsistency be
acceptable?

I have some related patches "cleaning-up" mptcp_release_cb that I'll
hopefully share soon.

Or perhaps we could check for genl_has_listeners() before scheduling
the workqueue?

/P

--===============8064956320653312611==--
