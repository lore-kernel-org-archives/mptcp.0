Content-Type: multipart/mixed; boundary="===============4318178640278094681=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Thu, 14 Nov 2019 19:14:11 +0100
Message-ID: <3e5ec70d4ae95b0e1261ab0649aefd08bccc5c75.camel@redhat.com>
In-Reply-To: 5a6b5f4f58d6bf3bd425ed0162ac177643d734f3.1573488751.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2543

--===============4318178640278094681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> @@ -279,22 +265,27 @@ bool mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
>  			       struct mptcp_out_options *opts)
>  {
>  	unsigned int opt_size =3D 0;
> +	bool ret =3D true;
	           ^^^^
this is wrong (should be false). I'll send a v3 rebased, including that
change

Cheers,

Paolo

--===============4318178640278094681==--
