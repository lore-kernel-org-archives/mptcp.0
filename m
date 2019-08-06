Content-Type: multipart/mixed; boundary="===============0553179239781753547=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 08/10] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Mon, 05 Aug 2019 18:18:35 -0700
Message-ID: <e7fd282ac3f06909092144b6298249160ee3fe7a.camel@linux.intel.com>
In-Reply-To: 8dadaa287dce26df89ffe445cbfd4ca2378eead6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1585

--===============0553179239781753547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 16:32 +0200, Paolo Abeni wrote:
> Hi,
> =

> I have a couple of minor comments below.
> =

> On Thu, 2019-07-25 at 18:58 -0700, Peter Krystad wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4d4a9c3d25c4..67a93ab709f1 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -797,6 +797,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
> >  		msk->local_key =3D subflow->local_key;
> >  		msk->token =3D subflow->token;
> >  		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
> > +		msk->dport =3D ntohs(inet_sk(msk->subflow->sk)->inet_dport);
> > +		pr_debug("dport=3D%d", msk->dport);
> =

> Very minor nit, I think that the previous debug message can be merged
> into this one.

I'll just remove it.

> =

> > @@ -195,6 +212,50 @@ static void subflow_data_ready(struct sock *sk)
> >  	}
> >  }
> >  =

> > +int subflow_connect(struct sock *sk, struct sockaddr_in *local,
> > +		    struct sockaddr_in *remote, u8 remote_id)
> > +{
> > +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> > +	struct subflow_context *subflow;
> > +	struct socket *sf;
> > +	u32 token;
> > +	int err;
> > +
> > +	err =3D subflow_create_socket(sk, &sf);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D kernel_bind(sf, (struct sockaddr *)local,
> > +			  sizeof(struct sockaddr_in));
> > +	if (err) {
> > +		pr_debug("bind err=3D%d", err);
> > +		goto failed;
> > +	}
> > +
> > +	subflow =3D subflow_ctx(sf->sk);
> > +	subflow->remote_key =3D msk->remote_key;
> > +	subflow->local_key =3D msk->local_key;
> > +	crypto_key_sha1(msk->remote_key, &token, NULL);
> > +	pr_debug("msk=3D%p token=3D%u", msk, token);
> > +	subflow->token =3D token;
> > +	subflow->remote_id =3D remote_id;
> > +	subflow->request_join =3D 1;
> > +	subflow->request_bkup =3D 1;
> > +
> > +	err =3D kernel_connect(sf, (struct sockaddr *)remote,
> > +			     sizeof(struct sockaddr_in), O_NONBLOCK);
> > +	if (err && err !=3D -EINPROGRESS) {
> =

> AFAICS, the 'sf' should not have the nonblocking flag set, to we should
> not ever hit the EINPROGRESS condition. I think we should avoid this
> check. =


We're passing the NONBLOCK flag right here in the call to kernel_connect().
Maybe there is something I don't understand, what is the reason not to use
non-blocking?
 =

> =

> If we are going to support non blocking connect, should we return the
> INPROGRESS code instead ? =


That makes sense, will do, pending discussion of support non-blocking.

> > +		pr_debug("connect err=3D%d", err);
> > +		goto failed;
> > +	}
> > +
> > +	return 0;
> > +
> > +failed:
> > +	/* @@ cleanup the socket */
> =

> Yep ;)
> =


Ok, Ok.

Peter.

> /P
> =



--===============0553179239781753547==--
