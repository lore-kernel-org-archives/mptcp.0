Content-Type: multipart/mixed; boundary="===============0518759256024417229=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/7] mptcp: use mptcp backlog.
Date: Thu, 19 Nov 2020 12:09:16 +0100
Message-ID: <c90c96a74580a56cc2ac7ebb44712f3aa630e32f.camel@redhat.com>
In-Reply-To: 20201119094128.GE15137@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6825

--===============0518759256024417229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-19 at 10:41 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > We still own the socket, so I think its safe, but I am not sure why i=
ts
> > > needed.  Only due to GFP_KERNEL alloc in mptcp_push_pending, or is th=
ere
> > > more to it?
> > =

> > mptcp_push_pending() acquires the subflow socket lock:
> > =

> > 1) can't be invoked in atomic scope
> > 2) abba deadlock with msk socket spinlock, since the rx datapath
> > acquires the msk socket spinlock while helding the subflow socket lock.
> =

> Can you add that to the comment?  Thanks!

Ok, will do.

> > > > +	set_bit(MPTCP_NOSPACE, &msk->flags);
> > > > +	smp_mb__after_atomic(); /* msk->flags is changed by write_space c=
b */
> > > =

> > > I'm not sure why the barrier is needed.  What load/store needs the or=
dering?
> > =

> > Maybe cargo-cult c&p on my side. Now MPTCP write poll code mirrors very
> > closely TCP's one, with s/MPTCP_NOSPACE/SOCK_NOSPACE/, and retains the
> > same barriers.
> > =

> > My understanding is that is needed in the following scenario:
> > =

> > BH - CPU0				User-space CPU1
> > <rx path>				<poll>
> > =

> > <free space>				<test write space>
> > <mb>					set_bit(...)
> > if test_bit(...)			<mb>
> > 	sk_stream_write_space(sk)	<test write space>
> =

> You mean:
> =

>         set_bit(MPTCP_NOSPACE, &msk->flags);
>         smp_mb__after_atomic();
> =

> 	/* write_space might have changed right now,
> 	 * so we need to re-test.
> 	 */
>         if (sk_stream_is_writeable(sk))
>                return EPOLLOUT | EPOLLWRNORM;

Yep, I tried to be agnostic, as the same pattern works for TCP, too.

> > without the memory barrier pairs the 2nd <test write space> could
> > actually miss the update done by <frees space> and test_bit can miss
> > the set_bit() perfomed on the other side due to reordering.
> > =

> > Looks like we currently lack the mb() on the rx side ;)
> =

> Yes...

I'll add it.

> > Additionally it would be better move the sk_stream_write_space() from
> > subflow_write_space af the end of mptcp_clean_una, where wspace is
> > actually freed.
> =

> Right, there is no guarantee that we can push more data just because
> a subflow has new space.

Yep, but the current code (subflow_write_space()) checks both ssk and
msk free_space, so it should be correct.

A potential problem is that __mptcp_clean_una() can happen _after_
subflow_write_space() is invoked - when delayed to release_cb(), so we
would need a later packet to actually wake up the sender.

I'll cook v5 with all the above.

/P

--===============0518759256024417229==--
