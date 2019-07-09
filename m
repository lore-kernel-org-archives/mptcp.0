Content-Type: multipart/mixed; boundary="===============4792946888709984162=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: harmonize locking on all socket
 operations.
Date: Tue, 09 Jul 2019 11:55:43 +0200
Message-ID: <b2543913dce2fa3b501537ce5e71a6b280b984d9.camel@redhat.com>
In-Reply-To: 6939108b48bb45e5e9eba4cb3cd6660afb6233ab.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1476

--===============4792946888709984162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-07-08 at 17:20 -0700, Peter Krystad wrote:
> Thanks for this patch, I agree some work on the locking was required.
> =

> As a general comment I wonder if the structure would be more clear if
> the usage of the msk->subflow field had not been overloaded, currently it=
 can
> point to either an subflow that is an in-progress outgoing connection, a
> regular TCP socket (fallback case, empty msk->conn_list implied) or a soc=
ket =

> listening for incoming connections. Do you think splitting this into mult=
iple
> fields might make the code more clear?

Thank you for the review!

I agree that the current subflow usage is a bit confusing. AFAIK
Florian is currently looking into cleaning subflow usage. But he is at =

a conference (NFWS) and then on holiday, so his replies will be
delayed, I guess ;)

I hope that this two tasks can be orthogonal/carried on concurrently.

I think a problem raise with the patch series handling. Perhaps we can
discuss it in the next mtg.

> On Thu, 2019-07-04 at 17:51 +0200, Paolo Abeni wrote:
[...]
> > +static struct socket *mptcp_socket_get_ref(const struct mptcp_sock *ms=
k)
> > +{
> > +	struct socket *ssock;
> > +
> > +	lock_sock((struct sock *)msk);
> > +	ssock =3D __mptcp_socket_get_ref(msk);
> > +	release_sock((struct sock *)msk);
> > +
> > +	return ssock;
> > +}
> > +
> =

> Maybe 'mptcp_fallback_get_ref' is a better name as this is more specifica=
lly
> what we are taking a reference to here?

Agreed.

[...]
> > +static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
> > +{
> > +	struct net *net =3D sock_net((struct sock *)msk);
> > +	struct sock *sk =3D (struct sock *)msk;
> > +	struct subflow_context *subflow;
> > +	struct socket *ssock;
> > +	int err;
> > +
> > +	lock_sock(sk);
> > +	ssock =3D __mptcp_socket_get_ref(msk);
> > +	if (ssock)
> > +		goto release;
> > +
> > +	pr_debug("msk=3D%p", msk);
> > +	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sso=
ck);
> > +	if (!err) {
> > +		lock_sock(ssock->sk);
> > +		err =3D tcp_set_ulp(ssock->sk, "mptcp");
> > +		release_sock(ssock->sk);
> > +		if (err) {
> > +			ssock =3D ERR_PTR(err);
> > +			goto release;
> > +		}
> > +
> > +		subflow =3D subflow_ctx(ssock->sk);
> > +
> > +		pr_debug("subflow=3D%p", subflow);
> > +		msk->subflow =3D ssock;
> > +		subflow->conn =3D sk;
> > +		subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
> > +		subflow->request_cksum =3D 1; // @@ if checksum enabled
> > +		subflow->version =3D 0;
> > +		sock_hold(ssock->sk);
> > +	}
> =

> I would prefer to see this code continue to call 'subflow_create_socket()=
 for
> the sock_create_kern() call and initialization so that subflow internals =
are
> manipulated in the subflow layer. Plus I just moved it to that file a few
> weeks ago. :)

Yep, sorry. I was sitting on this patch since a little time, and I did
not rebase it correctly on current code. Will do in the next iteration.

[...]
> > static int mptcp_stream_accept(struct socket *sock, struct socket *news=
ock,
> >  			       int flags, bool kern)
> >  {
> >  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > +	struct socket *ssock;
> > +	int err;
> >  =

> >  	pr_debug("msk=3D%p", msk);
> >  =

> > -	if (!msk->subflow)
> > +	ssock =3D mptcp_socket_create_get(msk);
> > +	if (!ssock)
> =

> I don't think this is right, the new socket is already created so no need=
 to
> call mptcp_socket_create_get() here. Notice no call to subflow_create_soc=
ket()
> before this change in this location.

Yep, you are right, I'll fix that in the next iteration.

Thank you!

Paolo


--===============4792946888709984162==--
