Content-Type: multipart/mixed; boundary="===============1269757899818251398=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/5] subflow: do not create child subflow for
 fallback MP_JOIN
Date: Fri, 10 Jul 2020 18:21:33 +0200
Message-ID: <2cbd2df8e8c6f167a8e7b8578cc973f262467517.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2007091701540.16518@sraziz-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4976

--===============1269757899818251398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-09 at 17:39 -0700, Mat Martineau wrote:
> On Tue, 30 Jun 2020, Paolo Abeni wrote:
> =

> > On MP_JOIN fallback, the child socket was used just to send-out
> > the due reset packet. As we don't use the child sock anymore
> > for such role, when can avoid creating the fallback MP_JOIN
> > sock entirely.
> > =

> > This saves a busy server from quite a bit of useless work, if
> > clients are storming with MP_JOIN reqs above the server limits
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > Note: to avoid changing the hook into tcp_check_req(), I had
> > to introduce a quite ugly const cast in subflow_syn_recv_sock().
> > I *think* it should be safe, but I'm 110% sure about unintended
> > implications - alike cc optimizing the calling code assuming sk
> > never changes, and generated code being bugged due to the above
> > cast.
> > =

> > I think should be safe, as the struct sock is not accessed
> > by tcp_check_req() when the relevant conditions held after
> > syn_recv_sock(), still something require additional eyeballs.
> > ---
> > net/mptcp/subflow.c | 21 +++++++++++++++++----
> > 1 file changed, 17 insertions(+), 4 deletions(-)
> > =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 3077e07375b5..9f4f3e29587d 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -405,8 +405,11 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
> > 	subflow_req =3D mptcp_subflow_rsk(req);
> > 	fallback_is_fatal =3D tcp_rsk(req)->is_mptcp && subflow_req->mp_join;
> > 	fallback =3D !tcp_rsk(req)->is_mptcp;
> > -	if (fallback)
> > +	if (fallback) {
> > +		if (fallback_is_fatal)
> > +			goto dispose_req;
> > 		goto create_child;
> > +	}
> > =

> > 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
> > 	if (subflow_req->mp_capable) {
> > @@ -434,7 +437,7 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> > 		    !mptcp_can_accept_new_subflow(subflow_req->msk) ||
> > 		    !subflow_hmac_valid(req, &mp_opt)) {
> > 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
> > -			fallback =3D true;
> > +			goto dispose_req;
> > 		}
> > 	}
> > =

> > @@ -506,15 +509,25 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
> > 		      !mptcp_subflow_ctx(child)->conn));
> > 	return child;
> > =

> > +dispose_req:
> > +	/* The last req reference will be released by the caller */
> > +	child =3D NULL;
> > +	*own_req =3D false;
> > +	reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> > +	inet_csk_reqsk_queue_drop((struct sock *)sk, req);
> =

> I'm not sure about unintended consequences of this cast either. Even if i=
t =

> looks ok now, the calling code could be changed.
> =

> Eric constified this parameter in 0c27171e66d9, saying "We'll soon no =

> longer hold listener socket lock, these functions do not modify the socke=
t =

> in any way". It looks like the only modification to the socket by calling =

> inet_csk_reqsk_queue_drop() is an atomic_dec() or two, which should be an =

> ok thing to do. Do you think that would justify reverting that change to =

> the sk parameter?

Thank you for the feedback!

No, I think removing the 'const' from 'syn_recv_sock()' for this change
is a no-go.

> Looking at the call from tcp_check_req(), it looks like =

> ient_csk_reqsk_queue_drop() and req->rsk_ops->send_reset() can get called =

> again. This function will return NULL on this code path, and if the =

> tcp_abort_on_overflow sysctl is true, the drop/reset functions can get =

> called again. Is that not possible for not-obvious-to-me reasons?

No nothing prevent that code path from being executed - even if
requires non-default sysctl. Anyhow a duplicated rst packet should not
be too much problematic, I hope, and the 2nd execution of
inet_csk_reqsk_queue_drop() will be a no-op, as the sk will not be
hashed anymore.

Perhaps we can avoid the const cast changing a bit the hooking
in tcp_check_req(), but I'm reluctant to do that, as I changed the code
there recently. =


@Florian: do you foresee to have to touch tcp_check_req() for syncookie
handling? Perhaps we can unify the change there?

For the short term I'll send a v1 without 5/5 and including some other
fixes I'm assembling while working on issues/17.

Thanks!

Paolo

--===============1269757899818251398==--
