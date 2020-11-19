Content-Type: multipart/mixed; boundary="===============5153923651008036853=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/7] mptcp: use mptcp backlog.
Date: Thu, 19 Nov 2020 09:36:39 +0100
Message-ID: <bd206ee992b0a8bdfe7a23dd09d4a8492bc95704.camel@redhat.com>
In-Reply-To: 20201118231107.GB15137@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6809

--===============5153923651008036853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 2020-11-19 at 00:11 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > @@ -2812,6 +2859,17 @@ static void mptcp_release_cb(struct sock *sk)
> >  {
> >  	unsigned long flags, nflags;
> >  =

> > +	/* push_pending may touch wmem_reserved, do it before the later
> > +	 * cleanup
> > +	 */
> =

> Can you expand here a bit on why the lock break is needed & safe?
> =

> We still own the socket, so I think its safe, but I am not sure why its
> needed.  Only due to GFP_KERNEL alloc in mptcp_push_pending, or is there
> more to it?

mptcp_push_pending() acquires the subflow socket lock:

1) can't be invoked in atomic scope
2) abba deadlock with msk socket spinlock, since the rx datapath
acquires the msk socket spinlock while helding the subflow socket lock.
> =

> > +	set_bit(MPTCP_NOSPACE, &msk->flags);
> > +	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
> =

> I'm not sure why the barrier is needed.  What load/store needs the orderi=
ng?

Maybe cargo-cult c&p on my side. Now MPTCP write poll code mirrors very
closely TCP's one, with s/MPTCP_NOSPACE/SOCK_NOSPACE/, and retains the
same barriers.

My understanding is that is needed in the following scenario:

BH - CPU0				User-space CPU1
<rx path>				<poll>

<free space>				<test write space>
<mb>					set_bit(...)
if test_bit(...)			<mb>
	sk_stream_write_space(sk)	<test write space>

without the memory barrier pairs the 2nd <test write space> could
actually miss the update done by <frees space> and test_bit can miss
the set_bit() perfomed on the other side due to reordering.

Looks like we currently lack the mb() on the rx side ;)

Additionally it would be better move the sk_stream_write_space() from
subflow_write_space af the end of mptcp_clean_una, where wspace is
actually freed.


> Maybe I'm blind -- nothing catches my eye either here or in
> subflow_write_space.


--===============5153923651008036853==--
