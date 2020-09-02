Content-Type: multipart/mixed; boundary="===============3282746238030028245=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Thu, 03 Sep 2020 00:01:30 +0200
Message-ID: <20200902220130.GK7319@breakpoint.cc>
In-Reply-To: cf777c2c14a091eca844228a44b31367a74e030f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5709

--===============3282746238030028245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Wed, 2020-09-02 at 16:37 +0200, Florian Westphal wrote:
> > The function is short and won't sleep, so this can use the _fast versio=
n.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3b621a99c8c5..0c2b506d17de 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1472,13 +1472,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock=
 *msk)
> >  	__mptcp_flush_join_list(msk);
> >  	do {
> >  		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> > +		bool slowpath;
> >  =

> >  		if (!ssk)
> >  			break;
> >  =

> > -		lock_sock(ssk);
> > +		slowpath =3D lock_sock_fast(ssk);
> >  		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> > -		release_sock(ssk);
> > +		unlock_sock_fast(ssk, slowpath);
> >  	} while (!done);
> >  =

> >  	if (mptcp_ofo_queue(msk) || moved > 0) {
> =

> Good catch! the patch LGTM, thanks!
> =

> Do you think it could useful do the same also in mptcp_sendmsg()
> and mptcp_worker()? (since mptcp_sendmsg_frag() does not sleep, should
> be possible...)

sendmsg path might sleep  (it copies data from userspace).

mptcp_worker might work, but I think we would need to make sure
mptcp_ext_cache_refill() uses atomic allocations for this to work.

Not sure this is a good idea.  For work queue case I think its better
to try to make it a true slowpath that isn't invoked frequently.
--===============3282746238030028245==--
