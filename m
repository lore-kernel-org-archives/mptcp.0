Content-Type: multipart/mixed; boundary="===============4876981009490073149=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next 2/3] mptcp: rework poll+nospace handling
Date: Sun, 06 Sep 2020 19:55:31 +0200
Message-ID: <20200906175531.GN7319@breakpoint.cc>
In-Reply-To: a4428c99de218ce78a6128d34e388910dce1dba6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5737

--===============4876981009490073149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Sat, 2020-09-05 at 12:33 +0200, Florian Westphal wrote:
> > At this time, MPTCP maintains a status bit, MPTCP_SEND_SPACE,
> > that is set when at least one subflow and the mptcp socket itself
> > are writeable.
> > =

> > poll path set EPOLLOUT if the bit is set.
> > sendmsg path makes sure MPTCP_SEND_SPACE gets cleared when last
> > write has used up all subflows or the mptcp socket wmem.
> > =

> > This reworks nospace handling as follows:
> > =

> > MPTCP_SEND_SPACE is replaced with MPTCP_NOSPACE.
> > This bit is set when the mptcp socket is not writeable anymore
> > and makes the mptcp-level ack path schedule the mptcp worker.
> > =

> > This is needed to wake up userspace processes that wait for a POLLOUT
> > event.
> > =

> > sendmsg will set MPTCP_NOSPACE only when it has to wait for more
> > wmem (blocking I/O case).
> > =

> > poll path will also set MPTCP_NOSPACE in case the mptcp socket
> > is not writeable.
> > =

> > Normal tcp-level notification (SOCK_NOSPACE) is only enabled
> > in case the subflow socket has no available wmem.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 98 ++++++++++++++++++++++++++++++--------------
> >  net/mptcp/protocol.h |  2 +-
> >  net/mptcp/subflow.c  | 11 +++--
> >  3 files changed, 74 insertions(+), 37 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 15ecb471602c..bc5231d5b06d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -680,10 +680,12 @@ static void mptcp_reset_timer(struct sock *sk)
> >  =

> >  void mptcp_data_acked(struct sock *sk)
> >  {
> > +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > +
> >  	mptcp_reset_timer(sk);
> >  =

> > -	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
> > -	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
> > +	if ((test_bit(MPTCP_NOSPACE, &msk->flags) ||
> > +	    (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
> >  	    schedule_work(&mptcp_sk(sk)->work))
> >  		sock_hold(sk);
> >  }
> > @@ -841,12 +843,7 @@ static void mptcp_clean_una(struct sock *sk)
> >  =

> >  	/* Only wake up writers if a subflow is ready */
> >  	if (mptcp_is_writeable(msk)) {
> > -		set_bit(MPTCP_SEND_SPACE, &msk->flags);
> > -		smp_mb__after_atomic();
> > -
> > -		/* set SEND_SPACE before sk_stream_write_space clears
> > -		 * NOSPACE
> > -		 */
> > +		clear_bit(MPTCP_NOSPACE, &msk->flags);
> >  		sk_stream_write_space(sk);
> >  	}
> >  }
> > @@ -1038,21 +1035,37 @@ static int mptcp_sendmsg_frag(struct sock *sk, =
struct sock *ssk,
> >  	return ret;
> >  }
> >  =

> > -static void mptcp_nospace(struct mptcp_sock *msk)
> > +/* set SOCK_NOSPACE for any subflow that has no more wmem.
> > + *
> > + * Returns true if at least one subflow is writeable.
> > + */
> > +static bool mptcp_set_subflow_nospace(struct mptcp_sock *msk)
> >  {
> >  	struct mptcp_subflow_context *subflow;
> > -
> > -	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> > -	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
> > +	bool ssk_any_writeable =3D false;
> >  =

> >  	mptcp_for_each_subflow(msk, subflow) {
> =

> Not strictly related to this patch, but perhpas we need a =

> __mptcp_flush_join_list() call before traversing the subflow list?!?

Yes, I think it makes sense to update the list here.

> > -		mptcp_nospace(msk);
> > +		__mptcp_check_writeable(msk);
> > +
> =

> Again not strictily related to this patch, but currently we start
> sleeping/blocking if msk/ssk are not writeable.
> =

> I think we should do that instead when !sk_stream_memory_free() ?!?

Do what?  Sleep only if mptcp socket has not enough wspace?
We can do that, requires change to mptcp_sendmsg to append to rtx queue
(and make sure retrans timer is on), also see my other reply.

Is that what you meant?

> > +	slow =3D lock_sock_fast(sk);
> > +	if (__mptcp_check_writeable(msk))
> > +		ret =3D EPOLLOUT | EPOLLWRNORM;
> > +
> > +	unlock_sock_fast(sk, slow);
> =

> It's a pity we need to acquire the lock in mptcp_poll()... perhaps we
> could try to acquire it only if sk_stream_is_writeable(msk)?

I think we need to determine desired behaviour of send path when no ssk is =
ready
(but mptcp sk has wspace).  I think we should change it to queue the
data even if no ssk is available (but wmem permits it).  Then we could
simplify poll too, as ssk state becomes irrelevant.

> > +	if (sock)
> > +		clear_bit(SOCK_NOSPACE, &sock->flags);
> =

> for server socket 'sock' is 'shared' among all the subflows (ssk-
> >sk_socket points to the same data). The above is disabling write space
> notification on all subflows, is that intended/correct?

Yes, current sendmsg path accepts data if mptcp socket has wmem and one
subflow is ready, so it only sleeps if mptcp wmem is also exhausted.

And for that, the MPTCP_NOSPACE bit has been toggled so next data-ack
wakes a blocking poll or blocking sendmsg.

> > +
> > +	sk_stream_write_space(parent);
> =

> If I read correctly, this means that the msk could be woken-up even if
> not writeable (a subflow is writeable, but msk does not have enough
> wirte space), am I correct? =


No, this is in a mptcp_is_writeable() conditional so msk has enough
wmem.  My main takeaway from your response is that I should rework this
towards making the mptcp write buffer space the only relevant criteria
wrt. when to signal/wake userspace.

Does that sound good to you?
--===============4876981009490073149==--
