Content-Type: multipart/mixed; boundary="===============0687065774680900892=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 1/5] tcp: make two mptcp helpers available
 to tcp stack
Date: Mon, 09 Nov 2020 12:54:12 +0800
Message-ID: <CA+WQbwuy3+ivf=WB6c5b18NduzS8Fg2Wv8DAuGXmM-7Z3G5sKg@mail.gmail.com>
In-Reply-To: 20201105170126.5627-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6587

--===============0687065774680900892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thanks for your patches.

Florian Westphal <fw(a)strlen.de> =E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:01=E5=86=99=E9=81=93=EF=BC=9A
>
> needed by followup patches to add mptcp reset (and fastclose)
> options to tcp reset packets.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  include/net/mptcp.h  | 10 ++++++++++
>  include/net/tcp.h    |  5 +++++
>  net/mptcp/protocol.h | 11 -----------
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index b6cf07143a8a..3d57607982fa 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -78,6 +78,11 @@ static inline bool rsk_drop_req(const struct request_s=
ock *req)
>         return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
>  }
>
> +static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> +{
> +       return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
> +}
> +
>  void mptcp_space(const struct sock *ssk, int *space, int *full_space);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>                        unsigned int *size, struct mptcp_out_options *opts=
);
> @@ -169,6 +174,11 @@ static inline bool rsk_drop_req(const struct request=
_sock *req)
>         return false;
>  }
>
> +static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> +{
> +       return NULL;
> +}
> +
>  static inline void mptcp_parse_option(const struct sk_buff *skb,
>                                       const unsigned char *ptr, int opsiz=
e,
>                                       struct tcp_options_received *opt_rx)
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f3d42cb626fc..8115164e0df6 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2377,4 +2377,9 @@ static inline u64 tcp_transmit_time(const struct so=
ck *sk)
>         return 0;
>  }
>
> +static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> +{
> +       return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
> +                    ((nib & 0xF) << 8) | field);
> +}

I think we should avoid adding code in tcp.h, should it be better to define=
 a
wrapper function of mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST, ..., ...)
in net/mptcp/options.c and export it in include/net/mptcp.h? ... ...





>  #endif /* _TCP_H */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d29c6a4749eb..66bd4d096753 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -139,12 +139,6 @@ struct mptcp_options_received {
>         u16     port;
>  };
>
> -static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> -{
> -       return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
> -                    ((nib & 0xF) << 8) | field);
> -}
> -
>  struct mptcp_addr_info {
>         sa_family_t             family;
>         __be16                  port;
> @@ -568,11 +562,6 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock =
*msk);
>  void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
>  int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common =
*skc);
>
> -static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> -{
> -       return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
> -}
> -
>  void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
>
>  static inline bool __mptcp_check_fallback(const struct mptcp_sock *msk)
> --
> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============0687065774680900892==--
