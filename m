Content-Type: multipart/mixed; boundary="===============6923053780023765194=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: fix length of ADD_ADDR with port
 suboption
Date: Fri, 05 Mar 2021 10:14:08 +0800
Message-ID: <CA+WQbwtm2FXSQL1MX2OToa4hC+P1svdw4JDdLwSjuGEPBWjU2w@mail.gmail.com>
In-Reply-To: bc0a1f5-8dc3-6212-7884-4c51b6a61ba@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8042

--===============6923053780023765194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=888:28=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Thu, 4 Mar 2021, Davide Caratti wrote:
>
> > in current Linux, MPTCP peers advertising endpoints with port numbers u=
se
> > a sub-option length that wrongly accounts for the trailing TCP NOP. Als=
o,
> > receivers will only process incoming ADD_ADDR with port having such wro=
ng
> > sub-option length. Fix this, making ADD_ADDR compliant to RFC8684 =C2=
=A73.4.1.
> >
> > this can be verified running tcpdump on the kselftests artifacts:
> >
> > unpatched kernel:
> > [root(a)bottarga mptcp]# tcpdump -tnnr unpatched.pcap | grep add-addr
> > reading from file unpatched.pcap, link-type LINUX_SLL (Linux cooked v1)=
, snapshot length 65535
> > IP 10.0.1.1.10000 > 10.0.1.2.53078: Flags [.], ack 101, win 509, option=
s [nop,nop,TS val 214459678 ecr 521312851,mptcp add-addr v1 id 1 a00:201:27=
74:2d88:7436:85c3:17fd:101], length 0
> > IP 10.0.1.2.53078 > 10.0.1.1.10000: Flags [.], ack 101, win 502, option=
s [nop,nop,TS val 521312852 ecr 214459678,mptcp add-addr[bad opt]]
> >
> > patched kernel:
> > [root(a)bottarga mptcp]# tcpdump -tnnr patched.pcap | grep add-addr
> > reading from file patched.pcap, link-type LINUX_SLL (Linux cooked v1), =
snapshot length 65535
> > IP 10.0.1.1.10000 > 10.0.1.2.38178: Flags [.], ack 101, win 509, option=
s [nop,nop,TS val 3728873902 ecr 2732713192,mptcp add-addr v1 id 1 10.0.2.1=
:10100 hmac 0xbccdfcbe59292a1f,nop,nop], length 0
> > IP 10.0.1.2.38178 > 10.0.1.1.10000: Flags [.], ack 101, win 502, option=
s [nop,nop,TS val 2732713195 ecr 3728873902,mptcp add-addr v1-echo id 1 10.=
0.2.1:10100,nop,nop], length 0
> >
> > Fixes: 22fb85ffaefb ("mptcp: add port support for ADD_ADDR suboption wr=
iting")
> > CC: stable(a)vger.kernel.org # 5.11+
> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> > net/mptcp/protocol.h | 14 ++++++++------
> > 1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 91827d949766..e21a5bc36cf0 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -52,14 +52,15 @@
> > #define TCPOLEN_MPTCP_DSS_MAP64               14
> > #define TCPOLEN_MPTCP_DSS_CHECKSUM    2
> > #define TCPOLEN_MPTCP_ADD_ADDR                16
> > -#define TCPOLEN_MPTCP_ADD_ADDR_PORT  20
> > +#define TCPOLEN_MPTCP_ADD_ADDR_PORT  18
> > #define TCPOLEN_MPTCP_ADD_ADDR_BASE   8
> > -#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT     12
> > +#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT     10
> > #define TCPOLEN_MPTCP_ADD_ADDR6               28
> > -#define TCPOLEN_MPTCP_ADD_ADDR6_PORT 32
> > +#define TCPOLEN_MPTCP_ADD_ADDR6_PORT 30
> > #define TCPOLEN_MPTCP_ADD_ADDR6_BASE  20
> > -#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT    24
> > -#define TCPOLEN_MPTCP_PORT_LEN               4
> > +#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT    22
> > +#define TCPOLEN_MPTCP_PORT_LEN               2
> > +#define TCPOLEN_MPTCP_PORT_ALIGN     2
> > #define TCPOLEN_MPTCP_RM_ADDR_BASE    4
> > #define TCPOLEN_MPTCP_PRIO            3
> > #define TCPOLEN_MPTCP_PRIO_ALIGN      4
> > @@ -701,8 +702,9 @@ static inline unsigned int mptcp_add_addr_len(int f=
amily, bool echo, bool port)
> >               len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >       if (!echo)
> >               len +=3D MPTCPOPT_THMAC_LEN;
> > +     /* account for 2 trailing 'nop' options */
> >       if (port)
> > -             len +=3D TCPOLEN_MPTCP_PORT_LEN;
> > +             len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIG=
N;
> >
> >       return len;
> > }
> > --
> > 2.29.2
>
> Thanks Davide - fix looks good to me for -net and stable.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>

Acked-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

> --
> Mat Martineau
> Intel
--===============6923053780023765194==--
