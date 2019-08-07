Content-Type: multipart/mixed; boundary="===============6067901823324452935=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 08/10] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Wed, 07 Aug 2019 10:55:53 +0200
Message-ID: <966d2ebe35602a3dcb9622e00a03f810dcc9aca8.camel@redhat.com>
In-Reply-To: e7fd282ac3f06909092144b6298249160ee3fe7a.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1588

--===============6067901823324452935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-05 at 18:18 -0700, Peter Krystad wrote:
> On Fri, 2019-08-02 at 16:32 +0200, Paolo Abeni wrote:
> > @@ -195,6 +212,50 @@ static void subflow_data_ready(struct sock *sk)
> > >  	}
> > >  }
> > >  =

> > > +int subflow_connect(struct sock *sk, struct sockaddr_in *local,
> > > +		    struct sockaddr_in *remote, u8 remote_id)
> > > +{
> > > +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > > +	struct subflow_context *subflow;
> > > +	struct socket *sf;
> > > +	u32 token;
> > > +	int err;
> > > +
> > > +	err =3D subflow_create_socket(sk, &sf);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err =3D kernel_bind(sf, (struct sockaddr *)local,
> > > +			  sizeof(struct sockaddr_in));
> > > +	if (err) {
> > > +		pr_debug("bind err=3D%d", err);
> > > +		goto failed;
> > > +	}
> > > +
> > > +	subflow =3D subflow_ctx(sf->sk);
> > > +	subflow->remote_key =3D msk->remote_key;
> > > +	subflow->local_key =3D msk->local_key;
> > > +	crypto_key_sha1(msk->remote_key, &token, NULL);
> > > +	pr_debug("msk=3D%p token=3D%u", msk, token);
> > > +	subflow->token =3D token;
> > > +	subflow->remote_id =3D remote_id;
> > > +	subflow->request_join =3D 1;
> > > +	subflow->request_bkup =3D 1;
> > > +
> > > +	err =3D kernel_connect(sf, (struct sockaddr *)remote,
> > > +			     sizeof(struct sockaddr_in), O_NONBLOCK);
> > > +	if (err && err !=3D -EINPROGRESS) {
> > =

> > AFAICS, the 'sf' should not have the nonblocking flag set, to we should
> > not ever hit the EINPROGRESS condition. I think we should avoid this
> > check. =

> =

> We're passing the NONBLOCK flag right here in the call to kernel_connect(=
).
> Maybe there is something I don't understand, what is the reason not to use
> non-blocking?

Nope, sorry, just serious lack of coffee on my side. Please disregard
the above comment.

Sorry for the noise,

Paolo


--===============6067901823324452935==--
