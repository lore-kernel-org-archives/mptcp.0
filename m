Content-Type: multipart/mixed; boundary="===============3192102440911617311=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 3/5] mptcp: add mptcp reset option support
Date: Thu, 12 Nov 2020 10:56:07 +0100
Message-ID: <20201112095607.GL23619@breakpoint.cc>
In-Reply-To: CA+WQbws1X2nXF9bGg7-tze+RjXHxdz5WYvqKWK2xU=bDHAisVQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6669

--===============3192102440911617311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> wrote:
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c0fef9e9ba20..899f87346b49 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -193,6 +193,8 @@ void tcp_time_wait(struct sock *sk, int state, int =
timeo);
> >  #define TCPOPT_FASTOPEN_MAGIC  0xF989
> >  #define TCPOPT_SMC_MAGIC       0xE2D4C3D9
> >
> > +/* MPTCP suboptions used in TCP */
> > +#define MPTCPOPT_RST           8
> =

> And define MPTCPOPT_RST in net/mptcp/protocol.h, together with all other
> MPTCP suboptions ... ...

I wanted to avoid entanglements between mptcp and the tcp reset path.

> > @@ -216,6 +218,7 @@ void tcp_time_wait(struct sock *sk, int state, int =
timeo);
> >  #define TCPOLEN_MD5SIG_ALIGNED         20
> >  #define TCPOLEN_MSS_ALIGNED            4
> >  #define TCPOLEN_EXP_SMC_BASE_ALIGNED   8
> > +#define TCPOLEN_MPTCP_RST              4
> =

> And define TCPOLEN_MPTCP_RST in include/net/mptcp.h ... ...

Its needed for sizing of the on-stack option array.

Placing it in include/net/mptcp.h means i would need to include
that from tcp stack, which then brings other baggage with it.

I wanted to avoid that.

> > +               rep.opt[0] =3D mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP=
_RST,
> > +                                         flags, reason);
> =

> And use mptcp_option's wrapper function here ... ...

I wanted to avoid a function for what is 'u32 opt[0] =3D magic | reason'.

I will defer to Matthieu/Mat; I do not have a strong preference.
--===============3192102440911617311==--
