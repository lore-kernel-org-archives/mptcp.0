Content-Type: multipart/mixed; boundary="===============1909264516294451290=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] protocol: pm callback must be done after msk
 state is set up
Date: Thu, 09 Jan 2020 17:53:37 +0100
Message-ID: <20200109165337.GE795@breakpoint.cc>
In-Reply-To: 6826dc39601220d17b792204b34dc1414e163a7f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3334

--===============1909264516294451290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2020-01-09 at 15:31 +0100, Florian Westphal wrote:
> > Squashto: mptcp: Add path manager interface
> > =

> > current location calls this when msk->token is still 0, so pm worker
> > will never find the mptcp socket it should be using.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 475ef4c90460..a33c4c58de78 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1371,8 +1371,6 @@ void mptcp_finish_connect(struct sock *ssk)
> >  =

> >  	pr_debug("msk=3D%p, token=3D%u", sk, subflow->token);
> >  =

> > -	mptcp_pm_new_connection(msk, 0);
> > -
> >  	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
> >  	ack_seq++;
> >  	subflow->map_seq =3D ack_seq;
> > @@ -1389,6 +1387,8 @@ void mptcp_finish_connect(struct sock *ssk)
> >  	WRITE_ONCE(msk->ack_seq, ack_seq);
> >  	WRITE_ONCE(msk->can_ack, 1);
> >  	atomic64_set(&msk->snd_una, msk->write_seq);
> > +
> > +	mptcp_pm_new_connection(msk, 0);
> >  }
> >  =

> >  static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
> =

> LGTM, thanks Florian! (This was fast!)
> =

> Does this fix the MP_JOIN handshake or is there any other pending known
> issue ? (beyond the list corruption fixed by the next patch...)

Yes and yes.  Things only work when slowing down the test prog to give
the join time to complete.

Else, this hits the 'is parent not established anymore' check
in mptcp_finish_join.  This also gives a memory leak of the socket.
--===============1909264516294451290==--
