Content-Type: multipart/mixed; boundary="===============4504101810016730561=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 3/5] mptcp: add mptcp reset option support
Date: Mon, 09 Nov 2020 12:55:05 +0800
Message-ID: <CA+WQbws1X2nXF9bGg7-tze+RjXHxdz5WYvqKWK2xU=bDHAisVQ@mail.gmail.com>
In-Reply-To: 20201105170126.5627-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6588

--===============4504101810016730561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> =E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:01=E5=86=99=E9=81=93=EF=BC=9A
>
> The MPTCP reset option allows to carry a mptcp-specific error
> code that provides more information on the nature of a connection
> reset.
>
> The Reset option data received gets stored in the mptcp skb
> extension structure so it can be consumed by e.g. path management.
>
> When a subflow is closed, the desired error code that should be sent
> to the peer is placed in the subflow context structure.
>
> If close happens before a suitable tcp socket has been created
> (for example, when HMAC fails validation), the reset code can be placed
> in the mptcp skb extension which then gets added to the TCP reset skb.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  include/net/mptcp.h  |  6 ++++--
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp_ipv4.c  | 21 ++++++++++++++++++++-
>  net/ipv6/tcp_ipv6.c  | 19 +++++++++++++++++++
>  net/mptcp/options.c  | 42 +++++++++++++++++++++++++++++++++++++-----
>  net/mptcp/protocol.c | 12 +++++++++---
>  net/mptcp/protocol.h | 18 ++++++++++++++++++
>  net/mptcp/subflow.c  | 27 ++++++++++++++++++++++++---
>  8 files changed, 134 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 3d57607982fa..0aed06330a25 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -30,8 +30,8 @@ struct mptcp_ext {
>                         ack64:1,
>                         mpc_map:1,
>                         frozen:1,
> -                       __unused:1;
> -       /* one byte hole */
> +                       reset_transient:1;
> +       u8              reset_reason:4;
>  };
>
>  struct mptcp_out_options {
> @@ -50,6 +50,8 @@ struct mptcp_out_options {
>         u8 rm_id;
>         u8 join_id;
>         u8 backup;
> +       u8 reset_reason:4;
> +       u8 reset_transient:1;
>         u32 nonce;
>         u64 thmac;
>         u32 token;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c0fef9e9ba20..899f87346b49 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -193,6 +193,8 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
>  #define TCPOPT_FASTOPEN_MAGIC  0xF989
>  #define TCPOPT_SMC_MAGIC       0xE2D4C3D9
>
> +/* MPTCP suboptions used in TCP */
> +#define MPTCPOPT_RST           8

And define MPTCPOPT_RST in net/mptcp/protocol.h, together with all other
MPTCP suboptions ... ...

>  /*
>   *     TCP option lengths
>   */
> @@ -216,6 +218,7 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
>  #define TCPOLEN_MD5SIG_ALIGNED         20
>  #define TCPOLEN_MSS_ALIGNED            4
>  #define TCPOLEN_EXP_SMC_BASE_ALIGNED   8
> +#define TCPOLEN_MPTCP_RST              4

And define TCPOLEN_MPTCP_RST in include/net/mptcp.h ... ...

>
>  /* Flags in tp->nonagle */
>  #define TCP_NAGLE_OFF          1       /* Nagle's algo is disabled */
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 7352c097ae48..c96aea5514c6 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -660,9 +660,11 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
>         const struct tcphdr *th =3D tcp_hdr(skb);
>         struct {
>                 struct tcphdr th;
> +               __be32 opt[(TCPOLEN_MPTCP_RST >> 2)
>  #ifdef CONFIG_TCP_MD5SIG
> -               __be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
> +                          + (TCPOLEN_MD5SIG_ALIGNED >> 2)
>  #endif
> +                       ];
>         } rep;
>         struct ip_reply_arg arg;
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -770,6 +772,23 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
>                                      ip_hdr(skb)->daddr, &rep.th);
>         }
>  #endif
> +       /* Can't co-exist with TCPMD5, hence check rep.opt[0] */
> +       if (sk && sk_fullsock(sk) && sk_is_mptcp(sk) && rep.opt[0] =3D=3D=
 0) {
> +               const struct mptcp_ext *ext =3D mptcp_get_ext(skb);
> +               u8 flags =3D 0, reason =3D 0;
> +
> +               if (ext) {
> +                       flags =3D ext->reset_transient;
> +                       reason =3D ext->reset_reason;
> +               }
> +
> +               rep.opt[0] =3D mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_R=
ST,
> +                                         flags, reason);

And use mptcp_option's wrapper function here ... ...


> +
> +               arg.iov[0].iov_len +=3D TCPOLEN_MPTCP_RST;
> +               rep.th.doff =3D arg.iov[0].iov_len / 4;
> +       }
> +
>         arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
>                                       ip_hdr(skb)->saddr, /* XXX */
>                                       arg.iov[0].iov_len, IPPROTO_TCP, 0);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 8db59f4e5f13..cfe8d6b4c34c 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -868,6 +868,7 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
>         struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev=
);
>         struct sock *ctl_sk =3D net->ipv6.tcp_sk;
>         unsigned int tot_len =3D sizeof(struct tcphdr);
> +       bool mptcp_reset =3D false;
>         struct dst_entry *dst;
>         __be32 *topt;
>         __u32 mark =3D 0;
> @@ -879,6 +880,11 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
>                 tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
>  #endif
>
> +       if (rst && sk && sk_fullsock(sk) && sk_is_mptcp(sk) && !key) {
> +               tot_len +=3D TCPOLEN_MPTCP_RST;
> +               mptcp_reset =3D true;
> +       }
> +
>         buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
>                          GFP_ATOMIC);
>         if (!buff)
> @@ -909,6 +915,19 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
>                 *topt++ =3D htonl(tsecr);
>         }
>
> +       if (mptcp_reset) {
> +               const struct mptcp_ext *ext =3D mptcp_get_ext(skb);
> +               u8 flags =3D 0, reason =3D 0;
> +
> +               if (ext) {
> +                       flags =3D ext->reset_transient;
> +                       reason =3D ext->reset_reason;
> +               }
> +
> +               *topt++ =3D mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST,
> +                                      flags, reason);

And use mptcp_option's wrapper function here ... ...


The whole patch is like this:

--------
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0aed06330a25..3bc231a7dd99 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -34,6 +34,8 @@ struct mptcp_ext {
     u8        reset_reason:4;
 };

+#define TCPOLEN_MPTCP_RST        4
+
 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
     u16 suboptions;
@@ -155,6 +157,8 @@ void mptcp_seq_show(struct seq_file *seq);
 int mptcp_subflow_init_cookie_req(struct request_sock *req,
                   const struct sock *sk_listener,
                   struct sk_buff *skb);
+
+__be32 mptcp_option_rst(u8 flags, u8 reason);
 #else

 static inline void mptcp_init(void)
@@ -240,6 +244,11 @@ static inline int
mptcp_subflow_init_cookie_req(struct request_sock *req,
 {
     return 0; /* TCP fallback */
 }
+
+__be32 mptcp_option_rst(u8 flags, u8 reason)
+{
+    return 0;
+}
 #endif /* CONFIG_MPTCP */

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 899f87346b49..0a3a7ecfdc4b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -193,8 +193,6 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOPT_FASTOPEN_MAGIC    0xF989
 #define TCPOPT_SMC_MAGIC    0xE2D4C3D9

-/* MPTCP suboptions used in TCP */
-#define MPTCPOPT_RST        8
 /*
  *     TCP option lengths
  */
@@ -218,7 +216,6 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MD5SIG_ALIGNED        20
 #define TCPOLEN_MSS_ALIGNED        4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED    8
-#define TCPOLEN_MPTCP_RST        4

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF        1    /* Nagle's algo is disabled */
@@ -2380,9 +2377,4 @@ static inline u64 tcp_transmit_time(const struct sock=
 *sk)
     return 0;
 }

-static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
-{
-    return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
-             ((nib & 0xF) << 8) | field);
-}
 #endif    /* _TCP_H */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c96aea5514c6..c93f820709df 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -782,8 +782,7 @@ static void tcp_v4_send_reset(const struct sock
*sk, struct sk_buff *skb)
             reason =3D ext->reset_reason;
         }

-        rep.opt[0] =3D mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST,
-                      flags, reason);
+        rep.opt[0] =3D mptcp_option_rst(flags, reason);

         arg.iov[0].iov_len +=3D TCPOLEN_MPTCP_RST;
         rep.th.doff =3D arg.iov[0].iov_len / 4;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index cfe8d6b4c34c..2f903f78051f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -924,8 +924,7 @@ static void tcp_v6_send_response(const struct sock
*sk, struct sk_buff *skb, u32
             reason =3D ext->reset_reason;
         }

-        *topt++ =3D mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST,
-                       flags, reason);
+        *topt++ =3D mptcp_option_rst(flags, reason);
     }

 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 08b60d527de0..2cda5bf46372 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -706,6 +706,12 @@ static bool
mptcp_established_options_fastclose(struct sock *sk,
     return true;
 }

+__be32 mptcp_option_rst(u8 flags, u8 reason)
+{
+    return mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST,
+                flags, reason);
+}
+
 static noinline void mptcp_established_options_rst(struct sock *sk,
struct sk_buff *skb,
                            unsigned int *size,
                            unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93352044bff9..c7f8df418ce1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -35,6 +35,7 @@
 #define MPTCPOPT_MP_PRIO    5
 #define MPTCPOPT_MP_FAIL    6
 #define MPTCPOPT_MP_FASTCLOSE    7
+#define MPTCPOPT_RST        8

 /* MPTCP suboption lengths */
 #define TCPOLEN_MPTCP_MPC_SYN        4
@@ -158,6 +159,12 @@ struct mptcp_options_received {
     u16    port;
 };

+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+    return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+             ((nib & 0xF) << 8) | field);
+}
+
 struct mptcp_addr_info {
     sa_family_t        family;
     __be16            port;
--------

I didn't tested this patch, hope it works well.

-Geliang


> +       }
> +
>  #ifdef CONFIG_TCP_MD5SIG
>         if (key) {
>                 *topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)=
 |
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 248e3930c0cb..785a9f4e7da8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -281,7 +281,17 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
>                 mp_opt->rm_id =3D *ptr++;
>                 pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
>                 break;
> +       case MPTCPOPT_RST:
> +               if (opsize !=3D TCPOLEN_MPTCP_RST)
> +                       break;
>
> +               if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> +                       break;
> +               mp_opt->reset =3D 1;
> +               flags =3D *ptr++;
> +               mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
> +               mp_opt->reset_reason =3D *ptr;
> +               break;
>         default:
>                 break;
>         }
> @@ -302,6 +312,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>         mp_opt->port =3D 0;
>         mp_opt->rm_addr =3D 0;
>         mp_opt->dss =3D 0;
> +       mp_opt->reset =3D 0;
>
>         length =3D (th->doff * 4) - sizeof(struct tcphdr);
>         ptr =3D (const unsigned char *)(th + 1);
> @@ -660,6 +671,22 @@ static bool mptcp_established_options_rm_addr(struct=
 sock *sk,
>         return true;
>  }
>
> +static noinline void mptcp_established_options_rst(struct sock *sk, stru=
ct sk_buff *skb,
> +                                                  unsigned int *size,
> +                                                  unsigned int remaining,
> +                                                  struct mptcp_out_optio=
ns *opts)
> +{
> +       const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx=
(sk);
> +
> +       if (remaining < TCPOLEN_MPTCP_RST)
> +               return;
> +
> +       *size =3D TCPOLEN_MPTCP_RST;
> +       opts->suboptions |=3D OPTION_MPTCP_RST;
> +       opts->reset_transient =3D subflow->reset_transient;
> +       opts->reset_reason =3D subflow->reset_reason;
> +}
> +
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>                                unsigned int *size, unsigned int remaining,
>                                struct mptcp_out_options *opts)
> @@ -672,11 +699,10 @@ bool mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
>         if (unlikely(mptcp_check_fallback(sk)))
>                 return false;
>
> -       /* prevent adding of any MPTCP related options on reset packet
> -        * until we support MP_TCPRST/MP_FASTCLOSE
> -        */
> -       if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> -               return false;
> +       if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> +               mptcp_established_options_rst(sk, skb, size, remaining, o=
pts);
> +               return true;
> +       }
>
>         if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, o=
pts))
>                 ret =3D true;
> @@ -1137,6 +1163,12 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
>                 ptr +=3D 5;
>         }
>
> +       if (OPTION_MPTCP_RST & opts->suboptions)
> +               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> +                                     TCPOLEN_MPTCP_RST,
> +                                     opts->reset_transient,
> +                                     opts->reset_reason);
> +
>         if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
>                 struct mptcp_ext *mpext =3D &opts->ext_copy;
>                 u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a6bd06c724d5..71e556540161 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2608,14 +2608,18 @@ bool mptcp_finish_join(struct sock *ssk)
>         pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
>
>         /* mptcp socket already closing? */
> -       if (!mptcp_is_fully_established(parent))
> +       if (!mptcp_is_fully_established(parent)) {
> +               subflow->reset_reason =3D MPTCP_RST_EMPTCP;
>                 return false;
> +       }
>
>         if (!msk->pm.server_side)
>                 return true;
>
> -       if (!mptcp_pm_allow_new_subflow(msk))
> +       if (!mptcp_pm_allow_new_subflow(msk)) {
> +               subflow->reset_reason =3D MPTCP_RST_EPROHIBIT;
>                 return false;
> +       }
>
>         /* active connections are already on conn_list, and we can't acqu=
ire
>          * msk lock here.
> @@ -2629,8 +2633,10 @@ bool mptcp_finish_join(struct sock *ssk)
>                 sock_hold(ssk);
>         }
>         spin_unlock_bh(&msk->join_list_lock);
> -       if (!ret)
> +       if (!ret) {
> +               subflow->reset_reason =3D MPTCP_RST_EPROHIBIT;
>                 return false;
> +       }
>
>         /* attach to msk socket only after we are sure he will deal with =
us
>          * at close time
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 66bd4d096753..8a247e50d326 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -23,6 +23,7 @@
>  #define OPTION_MPTCP_ADD_ADDR  BIT(6)
>  #define OPTION_MPTCP_ADD_ADDR6 BIT(7)
>  #define OPTION_MPTCP_RM_ADDR   BIT(8)
> +#define OPTION_MPTCP_RST       BIT(9)
>
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE    0
> @@ -84,6 +85,18 @@
>  #define MPTCP_ADDR_IPVERSION_4 4
>  #define MPTCP_ADDR_IPVERSION_6 6
>
> +/* MPTCP TCPRST flags */
> +#define MPTCP_RST_TRANSIENT    BIT(0)
> +
> +/* MPTCP Reset reason codes, rfc8684 */
> +#define MPTCP_RST_EUNSPEC      0
> +#define MPTCP_RST_EMPTCP       1
> +#define MPTCP_RST_ERESOURCE    2
> +#define MPTCP_RST_EPROHIBIT    3
> +#define MPTCP_RST_EWQ2BIG      4
> +#define MPTCP_RST_EBADPERF     5
> +#define MPTCP_RST_EMIDDLEBOX   6
> +
>  /* MPTCP socket flags */
>  #define MPTCP_DATA_READY       0
>  #define MPTCP_NOSPACE          1
> @@ -109,6 +122,7 @@ struct mptcp_options_received {
>         u16     data_len;
>         u16     mp_capable : 1,
>                 mp_join : 1,
> +               reset : 1,
>                 dss : 1,
>                 add_addr : 1,
>                 rm_addr : 1,
> @@ -129,6 +143,8 @@ struct mptcp_options_received {
>                 __unused:2;
>         u8      addr_id;
>         u8      rm_id;
> +       u8      reset_reason:4;
> +       u8      reset_transient:1;
>         union {
>                 struct in_addr  addr;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -365,6 +381,8 @@ struct mptcp_subflow_context {
>         u8      hmac[MPTCPOPT_HMAC_LEN];
>         u8      local_id;
>         u8      remote_id;
> +       u8      reset_transient:1;
> +       u8      reset_reason:4;
>
>         struct  sock *tcp_sock;     /* tcp sk backpointer */
>         struct  sock *conn;         /* parent mptcp_sock */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1e9a72af67dc..e0da6712a5c3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -325,8 +325,10 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
>         } else if (subflow->request_join) {
>                 u8 hmac[SHA256_DIGEST_SIZE];
>
> -               if (!mp_opt.mp_join)
> +               if (!mp_opt.mp_join) {
> +                       subflow->reset_reason =3D MPTCP_RST_EMPTCP;
>                         goto do_reset;
> +               }
>
>                 subflow->thmac =3D mp_opt.thmac;
>                 subflow->remote_nonce =3D mp_opt.nonce;
> @@ -335,6 +337,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>
>                 if (!subflow_thmac_valid(subflow)) {
>                         MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMA=
C);
> +                       subflow->reset_reason =3D MPTCP_RST_EMPTCP;
>                         goto do_reset;
>                 }
>
> @@ -356,6 +359,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>         return;
>
>  do_reset:
> +       subflow->reset_transient =3D 0;
>         mptcp_subflow_reset(sk);
>  }
>
> @@ -505,6 +509,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         struct mptcp_options_received mp_opt;
>         bool fallback, fallback_is_fatal;
>         struct sock *new_msk =3D NULL;
> +       struct mptcp_ext *mpext;
>         struct sock *child;
>
>         pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, lis=
tener->conn);
> @@ -565,8 +570,15 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>                  * to reset the context to non MPTCP status.
>                  */
>                 if (!ctx || fallback) {
> -                       if (fallback_is_fatal)
> +                       if (fallback_is_fatal) {
> +                               mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +                               if (mpext) {
> +                                       memset(mpext, 0, sizeof(*mpext));
> +                                       mpext->reset_reason =3D MPTCP_RST=
_EMPTCP;
> +                               }
> +
>                                 goto dispose_child;
> +                       }
>
>                         subflow_drop_ctx(child);
>                         goto out;
> @@ -600,8 +612,15 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>                         struct mptcp_sock *owner;
>
>                         owner =3D subflow_req->msk;
> -                       if (!owner)
> +                       if (!owner) {
> +                               mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +                               if (mpext) {
> +                                       memset(mpext, 0, sizeof(*mpext));
> +                                       mpext->reset_reason =3D MPTCP_RST=
_EPROHIBIT;
> +                               }
> +
>                                 goto dispose_child;
> +                       }
>
>                         /* move the msk reference ownership to the subflo=
w */
>                         subflow_req->msk =3D NULL;
> @@ -936,6 +955,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
>         smp_wmb();
>         ssk->sk_error_report(ssk);
>         tcp_set_state(ssk, TCP_CLOSE);
> +       subflow->reset_transient =3D 0;
> +       subflow->reset_reason =3D MPTCP_RST_EMPTCP;
>         tcp_send_active_reset(ssk, GFP_ATOMIC);
>         subflow->data_avail =3D 0;
>         return false;
> --
> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4504101810016730561==--
