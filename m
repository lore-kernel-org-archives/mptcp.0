Content-Type: multipart/mixed; boundary="===============1742999311110891301=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 7/9] Move setting request_ fields of subflow to
 MPTCP layer
Date: Thu, 18 Jul 2019 09:31:38 +0200
Message-ID: <28a920d38fe3d692b0695c34a6316ad14a258269.camel@redhat.com>
In-Reply-To: 20190717221256.7358-8-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1525

--===============1742999311110891301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1664a69c8e30..fe73379a81df 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -853,6 +854,11 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
>  			return err;
>  	}
>  =

> +	subflow =3D subflow_ctx(msk->subflow->sk);
> +	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
> +	subflow->request_cksum =3D 1; /* @@ if checksum enabled */
> +	subflow->request_version =3D 0; /* only v0 supported */
> +

Since this chunck is replicated a few lines below, and possibly some
more code is going to be added to this section, with time, what about
adding an helper for that?

Cheers,

Paolo


--===============1742999311110891301==--
