Content-Type: multipart/mixed; boundary="===============5699033376151327827=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: fix length of MP_PRIO sub-option
Date: Thu, 28 Jan 2021 11:08:16 +0800
Message-ID: <CA+WQbwsaAZ=SuvTw8yNS+Di_s74CWi6H2nR1BXMN0V2CvxSCxg@mail.gmail.com>
In-Reply-To: cf358e0e1e2b22a4951b87d90e71d8b07211c1a6.1611783704.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7499

--===============5699033376151327827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

Thanks for adding the MP_PRIO support in the packetdrill, and for this fix.

Davide Caratti <dcaratti(a)redhat.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8828=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=885:43=E5=86=99=E9=81=93=EF=BC=
=9A
>
> With version 0 of the protocol it was legal to encode the 'Subflow Id' in
> the MP_PRIO suboption, to specify which subflow would change its 'Backup'
> flag. This has been removed from v1 specification: thus, according to RFC
> 8684 =C2=A73.3.8, the resulting 'Length' of MP_PRIO changed from 4 to 3 b=
ytes.
>
> Current Linux generates / parses MP_PRIO according to the old spec, using
> 'Length' equal to 4, and hardcoding 1 as 'Subflow Id'; RFC compliance can
> improve if we change 'Length' in other to become 3, leaving a 'Nop' after
> the MP_PRIO suboption. In this way the kernel will emit and accept *only*
> MP_PRIO suboptions that are compliant to version 1 of the MPTCP protocol.
>
>  unpatched kernel:
>  $ tcpdump --number -tnnr unpatched.pcap | grep prio
>  reading from file unpatched.pcap, link-type LINUX_SLL (Linux cooked v1),=
 snapshot length 65535
>    76  IP 10.0.1.1.10006 > 10.0.1.2.53982: Flags [.], ack 301, win 256, o=
ptions [nop,nop,TS val 600859890 ecr 1213685745,mptcp prio non-backup id 1,=
mptcp dss ack 13257926699604102366], length 0
>    77  IP 10.0.3.2.40019 > 10.0.1.1.10006: Flags [.], ack 1, win 256, opt=
ions [nop,nop,TS val 2488720994 ecr 3187547357,mptcp prio non-backup id 1,m=
ptcp dss ack 4016099686801387019], length 0
>
>  patched kernel:
>  $ tcpdump --number -tnnr patched.pcap | grep prio
>  reading from file patched.pcap, link-type LINUX_SLL (Linux cooked v1), s=
napshot length 65535
>    77  IP 10.0.1.1.10006 > 10.0.1.2.44058: Flags [.], ack 301, win 509, o=
ptions [nop,nop,TS val 1313569662 ecr 1198445302,mptcp prio non-backup,nop,=
mptcp dss ack 14169869632263667042], length 0
>    78  IP 10.0.3.2.42645 > 10.0.1.1.10006: Flags [.], ack 1, win 502, opt=
ions [nop,nop,TS val 4000297703 ecr 2471781012,mptcp prio non-backup,nop,mp=
tcp dss ack 5132559192566117977], length 0
>
> Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
> Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/options.c  | 4 ++--
>  net/mptcp/protocol.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 775f0576592e..bb9230dda9fe 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -283,7 +283,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>                 break;
>
>         case MPTCPOPT_MP_PRIO:
> -               if (opsize !=3D TCPOLEN_MPTCP_PRIO)
> +               if (opsize !=3D TCPOLEN_MPTCP_PRIO_NOID)
>                         break;
>
>                 mp_opt->mp_prio =3D 1;
> @@ -1224,7 +1224,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
>                 subflow->send_mp_prio =3D 0;
>
>                 *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
> -                                     TCPOLEN_MPTCP_PRIO,
> +                                     TCPOLEN_MPTCP_PRIO_NOID,
>                                       opts->backup, TCPOPT_NOP);
>         }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 447ce4631b43..7e18bbfe8f43 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -62,6 +62,7 @@
>  #define TCPOLEN_MPTCP_PORT_LEN         4
>  #define TCPOLEN_MPTCP_RM_ADDR_BASE     4
>  #define TCPOLEN_MPTCP_PRIO             4
> +#define TCPOLEN_MPTCP_PRIO_NOID                3

I think it's better to change TCPOLEN_MPTCP_PRIO to 3 directly, rather than
adding a new macro TCPOLEN_MPTCP_PRIO_NOID, since the implementation in
kernel is for v1 only, no need to consider compatibility with v0.

Accordingly, the "Fixes" tags need to be updated too. This tag
"Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")"
needs to be dropped.

-Geliang

>  #define TCPOLEN_MPTCP_FASTCLOSE                12
>
>  /* MPTCP MP_JOIN flags */
> --
> 2.29.2
>
--===============5699033376151327827==--
