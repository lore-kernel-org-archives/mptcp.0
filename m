Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0311177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:58:31 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id h1so4400730plt.1
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCgPNGdqWi93W3kfTdoF4ix4PtQxSemOVgXXABi/LyE=;
        b=OryUu4Io1cE5f1/Iuvjl0tcoBEC0z4Qm4pDwDNPyAaOGhnJfmzO/urw0XRgZpZORmM
         RNIn7RLF/ob/CP6rgzNH8UJu6ne7lW4aocBs5FlBrEDTyQR+m+SyAyMS2b2ltl8M7BOw
         3n+dzUZ/ul9qCiwP4b1mzeEDTRWcXWxMZYrLfUBJPc6ejYkcte8dnQtbvHWxVTFwho4Z
         1Dc8mEWMySt8blks486o+BmPmOtcclBfdJ9L40s/56ru7inAIz3/cv7jEoRswbeQeH3m
         G9KvCO1fqNUHEoSx20/LegLtI9qH/bQFwJIW7Q7KBupddXZLOcpT+QIFpC178WRNlCfK
         YE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCgPNGdqWi93W3kfTdoF4ix4PtQxSemOVgXXABi/LyE=;
        b=uZJdnfEzA1ByRr9Ci6efTW9dVN0G/iqrFsoJLJP8dHPohv/SXo3pl2UQPTNrQW4GdV
         m3aN69fKnyhyPHJFKPPOc9ocLVeVOzTqxUndgPTSI7o1LM9cpzYBHnQAcWfII31zLqPY
         Xr5k/RfU6ee8hOIS/5CGki8CmBr/0a/K3ZPW7g/AfUEUswAZgamrxQaU+k+4IWLJz43l
         0xZ4ffQrknhfQZSiO/FL2N61KxlXbYGqd7ROOikof6fa2zBXbTjL0uSE4eisM6eOPawH
         UmPvstfWLUykH6HnUDyY/XVDi8X3T9Y5aw79GyD239Z5ZE00UphpZFXB6Smylo57y7Al
         SaCg==
X-Gm-Message-State: AOAM530QYPctSyKeFrV69FFwiRvdzhnpPt0uCIeXKob5H67n5hNo0snm
	IKcfMegO515rkUxNJISm3LIazymPdaakt2muvHo=
X-Google-Smtp-Source: ABdhPJzX8rvrOEJ1Q+G4laYojdWjrRufdRrWELNNLRi9T/OIMXPF660xIlmRF1f6AcD3HYqBBmMD71WX/CH93k92+I4=
X-Received: by 2002:a17:90a:7843:: with SMTP id y3mr9994934pjl.190.1624611511315;
 Fri, 25 Jun 2021 01:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com> <1624609559-6786-5-git-send-email-wujianguo106@163.com>
In-Reply-To: <1624609559-6786-5-git-send-email-wujianguo106@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Jun 2021 16:58:19 +0800
Message-ID: <CA+WQbwtE-UTpORMrSZFidAbcGaZBoRQv-BzR+2juxOt7kjfurA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Thank you for this patchset!

<wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=
=E4=BA=94 =E4=B8=8B=E5=8D=884:26=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> If check_fully_established() causes a subflow reset, it should not
> continue to process the packet in tcp_data_queue().
> Add a return value to mptcp_incoming_options(), and return 0 if a
> subflow has been reset, else return 1. Then drop the packet in
> tcp_data_queue()/tcp_rcv_state_process() if mptcp_incoming_options()
> return 0.
>
> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  include/net/mptcp.h  |  5 +++--
>  net/ipv4/tcp_input.c | 19 +++++++++++++++----
>  net/mptcp/options.c  | 22 ++++++++++++++--------
>  3 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index cb580b0..cbd511c 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -105,7 +105,7 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>                                unsigned int *size, unsigned int remaining=
,
>                                struct mptcp_out_options *opts);
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> +int mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>                          struct mptcp_out_options *opts);
> @@ -227,9 +227,10 @@ static inline bool mptcp_established_options(struct =
sock *sk,
>         return false;
>  }
>
> -static inline void mptcp_incoming_options(struct sock *sk,
> +static inline int mptcp_incoming_options(struct sock *sk,
>                                           struct sk_buff *skb)
>  {
> +       return 1;
>  }
>
>  static inline void mptcp_skb_ext_move(struct sk_buff *to,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7d5e59f..4bacd7d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4247,6 +4247,9 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb=
)
>  {
>         trace_tcp_receive_reset(sk);
>
> +       /* mptcp can't tell us to ignore reset pkts,
> +        * so just ignore the return value of mptcp_incoming_options().
> +        */
>         if (sk_is_mptcp(sk))
>                 mptcp_incoming_options(sk, skb);
>
> @@ -4941,8 +4944,13 @@ static void tcp_data_queue(struct sock *sk, struct=
 sk_buff *skb)
>         bool fragstolen;
>         int eaten;
>
> -       if (sk_is_mptcp(sk))
> -               mptcp_incoming_options(sk, skb);
> +       /* If a subflow has been reset, the packet should not continue
> +        * to be processed, drop the packet.
> +        */
> +       if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
> +               __kfree_skb(skb);
> +               return;
> +       }
>
>         if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
>                 __kfree_skb(skb);
> @@ -6523,8 +6531,11 @@ int tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
>         case TCP_CLOSING:
>         case TCP_LAST_ACK:
>                 if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
> -                       if (sk_is_mptcp(sk))
> -                               mptcp_incoming_options(sk, skb);
> +                       /* If a subflow has been reset, the packet should=
 not
> +                        * continue to be processed, drop the packet.
> +                        */
> +                       if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk=
, skb))
> +                               goto discard;
>                         break;
>                 }
>                 fallthrough;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b5850af..f4842b5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -856,7 +856,8 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
>  static bool check_fully_established(struct mptcp_sock *msk, struct sock =
*ssk,
>                                     struct mptcp_subflow_context *subflow=
,
>                                     struct sk_buff *skb,
> -                                   struct mptcp_options_received *mp_opt=
)
> +                                   struct mptcp_options_received *mp_opt=
,
> +                                   bool *subflow_is_rst)
>  {
>         /* here we can process OoO, in-window pkts, only in-sequence 4th =
ack
>          * will make the subflow fully established
> @@ -938,6 +939,7 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *ssk,
>         return true;
>
>  reset:
> +       *subflow_is_rst =3D true;
>         mptcp_subflow_reset(ssk);
>         return false;
>  }
> @@ -1035,12 +1037,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock=
 *msk,
>         return hmac =3D=3D mp_opt->ahmac;
>  }
>
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> +/* Return 0 if a subflow has been reset, else return 1 */

How about returning a bool here, return true or return false?

-Geliang

> +int mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  {
>         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         struct mptcp_options_received mp_opt;
>         struct mptcp_ext *mpext;
> +       bool subflow_is_rst =3D false;
>
>         if (__mptcp_check_fallback(msk)) {
>                 /* Keep it simple and unconditionally trigger send data c=
leanup and
> @@ -1053,12 +1057,12 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
>                         __mptcp_check_push(subflow->conn, sk);
>                 __mptcp_data_acked(subflow->conn);
>                 mptcp_data_unlock(subflow->conn);
> -               return;
> +               return 1;
>         }
>
>         mptcp_get_options(sk, skb, &mp_opt);
> -       if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> -               return;
> +       if (!check_fully_established(msk, sk, subflow, skb, &mp_opt, &sub=
flow_is_rst))
> +               return subflow_is_rst ? 0 : 1;
>
>         if (mp_opt.fastclose &&
>             msk->local_key =3D=3D mp_opt.rcvr_key) {
> @@ -1100,7 +1104,7 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>         }
>
>         if (!mp_opt.dss)
> -               return;
> +               return 1;
>
>         /* we can't wait for recvmsg() to update the ack_seq, otherwise
>          * monodirectional flows will stuck
> @@ -1119,12 +1123,12 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
>                     schedule_work(&msk->work))
>                         sock_hold(subflow->conn);
>
> -               return;
> +               return 1;
>         }
>
>         mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>         if (!mpext)
> -               return;
> +               return 1;
>
>         memset(mpext, 0, sizeof(*mpext));
>
> @@ -1153,6 +1157,8 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>                 if (mpext->csum_reqd)
>                         mpext->csum =3D mp_opt.csum;
>         }
> +
> +       return 1;
>  }
>
>  static void mptcp_set_rwin(const struct tcp_sock *tp)
> --
> 1.8.3.1
>
>
>
