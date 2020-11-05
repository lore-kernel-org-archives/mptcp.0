Content-Type: multipart/mixed; boundary="===============0682775240546598213=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: unify ADD_ADDR
 and ADD_ADDR6 suboptions writing
Date: Thu, 05 Nov 2020 14:55:39 +0100
Message-ID: <079b8975-59e6-1dbf-5fb1-a829a2bc8c1f@tessares.net>
In-Reply-To: CA+WQbwuy-q4nJH_QuGUJa_H0BsKuxYZwXMxK8s+ZuhcyUauYPg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6566

--===============0682775240546598213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 04/11/2020 08:04, Geliang Tang wrote:
> Hi Matt,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net =

> <mailto:matthieu.baerts(a)tessares.net>> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:23=E5=86=99=E9=81=93=EF=
=BC=9A
> =

>     Hi Geliang,
> =

>     On 31/10/2020 16:24, Geliang Tang wrote:
>      > The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's =
the
>      > only difference between them.
>      >
>      > This patch dropped the duplicate code between ADD_ADDR and ADD_ADD=
R6
>      > suboptions writing, and unify them into one.
> =

>     It is nice to avoid similar code but here, I think you are changing t=
he
>     behaviour if CONFIG_MPTCP_IPV6 is disabled. If I am not mistaken, we
>     are
>     going to reserve space but not write anything in it except the hmac.
> =

>     For the moment, it is fine because we will not call mptcp_write_optio=
ns
>     with OPTION_MPTCP_ADD_ADDR6 but I don't know if we can safely take th=
at
>     into consideration for a "public" function called from TCP.
> =

>     Maybe "safer" by using a helper taking different arguments for v4 and
>     v6? In this case we could have something like:
> =

> =

>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OPTION_MPTCP_ADD_ADDR & opts->subopt=
ions) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mptcp_write_=
add_addr_option(ptr, opts,
>                                               =

>      =C2=A0TCPOLEN_MPTCP_ADD_ADDR_BASE);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =

>     #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OPTION_MPTCP_ADD_ADDR6 & opts->subop=
tions) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mptcp_write_=
add_addr_option(ptr, opts,
>                                               =

>     TCPOLEN_MPTCP_ADD_ADDR6_BASE);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     #endif
> =

>     Or we add a comment mentioning we should not have
>     OPTION_MPTCP_ADD_ADDR6
>     if IPV6 is disabled?
> =

> Thanks for your review. Should it be better to put all =

> OPTION_MPTCP_ADD_ADDR6
> into the IS_ENABLED(CONFIG_MPTCP_IPV6) condition? Something like:
> =

>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((OPTION_MPTCP_ADD_ADDR
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| OPTION_MPTCP_ADD_ADDR6
> #endif
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) & opts->suboptions) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 len =3D TCPOL=
EN_MPTCP_ADD_ADDR_BASE;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 echo =3D MPTC=
P_ADDR_ECHO;
> =

> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OPTION_MPTCP=
_ADD_ADDR6 & opts->suboptions)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> #endif
> =

>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->ahmac)=
 {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 len +=3D sizeof(opts->ahmac);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 echo =3D 0;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =

>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ptr++ =3D mptcp=
_option(MPTCPOPT_ADD_ADDR,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len, echo, o=
pts->addr_id);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OPTION_MPTCP=
_ADD_ADDR & opts->suboptions) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ptr +=3D 1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (OPTION_=
MPTCP_ADD_ADDR6 & opts->suboptions) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ptr +=3D 4;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> #endif
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->ahmac)=
 {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 put_unaligned_be64(opts->ahmac, ptr);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ptr +=3D 2;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =

> Is this code acceptable?

I don't know if it is clearer but that's typical with v6 :)
(we could even drop the second "#if IS_ENABLED(CONFIG_MPTCP_IPV6)" if we =

want)

But it looks "safer" :)

Cheers,
Matt

PS: the HTML rendering makes the code a bit hard to read. May you turn =

on the option to switch to "plain text mode" only if you don't mind :)
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0682775240546598213==--
