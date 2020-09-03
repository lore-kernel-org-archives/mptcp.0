Content-Type: multipart/mixed; boundary="===============4591449935533816397=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Thu, 03 Sep 2020 11:58:01 +0200
Message-ID: <3ba08d7bad27095361fecc28af6c21ba25ecb3ac.camel@redhat.com>
In-Reply-To: 20200902220130.GK7319@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5711

--===============4591449935533816397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-03 at 00:01 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Wed, 2020-09-02 at 16:37 +0200, Florian Westphal wrote:
> > > The function is short and won't sleep, so this can use the _fast vers=
ion.
> > > =

> > > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > > ---
> > >  net/mptcp/protocol.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 3b621a99c8c5..0c2b506d17de 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -1472,13 +1472,14 @@ static bool __mptcp_move_skbs(struct mptcp_so=
ck *msk)
> > >  	__mptcp_flush_join_list(msk);
> > >  	do {
> > >  		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> > > +		bool slowpath;
> > >  =

> > >  		if (!ssk)
> > >  			break;
> > >  =

> > > -		lock_sock(ssk);
> > > +		slowpath =3D lock_sock_fast(ssk);
> > >  		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> > > -		release_sock(ssk);
> > > +		unlock_sock_fast(ssk, slowpath);
> > >  	} while (!done);
> > >  =

> > >  	if (mptcp_ofo_queue(msk) || moved > 0) {
> > =

> > Good catch! the patch LGTM, thanks!
> > =

> > Do you think it could useful do the same also in mptcp_sendmsg()
> > and mptcp_worker()? (since mptcp_sendmsg_frag() does not sleep, should
> > be possible...)
> =

> sendmsg path might sleep  (it copies data from userspace).

Whoops I missed that.

> mptcp_worker might work, but I think we would need to make sure
> mptcp_ext_cache_refill() uses atomic allocations for this to work.
> =

> Not sure this is a good idea.  For work queue case I think its better
> to try to make it a true slowpath that isn't invoked frequently.

Agreed, we really don't want to over-optimize the worker

I'm fine with this, thanks!

Paolo

--===============4591449935533816397==--
