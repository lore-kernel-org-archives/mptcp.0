Content-Type: multipart/mixed; boundary="===============3991696690875110698=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 03/12] mptcp: add port
 support for ADD_ADDR suboption writing
Date: Mon, 09 Nov 2020 14:13:52 +0800
Message-ID: <CA+WQbwvOxysQK34Rp3r7YCQTRLATAvvQr2JnByQqvxWYm9KjRg@mail.gmail.com>
In-Reply-To: fbbe902d-7888-8869-f094-c4f794a6cb4c@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6589

--===============3991696690875110698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
11=E6=9C=887=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=888:46=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Thu, 5 Nov 2020, Geliang Tang wrote:
>
> > In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
> > is 18 octets, but mptcp_write_options is 32-bit aligned, so we need to
> > pad it to 20 octets.
> >
> > This patch added a new field 'port' in mptcp_out_options. When this
> > field is set with a port number, we need to add up 4 octets for the
> > ADD_ADDR suboption, and put the port number into the suboption.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
>
> Thanks for the v3! First two patches look good.
>
>
> > include/net/mptcp.h  |  1 +
> > net/mptcp/options.c  | 27 ++++++++++++++++++++++++---
> > net/mptcp/protocol.h | 10 +++++-----
> > 3 files changed, 30 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index b6cf07143a8a..5694370be3d4 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -46,6 +46,7 @@ struct mptcp_out_options {
> > #endif
> >       };
> >       u8 addr_id;
> > +     u16 port;
> >       u64 ahmac;
> >       u8 rm_id;
> >       u8 join_id;
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 42b39148288f..464cb63b7d2b 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1079,6 +1079,9 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
> >                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > #endif
> >
> > +             if (opts->port)
> > +                     len +=3D TCPOLEN_MPTCP_PORT_LEN;
> > +
> >               if (opts->ahmac) {
> >                       len +=3D sizeof(opts->ahmac);
> >                       echo =3D 0;
> > @@ -1096,9 +1099,27 @@ void mptcp_write_options(__be32 *ptr, const stru=
ct tcp_sock *tp,
> >                       ptr +=3D 4;
> >               }
> > #endif
> > -             if (opts->ahmac) {
> > -                     put_unaligned_be64(opts->ahmac, ptr);
> > -                     ptr +=3D 2;
> > +
> > +             if (!opts->port) {
> > +                     if (opts->ahmac) {
> > +                             put_unaligned_be64(opts->ahmac, ptr);
> > +                             ptr +=3D 2;
> > +                     }
> > +             } else {
> > +                     if (opts->ahmac) {
> > +                             put_unaligned_be32(opts->port << 16 |
> > +                                                opts->ahmac >> 48, ptr=
);
> > +                             ptr +=3D 1;
> > +                             put_unaligned_be64(opts->ahmac << 16 |
> > +                                                TCPOPT_NOP << 8 |
> > +                                                TCPOPT_NOP, ptr);
> > +                             ptr +=3D 2;
>
> I made a comment about the byte ordering conversions in v1, and I was
> incorrect about shifting and combining the values before the endian
> conversion. The above code does work fine, sorry about that - and please
> reply if you ever think I have requested an incorrect change! That
> feedback is helpful.
>
> I do still think it would be clearer to use a temporary u8 pointer to
> write the values rather than splitting the ahmac across two calls, like
> this:

Thanks for your review, I have send out a squash-to patch to fix this.

>
> u8 *bptr =3D (u8 *)ptr;
>
> put_unaligned_be16(opts->port, bptr);
> bptr +=3D 2;
> put_unaligned_be64(opts->ahmac, bptr);
> bptr +=3D 8;
> put_unaligned_u16(TCPOPT_NOP << 8 | TCPOPT_NOP, bptr);

I only changed this put_unaligned_u16 to put_unaligned_be16 in my patch.
The other code is the same as yours.

-Geliang

>
> ptr +=3D 3;
>
> What do you think?
>
>
> > +                     } else {
> > +                             put_unaligned_be32(opts->port << 16 |
> > +                                                TCPOPT_NOP << 8 |
> > +                                                TCPOPT_NOP, ptr);
> > +                             ptr +=3D 1;
> > +                     }
> >               }
> >       }
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index d29c6a4749eb..f303c46bcc29 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -49,14 +49,14 @@
> > #define TCPOLEN_MPTCP_DSS_MAP64               14
> > #define TCPOLEN_MPTCP_DSS_CHECKSUM    2
> > #define TCPOLEN_MPTCP_ADD_ADDR                16
> > -#define TCPOLEN_MPTCP_ADD_ADDR_PORT  18
> > +#define TCPOLEN_MPTCP_ADD_ADDR_PORT  20
> > #define TCPOLEN_MPTCP_ADD_ADDR_BASE   8
> > -#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT     10
> > +#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT     12
> > #define TCPOLEN_MPTCP_ADD_ADDR6               28
> > -#define TCPOLEN_MPTCP_ADD_ADDR6_PORT 30
> > +#define TCPOLEN_MPTCP_ADD_ADDR6_PORT 32
> > #define TCPOLEN_MPTCP_ADD_ADDR6_BASE  20
> > -#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT    22
> > -#define TCPOLEN_MPTCP_PORT_LEN               2
> > +#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT    24
> > +#define TCPOLEN_MPTCP_PORT_LEN               4
> > #define TCPOLEN_MPTCP_RM_ADDR_BASE    4
> >
> > /* MPTCP MP_JOIN flags */
> > --
> > 2.26.2
>
> --
> Mat Martineau
> Intel
--===============3991696690875110698==--
