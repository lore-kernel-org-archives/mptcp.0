Content-Type: multipart/mixed; boundary="===============5919347448125918514=="
MIME-Version: 1.0
From: Todd Malsbary <todd.malsbary at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: use untruncated hash in ADD_ADDR HMAC
Date: Thu, 21 May 2020 14:06:41 -0700
Message-ID: <d6c3cf1e57057411ce17cb1a04c48f5e96d5a3f2.camel@linux.intel.com>
In-Reply-To: 20200521190048.GN45434@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4446

--===============5919347448125918514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-21 at 12:00 -0700, Christoph Paasch wrote:
> On 21/05/20 - 09:39:05, Todd Malsbary wrote:
> > @@ -223,6 +224,7 @@ static void subflow_finish_connect(struct sock *sk,=
 const struct sk_buff *skb)
> >  	struct mptcp_options_received mp_opt;
> >  	struct sock *parent =3D subflow->conn;
> >  	struct tcp_sock *tp =3D tcp_sk(sk);
> > +	u8 hmac[SHA256_DIGEST_SIZE];
> =

> Is it worth moving this inside the if-statement (subflow->mp_join) as tha=
t is the
> only place where hmac is used ?
> =


Yes, I originally had that but it looked like the convention was to
declare at the top of the function so I moved it.  I'll send out a new
version shortly.

-Todd

--===============5919347448125918514==--
