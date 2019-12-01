Content-Type: multipart/mixed; boundary="===============5714599036866625194=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix option length of mp_capable syn/ack
Date: Sun, 01 Dec 2019 01:04:12 +0100
Message-ID: <960a769d4e7f79861b2bda17feeaaf2825d7d819.camel@redhat.com>
In-Reply-To: 312a6bb7-4ae4-7fb8-7d99-7765099bd5d6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2724

--===============5714599036866625194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-11-30 at 09:55 +0100, Matthieu Baerts wrote:
> Hi Davide,

[...]

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 98eb0281d196..cee5c3968741 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -57,7 +57,7 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
> =

> Here above, you also need to replace TCPOLEN_MPTCP_MPC_SYNACK by =

> TCPOLEN_MPTCP_MPC_ACK:
> =

> =3D=3D=3D
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 98eb0281d196..9163fddf16b9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -25,7 +25,7 @@ void mptcp_parse_option(const unsigned char *ptr, int =

> opsize,
>           */
>          case MPTCPOPT_MP_CAPABLE:
>                  if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
> -                   opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
> +                   opsize !=3D TCPOLEN_MPTCP_MPC_ACK)
>                          break;
> =

>                  mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
> =3D=3D=3D
> =

> (or check that the size is not one of the three: I guess (but to be =

> confirmed) that the compiler will remove one check if we compare exactly =

> the same thing: opsize !=3D 12 && opsize !=3D 12 && opsize !=3D 20)

> Otherwise you will never match the if-statement here below.

you are right, will fix this in v3. =


> --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -34,7 +34,7 @@
> >   =

> >   /* MPTCP suboption lengths */
> >   #define TCPOLEN_MPTCP_MPC_SYN		12
> > -#define TCPOLEN_MPTCP_MPC_SYNACK	20
> > +#define TCPOLEN_MPTCP_MPC_SYNACK	12
> =

> Should we remove it if we don't use it?
> Or rename 'TCPOLEN_MPTCP_MPC_SYN' to 'TCPOLEN_MPTCP_MPC_SYN_AND_SYNACK'?

yes, it can be removed - but it's going to return very soon, with the same
value, with v1 protocol. I'm for preserving the testability with
tcpdump/packetdrill in v0 changing the lowest possible number of lines.

-- =

davide


--===============5714599036866625194==--
