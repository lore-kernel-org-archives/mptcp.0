Content-Type: multipart/mixed; boundary="===============3393372844913026786=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 04/16] mptcp: Handle MPTCP TCP options
Date: Thu, 11 Oct 2018 11:28:49 +0200
Message-ID: <CAKuKrBmBRyCytaMmWEwqszTXne1zFehuyFaX1i64=fKyaL7uZw@mail.gmail.com>
In-Reply-To: 1539203288.19533.22.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 821

--===============3393372844913026786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 10:28 PM Krystad, Peter <peter.krystad(a)intel.com>=
 wrote:
>
> On Tue, 2018-10-09 at 15:17 +0200, Matthieu Baerts wrote:
> > Hi Peter,
> >
> > Nice addition!
> >
> > Here are just a few questions and suggestions, mostly some details.
> > I am not sure we want to speak about this level of details now.
>
>
> Some of these details I can tidy up for our next release such as
> #defines for numbers, comment style, etc. I deliberately tried to leave
> out CONFIG_MPTCP as much as possible due to the maintainer advice we
> received to "just add the code so we can see what impact it has".
> Perhaps we will be advised to insert them during reviews...

It makes sense. Thank you for your reply!

Matthieu

> Peter.
>
>
>
> > On Sat, Oct 6, 2018 at 1:04 AM Mat Martineau
> > <mathew.j.martineau(a)linux.intel.com> wrote:
> > >
> > > From: Peter Krystad <peter.krystad(a)intel.com>
> > >
> > > Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
> > > ---
> > >  include/linux/tcp.h   |  11 +++
> > >  include/net/mptcp.h   |  35 ++++++++++
> > >  include/net/tcp.h     |   2 +
> > >  net/ipv4/tcp_input.c  |   5 ++
> > >  net/ipv4/tcp_output.c |  67 +++++++++++++++----
> > >  net/mptcp/Makefile    |   2 +-
> > >  net/mptcp/options.c   | 152 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  7 files changed, 261 insertions(+), 13 deletions(-)
> > >  create mode 100644 net/mptcp/options.c
> > >
> > > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > > index 263e37271afd..cb40dcb43f95 100644
> > > --- a/include/linux/tcp.h
> > > +++ b/include/linux/tcp.h
> > > @@ -104,6 +104,16 @@ struct tcp_options_received {
> > >         u8      num_sacks;      /* Number of SACK blocks             =
   */
> > >         u16     user_mss;       /* mss requested by user in ioctl    =
   */
> > >         u16     mss_clamp;      /* Maximal mss, negotiated at connect=
ion setup */
> > > +       struct {
> > > +               u8      mp_capable : 1,
> > > +                       mp_join : 1,
> > > +                       dss : 1,
> > > +                       version : 4;
> > > +               u8      flags;
> > > +               u64     sndr_key;
> > > +               u64     rcvr_key;
> > > +       } mptcp;
> >
> > For upstream, should we not surround this new structure with #ifdef
> > CONFIG_MPTCP?
> > > +
> > >  };
> > >
> > >  static inline void tcp_clear_options(struct tcp_options_received *rx=
_opt)
> > > @@ -113,6 +123,7 @@ static inline void tcp_clear_options(struct tcp_o=
ptions_received *rx_opt)
> > >  #if IS_ENABLED(CONFIG_SMC)
> > >         rx_opt->smc_ok =3D 0;
> > >  #endif
> > > +       rx_opt->mptcp.mp_capable =3D rx_opt->mptcp.mp_join =3D rx_opt=
->mptcp.dss =3D 0;
> >
> > Same here for the CONFIG_MPTCP?
> >
> > >  }
> > >
> > >  /* This is the max number of SACKS that we'll generate and process. =
It's safe
> > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > index 7f7b18b000fe..f88213e31fbe 100644
> > > --- a/include/net/mptcp.h
> > > +++ b/include/net/mptcp.h
> > > @@ -18,6 +18,23 @@
> > >
> > >  #include <linux/tcp.h>
> > >
> > > +/* MPTCP option subtypes */
> > > +
> > > +#define MPTCPOPT_MP_CAPABLE    0
> > > +#define MPTCPOPT_MP_JOIN       1
> > > +#define MPTCPOPT_DSS           2
> > > +#define MPTCPOPT_ADD_ADDR      3
> > > +#define MPTCPOPT_REMOVE_ADDR   4
> > > +#define MPTCPOPT_MP_PRIO       5
> > > +#define MPTCPOPT_MP_FAIL       6
> > > +#define MPTCPOPT_MP_FASTCLOSE  7
> > > +
> > > +/* MPTCP handshake flags */
> > > +
> > > +#define MPTCP_CAP_CHECKSUM_REQD        (1 << 7)
> > > +#define MPTCP_CAP_EXTENSIBILITY        (1 << 6)
> > > +#define MPTCP_CAP_HMAC_SHA1    (1 << 0)
> > > +
> > >  /* MPTCP connection sock */
> > >  struct mptcp_sock {
> > >         /* inet_connection_sock must be the first member */
> > > @@ -30,4 +47,22 @@ static inline struct mptcp_sock *mptcp_sk(const st=
ruct sock *sk)
> > >         return (struct mptcp_sock *)sk;
> > >  }
> > >
> > > +#ifdef CONFIG_MPTCP
> > > +
> > > +void mptcp_parse_option(const unsigned char *ptr, int opsize,
> > > +                       struct tcp_options_received *opt_rx);
> > > +
> > > +void mptcp_get_options(const struct sk_buff *skb,
> > > +                      struct tcp_options_received *options);
> > > +
> > > +#else
> > > +
> > > +static inline void mptcp_parse_option(const unsigned char *ptr, int =
opsize,
> > > +                                     struct tcp_options_received *op=
t_rx)
> > > +{
> > > +}
> > > +
> > > +
> > > +
> > > +#endif /* CONFIG_MPTCP */
> > >  #endif /* __NET_MPTCP_H */
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 9a7e4ac9892a..56a3455f7a50 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -215,6 +215,8 @@ void tcp_time_wait(struct sock *sk, int state, in=
t timeo);
> > >  #define TCPOLEN_MD5SIG_ALIGNED         20
> > >  #define TCPOLEN_MSS_ALIGNED            4
> > >  #define TCPOLEN_EXP_SMC_BASE_ALIGNED   8
> > > +#define TCPOLEN_MPTCP_MPC_SYN          12
> > > +#define TCPOLEN_MPTCP_MPC_SYNACK       20
> > >
> > >  /* Flags in tp->nonagle */
> > >  #define TCP_NAGLE_OFF          1       /* Nagle's algo is disabled */
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 4c2dd9f863f7..81fccf0c9120 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -79,6 +79,7 @@
> > >  #include <trace/events/tcp.h>
> > >  #include <linux/static_key.h>
> > >  #include <net/busy_poll.h>
> > > +#include <net/mptcp.h>
> > >
> > >  int sysctl_tcp_max_orphans __read_mostly =3D NR_FILE;
> > >
> > > @@ -3865,6 +3866,10 @@ void tcp_parse_options(const struct net *net,
> > >                                  */
> > >                                 break;
> > >  #endif
> > > +                        case TCPOPT_MPTCP:
> > > +                               mptcp_parse_option(ptr, opsize, opt_r=
x);
> > > +                               break;
> > > +
> > >                         case TCPOPT_FASTOPEN:
> > >                                 tcp_parse_fastopen_option(
> > >                                         opsize - TCPOLEN_FASTOPEN_BAS=
E,
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 597dbd749f05..a6ea8520e5d9 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -37,6 +37,7 @@
> > >  #define pr_fmt(fmt) "TCP: " fmt
> > >
> > >  #include <net/tcp.h>
> > > +#include <net/mptcp.h>
> > >
> > >  #include <linux/compiler.h>
> > >  #include <linux/gfp.h>
> > > @@ -415,6 +416,58 @@ static inline bool tcp_urg_mode(const struct tcp=
_sock *tp)
> > >  #define OPTION_WSCALE          (1 << 3)
> > >  #define OPTION_FAST_OPEN_COOKIE        (1 << 8)
> > >  #define OPTION_SMC             (1 << 9)
> > > +#define OPTION_MPTCP           (1 << 10)
> > > +
> > > +/* MPTCP option subtypes */
> > > +#define OPTION_MPTCP_MPC_SYN   (1 << 0)
> > > +#define OPTION_MPTCP_MPC_SYNACK        (1 << 1)
> > > +#define OPTION_MPTCP_MPC_ACK   (1 << 2)
> > > +
> > > +struct tcp_out_options {
> > > +       u16 options;            /* bit field of OPTION_* */
> > > +       u16 mss;                /* 0 to disable */
> > > +       u8 ws;                  /* window scale, 0 to disable */
> > > +       u8 num_sack_blocks;     /* number of SACK blocks to include */
> > > +       u8 hash_size;           /* bytes in hash_location */
> > > +       __u8 *hash_location;    /* temporary pointer, overloaded */
> > > +       __u32 tsval, tsecr;     /* need to include OPTION_TS */
> > > +       struct tcp_fastopen_cookie *fastopen_cookie;    /* Fast open =
cookie */
> > > +       u16 suboptions;         /* MPTCP sub-options */
> > > +       u64 sndr_key;
> > > +       u64 rcvr_key;
> >
> > (detail: should we prefix these new entries with "mptcp_"? Or an
> > "mptcp_options" structure like what has been done for tcp_fastopen?)
> >
> > > +};
> > > +
> > > +static void mptcp_options_write(__be32 *ptr, struct tcp_out_options =
*opts)
> > > +{
> > > +       if (!(OPTION_MPTCP & opts->options))
> > > +               return;
> > > +
> > > +       if ((OPTION_MPTCP_MPC_SYN |
> > > +            OPTION_MPTCP_MPC_SYNACK |
> > > +            OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > > +               u8 len;
> > > +               __be64 key;
> > > +
> > > +               if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
> > > +                       len =3D TCPOLEN_MPTCP_MPC_SYN;
> > > +               else
> > > +                       len =3D TCPOLEN_MPTCP_MPC_SYNACK;
> > > +
> > > +               *ptr++ =3D htonl((0x1e << 24) | // TCP option: Multip=
ath TCP
> > > +                              (len << 16)  | // length
> > > +                              (0 <<  8)    | // subtype=3DMP_CAPABLE=
 | version=3D0
> > > +                              (0x1));        // flags=3DHMAC-SHA1
> >
> > (detail: good idea to have comment here! I guess we don't need to
> > spend time on the code style now but it was strange not to see
> > comments made with /* */ :) )
> OK.
> >
> > > +               key =3D cpu_to_be64(opts->sndr_key);
> > > +               memcpy((u8 *) ptr, (u8 *) &key, 8);
> > > +               ptr +=3D 2;
> >
> > (detail: should we use define/sizeof here, below and in mptcp_parse_opt=
ion?)
> OK.
> >
> > > +               if ((OPTION_MPTCP_MPC_SYNACK |
> > > +                    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > > +                       key =3D cpu_to_be64(opts->rcvr_key);
> > > +                       memcpy((u8 *) ptr, (u8 *) &key, 8);
> > > +                       ptr +=3D 2;
> > > +               }
> > > +       }
> > > +}
> > >
> > >  static void smc_options_write(__be32 *ptr, u16 *options)
> > >  {
> > > @@ -431,17 +484,6 @@ static void smc_options_write(__be32 *ptr, u16 *=
options)
> > >  #endif
> > >  }
> > >
> > > -struct tcp_out_options {
> > > -       u16 options;            /* bit field of OPTION_* */
> > > -       u16 mss;                /* 0 to disable */
> > > -       u8 ws;                  /* window scale, 0 to disable */
> > > -       u8 num_sack_blocks;     /* number of SACK blocks to include */
> > > -       u8 hash_size;           /* bytes in hash_location */
> > > -       __u8 *hash_location;    /* temporary pointer, overloaded */
> > > -       __u32 tsval, tsecr;     /* need to include OPTION_TS */
> > > -       struct tcp_fastopen_cookie *fastopen_cookie;    /* Fast open =
cookie */
> > > -};
> > > -
> > >  /* Write previously computed TCP options to the packet.
> > >   *
> > >   * Beware: Something in the Internet is very sensitive to the orderi=
ng of
> > > @@ -550,6 +592,8 @@ static void tcp_options_write(__be32 *ptr, struct=
 tcp_sock *tp,
> > >         }
> > >
> > >         smc_options_write(ptr, &options);
> > > +
> > > +       mptcp_options_write(ptr, opts);
> > >  }
> > >
> > >  static void smc_set_option(const struct tcp_sock *tp,
> > > @@ -713,7 +757,6 @@ static unsigned int tcp_synack_options(const stru=
ct sock *sk,
> > >                         remaining -=3D need;
> > >                 }
> > >         }
> > > -
> >
> > (detail: unwanted change?)
> >
> > >         smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
> > >
> > >         return MAX_TCP_OPTION_SPACE - remaining;
> > > diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> > > index 5624e7d51d48..2bd18e3b9fda 100644
> > > --- a/net/mptcp/Makefile
> > > +++ b/net/mptcp/Makefile
> > > @@ -1,3 +1,3 @@
> > >  obj-$(CONFIG_MPTCP) +=3D mptcp.o
> > >
> > > -mptcp-y :=3D protocol.o
> > > +mptcp-y :=3D protocol.o options.o
> > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > new file mode 100644
> > > index 000000000000..4fd64e0bdd2e
> > > --- /dev/null
> > > +++ b/net/mptcp/options.c
> > > @@ -0,0 +1,152 @@
> > > +/*
> > > + * Multipath TCP
> > > + *
> > > + * Copyright (c) 2017, Intel Corporation.
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms and conditions of the GNU General Public License,
> > > + * version 2, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but WI=
THOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> > > + * more details.
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <net/tcp.h>
> > > +#include <net/mptcp.h>
> > > +
> > > +void mptcp_parse_option(const unsigned char *ptr, int opsize,
> > > +                       struct tcp_options_received *opt_rx)
> > > +{
> > > +       u8 subtype;
> > > +       u64 *p;
> > > +
> > > +       opsize -=3D 2;
> > > +       subtype =3D *ptr++;
> > > +
> > > +       /* MPTCPOPT_MP_CAPABLE
> > > +        * 0: 4MSB=3Dsubtype, 4LSB=3Dversion
> > > +        * 1: Handshake flags
> > > +        * 2-9: Sender key
> > > +        * 10-17: Receiver key (optional)
> > > +        */
> > > +       switch (subtype & 0xF0) {
> > > +       case 0x00:
> >
> > (detail: I guess we will use macro here later)
> >
> > Matthieu
> >
> > > +               pr_debug("MP_CAPABLE");
> > > +               pr_debug("flags=3D%02x", *ptr);
> > > +               opt_rx->mptcp.mp_capable =3D 1;
> > > +               opt_rx->mptcp.version =3D subtype & 0x0F;
> > > +               opt_rx->mptcp.flags =3D *ptr++;
> > > +               opt_rx->mptcp.sndr_key =3D get_unaligned_be64(ptr);
> > > +               pr_debug("sndr_key=3D%llu", opt_rx->mptcp.sndr_key);
> > > +               ptr +=3D 8;
> > > +               if (opsize > TCPOLEN_MPTCP_MPC_SYN) {
> > > +                       opt_rx->mptcp.rcvr_key =3D get_unaligned_be64=
(ptr);
> > > +                       pr_debug("rcvr_key=3D%llu", opt_rx->mptcp.rcv=
r_key);
> > > +                       ptr +=3D 8;
> > > +               }
> > > +               break;
> > > +
> > > +       /* MPTCPOPT_MP_JOIN
> > > +        *
> > > +        * Initial SYN
> > > +        * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
> > > +        * 1: Address ID
> > > +        * 2-5: Receiver token
> > > +        * 6-9: Sender random number
> > > +        *
> > > +        * SYN/ACK response
> > > +        * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
> > > +        * 1: Address ID
> > > +        * 2-9: Sender truncated HMAC
> > > +        * 10-13: Sender random number
> > > +        *
> > > +        * Third ACK
> > > +        * 0: 4MSB=3Dsubtype, 0000
> > > +        * 1: 0 (Reserved)
> > > +        * 2-21: Sender HMAC
> > > +        */
> > > +
> > > +       /* MPTCPOPT_DSS
> > > +        * 0: 4MSB=3Dsubtype, 0000
> > > +        * 1: 3MSB=3D0, F=3DData FIN, m=3DDSN length, M=3Dhas DSN/SSN=
/DLL/checksum,
> > > +        *    a=3DDACK length, A=3Dhas DACK
> > > +        * 0, 4, or 8 bytes of DACK (depending on A/a)
> > > +        * 0, 4, or 8 bytes of DSN (depending on M/m)
> > > +        * 0 or 4 bytes of SSN (depending on M)
> > > +        * 0 or 2 bytes of DLL (depending on M)
> > > +        * 0 or 2 bytes of checksum (depending on M)
> > > +        */
> > > +       case 0x20:
> > > +               pr_debug("DSS");
> > > +               opt_rx->mptcp.dss =3D 1;
> > > +               break;
> > > +
> > > +       /* MPTCPOPT_ADD_ADDR
> > > +        * 0: 4MSB=3Dsubtype, 4LSB=3DIP version (4 or 6)
> > > +        * 1: Address ID
> > > +        * 4 or 16 bytes of address (depending on ip version)
> > > +        * 0 or 2 bytes of port (depending on length)
> > > +        */
> > > +
> > > +       /* MPTCPOPT_REMOVE_ADDR
> > > +        * 0: 4MSB=3Dsubtype, 0000
> > > +        * 1: Address ID
> > > +        * Additional bytes: More address IDs (depending on length)
> > > +        */
> > > +
> > > +       /* MPTCPOPT_MP_PRIO
> > > +        * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
> > > +        * 1: Address ID (optional, current addr implied if not prese=
nt)
> > > +        */
> > > +
> > > +       /* MPTCPOPT_MP_FAIL
> > > +        * 0: 4MSB=3Dsubtype, 0000
> > > +        * 1: 0 (Reserved)
> > > +        * 2-9: DSN
> > > +        */
> > > +
> > > +       /* MPTCPOPT_MP_FASTCLOSE
> > > +        * 0: 4MSB=3Dsubtype, 0000
> > > +        * 1: 0 (Reserved)
> > > +        * 2-9: Receiver key
> > > +        */
> > > +       default:
> > > +               break;
> > > +       }
> > > +}
> > > +
> > > +void mptcp_get_options(const struct sk_buff *skb,
> > > +                      struct tcp_options_received *opt_rx)
> > > +{
> > > +       const unsigned char *ptr;
> > > +       const struct tcphdr *th =3D tcp_hdr(skb);
> > > +       int length =3D (th->doff * 4) - sizeof(struct tcphdr);
> > > +
> > > +       ptr =3D (const unsigned char *)(th + 1);
> > > +
> > > +       while (length > 0) {
> > > +               int opcode =3D *ptr++;
> > > +               int opsize;
> > > +
> > > +               switch (opcode) {
> > > +               case TCPOPT_EOL:
> > > +                       return;
> > > +               case TCPOPT_NOP:        /* Ref: RFC 793 section 3.1 */
> > > +                       length--;
> > > +                       continue;
> > > +               default:
> > > +                       opsize =3D *ptr++;
> > > +                       if (opsize < 2) /* "silly options" */
> > > +                               return;
> > > +                       if (opsize > length)
> > > +                               return; /* don't parse partial option=
s */
> > > +                       if (opcode =3D=3D TCPOPT_MPTCP)
> > > +                               mptcp_parse_option(ptr, opsize, opt_r=
x);
> > > +                       ptr +=3D opsize - 2;
> > > +                       length -=3D opsize;
> > > +               }
> > > +       }
> > > +}
> > > --
> > > 2.19.1
> > >
> > > _______________________________________________
> > > mptcp mailing list
> > > mptcp(a)lists.01.org
> > > https://lists.01.org/mailman/listinfo/mptcp
> >
> >
> >



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============3393372844913026786==--
