Content-Type: multipart/mixed; boundary="===============9221137016526419001=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/7] mptcp: use mptcp backlog.
Date: Thu, 19 Nov 2020 10:41:28 +0100
Message-ID: <20201119094128.GE15137@breakpoint.cc>
In-Reply-To: bd206ee992b0a8bdfe7a23dd09d4a8492bc95704.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6810

--===============9221137016526419001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > We still own the socket, so I think its safe, but I am not sure why its
> > needed.  Only due to GFP_KERNEL alloc in mptcp_push_pending, or is there
> > more to it?
> =

> mptcp_push_pending() acquires the subflow socket lock:
> =

> 1) can't be invoked in atomic scope
> 2) abba deadlock with msk socket spinlock, since the rx datapath
> acquires the msk socket spinlock while helding the subflow socket lock.

Can you add that to the comment?  Thanks!

> > > +	set_bit(MPTCP_NOSPACE, &msk->flags);
> > > +	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb =
*/
> > =

> > I'm not sure why the barrier is needed.  What load/store needs the orde=
ring?
> =

> Maybe cargo-cult c&p on my side. Now MPTCP write poll code mirrors very
> closely TCP's one, with s/MPTCP_NOSPACE/SOCK_NOSPACE/, and retains the
> same barriers.
> =

> My understanding is that is needed in the following scenario:
> =

> BH - CPU0				User-space CPU1
> <rx path>				<poll>
> =

> <free space>				<test write space>
> <mb>					set_bit(...)
> if test_bit(...)			<mb>
> 	sk_stream_write_space(sk)	<test write space>

You mean:

        set_bit(MPTCP_NOSPACE, &msk->flags);
        smp_mb__after_atomic();

	/* write_space might have changed right now,
	 * so we need to re-test.
	 */
        if (sk_stream_is_writeable(sk))
               return EPOLLOUT | EPOLLWRNORM;

> without the memory barrier pairs the 2nd <test write space> could
> actually miss the update done by <frees space> and test_bit can miss
> the set_bit() perfomed on the other side due to reordering.
> =

> Looks like we currently lack the mb() on the rx side ;)

Yes...

> Additionally it would be better move the sk_stream_write_space() from
> subflow_write_space af the end of mptcp_clean_una, where wspace is
> actually freed.

Right, there is no guarantee that we can push more data just because
a subflow has new space.
--===============9221137016526419001==--
