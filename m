Content-Type: multipart/mixed; boundary="===============6792845823473282297=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [bug report] mptcp: Implement MPTCP receive path
Date: Mon, 17 Feb 2020 16:56:27 +0100
Message-ID: <20200217155627.GG19559@breakpoint.cc>
In-Reply-To: 20200217145214.sfn76fqgt6ixo5sw@kili.mountain
X-Status: 
X-Keywords:                  
X-UID: 3676

--===============6792845823473282297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dan Carpenter <dan.carpenter(a)oracle.com> wrote:
> Hello Mat Martineau,
> =

> The patch 648ef4b88673: "mptcp: Implement MPTCP receive path" from
> Jan 21, 2020, leads to the following static checker warning:
> =

> 	net/mptcp/subflow.c:558 subflow_data_ready()
> 	warn: test_bit() takes a bit number

[..]

> net/mptcp/subflow.c
>    544  static void subflow_data_ready(struct sock *sk)
>    545  {
>    546          struct mptcp_subflow_context *subflow =3D mptcp_subflow_c=
tx(sk);
>    547          struct sock *parent =3D subflow->conn;
>    548  =

>    549          if (!parent || !subflow->mp_capable) {
>    550                  subflow->tcp_data_ready(sk);
>    551  =

>    552                  if (parent)
>    553                          parent->sk_data_ready(parent);
>    554                  return;
>    555          }
>    556  =

>    557          if (mptcp_subflow_data_available(sk)) {
>    558                  set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flag=
s);
>                                 ^^^^^^^^^^^^^^^^
> This is "BIT(0)" but it should just be "0".  The double shift bug will
> not cause a problem so long as it is done consistently and it doesn't go
> higher than BIT(6).

Indeed, thanks for reporting.  I've sent a simple patch to toss the
BIT() part.
--===============6792845823473282297==--
