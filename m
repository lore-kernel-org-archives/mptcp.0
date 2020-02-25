Content-Type: multipart/mixed; boundary="===============6063314446670176930=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 8/8] mptcp: defer work schedule until
 mptcp lock is released
Date: Tue, 25 Feb 2020 15:53:36 +0100
Message-ID: <134191ed6e2bbd67ee36a7ac415ee54ef4f9f505.camel@redhat.com>
In-Reply-To: 20200225125408.GK19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3787

--===============6063314446670176930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 13:54 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Tue, 2020-02-25 at 13:05 +0100, Florian Westphal wrote:
> > > Don't schedule the work queue right away, instead defer this
> > > to the lock release callback.
> > > =

> > > This has the advantage that it will give recv path a chance to
> > > complete -- this might have moved all pending packets from the
> > > subflow to the mptcp receive queue, which allows to avoid another
> > > schedule_work().
> > > =

> > > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > > ---
> > >  net/mptcp/protocol.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index de6bd9d28116..f7c0d205b047 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -240,8 +240,15 @@ void mptcp_data_ready(struct sock *sk, struct so=
ck *ssk)
> > >  		return;
> > >  =

> > >  	/* mptcp socket is busy, schedule worker */
> > > -	if (schedule_work(&msk->work))
> > > -		sock_hold((struct sock *)msk);
> > > +	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
> > > +			      &sk->sk_tsq_flags)) {
> > > +		sock_hold(sk);
> > =

> > Here is the msk/sk socket lock always held by some other process?
> =

> Yes, why?
> =

> > I think the trylock in patch 6 from different subflows can collide with
> > each other, so a try lock can fail even with !sk->sk_lock.owned
> =

> Not following, sorry.

I mean something alike

CPU0 (subflow 0)		CPU1 (subflow 1)
trylock				trylock
// enqueue the			// lock busy =

// data	=

				test_and_set_bit(TCP_DELACK_TIMER_DEFERRED)

but nobody will call mptcp_release_cb() soon.

> > Or the process owning the msk sock lock when the previous check has
> > been done can release it in the meanwhile.
> =

> Yes, why?
> =

> > In one of the above happens, can the TCP_DELACK_TIMER_DEFERRED delayed
> > for a long time? Do we need to address that scenario?
> =

> Hmm:
>         /* mptcp socket is busy, schedule worker */
>         if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
>                               &sk->sk_tsq_flags)) {
>                 sock_hold(sk);
> =

>                 /* need to try again, its possible release_cb() has alrea=
dy
>                  * been called after the test_and_set_bit() above.
>                  */
>                 move_skbs_to_msk(msk, ssk);
>         }
> =

> I thought the last move_skbs_to_msk() would address that?
> (If it fails, msk is still owned so release cb will be called 'soon').

Thank for pointing this out! I underlooked this part. It looks like the
2nd scenario I feared is not possible!

I'm unsure about the first one ?!? can the move_skbs_to_msk() above =

still race with another subflows ?!?

Thanks,

Paolo




--===============6063314446670176930==--
