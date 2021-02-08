Content-Type: multipart/mixed; boundary="===============5395144629119250235=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 09 Feb 2021 00:47:51 +0100
Message-ID: <20210208234751.GI16570@breakpoint.cc>
In-Reply-To: c0d75ae27fc7f93e57d470458df9e5c043e75a9a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7690

--===============5395144629119250235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b8b670cb6116..57f6361eb07c 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1413,6 +1413,13 @@ static void subflow_state_change(struct sock *sk)
> >  	if (mptcp_subflow_data_available(sk))
> >  		mptcp_data_ready(parent, sk);
> >  =

> > +	if (sk->sk_state =3D=3D TCP_CLOSE &&
> > +	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(parent)->fl=
ags)) {
> > +		sock_hold(parent);
> > +		if (!schedule_work(&mptcp_sk(parent)->work))
> > +			sock_put(parent);
> > +	}
> > +
> =

> Looks like this is causing issue/154. Reverting this patch the issues
> goes away here. @Matttbe: could you please double check that?

No need, I am sure you are correct.

> In case of fallback, the subflow can be closed by the peer while there
> are data pending in the subflow receive queue. Calling
> mptcp_close_subflow() will discard such data and will corrupt the
> stream.

This.

> I think that scenario is possible even with full msk, if the peer
> closes a single subflow while the msk is still alive (before DATA_FIN).

You mean because there might be unprocessed data in subflow rx
queue?

> A possible fix could be additionally checking for empty ssk-
> >sk_recevive_queue, plush adding a similar chunk
> in __mptcp_move_skbs_from_subflow(). =


Yes, not nice, I don't see another solution atm though.

Will look into this tomorrow.

> That means that subflow_close even could be delayed by user-space, if
> the latter does not spool the pending ingress data.

We can decouple the event from actual close.

> Or the NL event generation cold be de-coupled from the actual subflow
> close() but I fear some side effect even there.

Hmm, why?

> Note that calling __mptcp_move_skbs_from_subflow()
> from mptcp_close_subflow() will not solve the issue, as the msk receive
> queue could be full - I think;)

Yes, it could be full.
thats possible.

> Side note: it would be nice using the deferred actions to do the
> netlink call, to avoid the workqueue usage.

Why?  How many events/s do you expect?

Events try to prefer GFP_KERNEL allocations where possible.
--===============5395144629119250235==--
