Content-Type: multipart/mixed; boundary="===============7886918795183325411=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 1/5] tcp: make two mptcp helpers available
 to tcp stack
Date: Mon, 09 Nov 2020 15:51:25 +0100
Message-ID: <20201109145125.GD23619@breakpoint.cc>
In-Reply-To: CA+WQbwuy3+ivf=WB6c5b18NduzS8Fg2Wv8DAuGXmM-7Z3G5sKg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6602

--===============7886918795183325411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> wrote:
> > +static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> > +{
> > +       return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12=
) |
> > +                    ((nib & 0xF) << 8) | field);
> > +}
> =

> I think we should avoid adding code in tcp.h, should it be better to defi=
ne a
> wrapper function of mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST, ..., ..=
.)
> in net/mptcp/options.c and export it in include/net/mptcp.h? ... ...

Can be done but it adds a function call to create a 32 bit number.

Sending RST isn't performance critical so it could be done that way too.
--===============7886918795183325411==--
