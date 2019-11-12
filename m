Content-Type: multipart/mixed; boundary="===============8116840190259655690=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: disable on req sk if MD5SIG is enabled
Date: Tue, 12 Nov 2019 10:03:53 -0800
Message-ID: <8b14065ca9686fdd996d81cb4359c51a3ec0d942.camel@linux.intel.com>
In-Reply-To: 5b0c081c627fb1e016edf579d1d04015223b0067.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2488

--===============8116840190259655690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-12 at 09:34 +0100, Paolo Abeni wrote:
> On Mon, 2019-11-11 at 13:44 -0800, Peter Krystad wrote:
> > On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> > > Likley we want to update the "mptcp: Create SUBFLOW socket for incomi=
ng connections"
> > > commit message with something alike:
> > > =

> > > Explicitly disable MPTCP if MD5SIG is enable, to prevent TCP option s=
pace
> > > exaustion.
> > > =

> > > Squash-to: mptcp: Create SUBFLOW socket for incoming connections
> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > ---
> > >  net/mptcp/protocol.c | 8 ++++++++
> > >  net/mptcp/subflow.c  | 8 ++++++++
> > >  2 files changed, 16 insertions(+)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 81b7c21f4d3c..bb297e9dd6c5 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -342,6 +342,14 @@ static int mptcp_stream_connect(struct socket *s=
ock, struct sockaddr *uaddr,
> > >  	if (IS_ERR(ssock))
> > >  		return PTR_ERR(ssock);
> > >  =

> > > +#ifdef CONFIG_TCP_MD5SIG
> > > +	/* no MPTCP is MD5SIG is enabled on this socket or we may run out of
> > > +	 * TCP option space.
> > > +	 */
> > =

> > typo in comment [two places]: "no MPTCP if MD5SIG"
> =

> thanx, will fix in v2.
> =

> > > +	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> > > +		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;
> > =

> > Would it be better to put this check in mptcp_socket_create_get() where
> > request_mptcp is being initially? Then it only needs to be in one place=
 and
> > will cause bind() to fail appropriately as well.
> =

> In my reply to Florian I reported an incorrect sequence leading to
> MPTCP + MD5SIG, the correct one should be:
> =

> socket(MPTCP)
> bind()			// creates fallback socket
> setsockopt(MD5SIG)	// fallback found, calls setsockopt() on it
> connect()
> =

> In the above sequence, when mptcp_socket_create_get() is called by
> bind(), rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info) is NULL. The
> md5sig info will be allocated by the next setsockopt().
> =

> Moving the check inside mptcp_socket_create_get() should not help.
> Additionally I don't see why bind() should fail here, can you please
> explain?

I see the sequence now. My poor words for "bind fail", I meant setting
request_mptcp=3D0 in bind(), which, from the above sequence, isn't right.
Carry on!

Peter.

> Thank you! =

> =

> Paolo
>=20

--===============8116840190259655690==--
