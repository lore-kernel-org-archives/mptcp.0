Content-Type: multipart/mixed; boundary="===============4565773943400270999=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 09 Feb 2021 11:16:46 +0100
Message-ID: <20210209101646.GJ16570@breakpoint.cc>
In-Reply-To: e48e9c4f2328275779a7c54409764e4d5018ad34.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7698

--===============4565773943400270999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2021-02-09 at 00:47 +0100, Florian Westphal wrote:
> if the actual close is also in charge of subflow accounting (and
> subflow limits enforcing), likely there will be no issue. If subflow
> accounting is done at NL event generation time, a malicius peer could
> open/close a subflow multiple times and "leeking" (not really leaking,
> but still cause allocation with no free) a lot of subflow on this side.

No, event generation should do just that, emit the mcast event, no
accounting or similar.

> > > Side note: it would be nice using the deferred actions to do the
> > > netlink call, to avoid the workqueue usage.
> > =

> > Why?  How many events/s do you expect?
> =

> At least one per msk connection, I think. On a busy server with an high
> ingress connection rate is likely significant. Yes, DATA_FIN (ack) will
> weight twice (or 4x) more, so I think we should use delegated action
> even for that ;) =


Compared to packet processing they are likely not relevant, but see
below.

> > Events try to prefer GFP_KERNEL allocations where possible.
> =

> yep, that is relevant. Delegated actions are handled at msk release_cb
> time - depending on the lock status when they are fires - even in non
> atomic/process context. We could use GFP_KERNEL when triggering the
> event from release_cb and ATOMIC elsewhere. Would that inconsistency be
> acceptable?

The function already provides a gfp_t arg, there are spots where event
happens from atomic context.

> I have some related patches "cleaning-up" mptcp_release_cb that I'll
> hopefully share soon.

Ok, will have a l ook.

> Or perhaps we could check for genl_has_listeners() before scheduling
> the workqueue?

I think thats a good idea, however, the idea was not just to kick the
event but also do the actual socket close, so if we don't sched the wq
the ssk will stay around until msk close time, no?
--===============4565773943400270999==--
