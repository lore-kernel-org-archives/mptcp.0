Content-Type: multipart/mixed; boundary="===============6528861087928716043=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Fri, 05 Jul 2019 15:10:39 +0200
Message-ID: <e246153d6106795f829ee5bed54bba85d5ac5e99.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1907031005390.30368@sscooper-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1473

--===============6528861087928716043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-03 at 11:10 -0700, Mat Martineau wrote:
> On Wed, 3 Jul 2019, Paolo Abeni wrote:
> =

> > Hi all,
> > =

> > [sorry for lagging behind so much, the relocation trapped me for a
> > while]
> > =

> > On Wed, 2019-06-26 at 16:11 -0700, Mat Martineau wrote:
> > > The MPTCP-level socket doesn't use sk_receive_queue, so it was possib=
le
> > > for mptcp_recvmsg() to remain blocked when there was data ready for it
> > > to read. When the MPTCP socket is waiting for additional data and it
> > > releases the subflow socket lock, the subflow may have incoming packe=
ts
> > > ready to process and it sometimes called subflow_data_ready() before =
the
> > > MPTCP socket called sk_wait_data().
> > > =

> > > This change adds new functions for the MPTCP socket to use to wait and
> > > to signal that data is ready. Atomic bitops are used to set, test, and
> > > clear a MPTCP socket flag that indicates waiting subflow data. This f=
lag
> > > replaces the sk_receive_queue checks used by other socket types.
> > > =

> > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > > ---
> > > =

> > > Squashing this into "mptcp: Implement MPTCP receive path" has a few
> > > conflicts with later commits that also fix up the receive code. It's
> > > fine to add this to the end of the commit chain.
> > > =

> > >  net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  net/mptcp/protocol.h |  4 ++++
> > >  2 files changed, 43 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 774ed25d3b6d..5555ee1529bb 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -357,6 +357,26 @@ static enum mapping_status mptcp_get_mapping(str=
uct sock *ssk)
> > >  	return ret;
> > >  }
> > > =

> > > +static void mptcp_wait_data(struct sock *sk, long *timeo)
> > > +{
> > > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > > +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > +
> > > +	add_wait_queue(sk_sleep(sk), &wait);
> > > +	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > > +
> > > +	release_sock(sk);
> > > +
> > > +	if (!test_and_clear_bit(MPTCP_DATA_READY, &msk->flags))
> > > +		*timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
> > > +
> > > +	sched_annotate_sleep();
> > > +	lock_sock(sk);
> > =

> > Can we reuse the sk_wait_event() macro here ? It would avoid a bit of
> > code duplication.
> =

> My concern there was the second condition check in sk_wait_event() (after =

> the lock is re-acquired). It looks like normal sk_wait_event() conditions =

> do not modify anything, but test_and_clear_bit() does change the flag. =

> sk_wait_event() would call test_and_clear_bit() twice, which it doesn't =

> need to do and would modify the flag an extra time. While it doesn't brea=
k =

> anything (the flag gets cleared yet again running through the recv loop), =

> I thought I'd skip the extra atomic write operation.

I think that the performance impact here would be minimal, as an atomic
op that does not update memory and operate on an already hot cacheline
is relatively cheap.

Anyhow I'm a bit concerned about possible races e.g. beween:

+               clear_bit(MPTCP_DATA_READY, &msk->flags);

in recvmsg and:

+       set_bit(MPTCP_DATA_READY, &msk->flags);

in mptcp_data_ready(). If I read the code correctly there arean't any
barriers between the pkt enqueue and set_bit, nor between clear_bit and
the pkt dequeue.

The the cpu is free to re-order e.g. the enqueue write op and the
set_bit op - same on the rx side - and we could end-up racing.

The wait_on_bit APIs use some non trivial barrier() in a similar
scenario. =


Unfortunatelly I think we can't use the wait_on_bit() APIs here, and
adding the barriering on top of this code really make me wonder if we
could use some other synchronization APIs instead.

I'd love to ear opinion from others!

Thanks,

Paolo


--===============6528861087928716043==--
