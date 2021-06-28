Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3A70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 08:35:55 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id s14so12235050pfg.0
        for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TWqRdvosDHQQOHY7nZ555ofpwHF33DkHkDvoFiPbgUI=;
        b=WWMARKW3LTdwAETT92bI2hzVhe4b1E1NcN1nnL/JL4rH37GZl0babYq1PGIf1qNIt+
         Agz/q/8kPQEcO43WYuwrfD/pthUB26cugiaGH9nkHronuBUKR6/5fyRjRVH1p46vqiZX
         S9GcEAAACsJo9R4Bcnx0+7SzgAMqCHC9y1xfT5CU/K9wN5KdNC1L6FivWZr+5FiilMjk
         n8LubVKfswKIqsQT7UvJNXj96mcqtA8yC/XE32411YzW8UfYjJPO7uk6lE6h7hjMTKju
         v54aN5W34tczpaDsXmBeS0+MUM7slUvHXis3DvzVdNdk7OuszjteuuJ45SVGvxhoSlsS
         ntHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TWqRdvosDHQQOHY7nZ555ofpwHF33DkHkDvoFiPbgUI=;
        b=pp5MtU6E1MNgOil/WJeb6qWtBuGiC0lsGi8y2Csv5bf7jxoiBfYufP4jbeEk/23ghx
         S0r0tWwGbI87X5VgGfsqlcPfwWdsgK0v0ywMoHMSkLrawIhk4Lo60JW8oSWAH3SFJ7Sk
         tV9ZEj19DkGA7dL26Rf4OziCGnyVHHudJJ+b9RgD8knrDZAYhuiL31qNCl283ZaapjUT
         OnRUqEcnHZHN8sW0Nj8nrmUOttnZkQIzOQFN3MCe02LedSwstxpPidU7UC8Wajc7jFib
         SOhQLzwmUzc8NmYZYky3Wo3/dtzDLVFWUXZ2jKWWGxaa55Dn6rErAqaX/1SuaW7r5waM
         6hQA==
X-Gm-Message-State: AOAM532lPYPglr7I3m0S+QJEkujBivme8fgfxiCwBtUVoVRF4tEA1rY6
	CXvG00rikxTQ7HBiM4DrcPibszxpfT3eU1fFNl8=
X-Google-Smtp-Source: ABdhPJwTbL7P5BUf/9/PT46U4JMoBBsLoEPz7sUMY4hEMjNX0QBxh97D0CpknTXpX8Bs3zTehn+s28iVeuTeOS6WWAE=
X-Received: by 2002:a63:f751:: with SMTP id f17mr16116929pgk.373.1624869354520;
 Mon, 28 Jun 2021 01:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com> <1624698998-9029-5-git-send-email-wujianguo106@163.com>
In-Reply-To: <1624698998-9029-5-git-send-email-wujianguo106@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 28 Jun 2021 16:35:43 +0800
Message-ID: <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v8 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Thank you for this new patch set!

There are three checkpatch.pl warnings in this patch set, please fix them.
And a minor comment below.

---------------------------------------------------------------
0001-mptcp-fix-warning-in-__skb_flow_dissect-when-do-syn-.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#7:
I did stress test with wrk(https://github.com/wg/wrk) and
webfsd(https://github.com/ourway/webfsd)

total: 0 errors, 1 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

0001-mptcp-fix-warning-in-__skb_flow_dissect-when-do-syn-.patch has
style problems, please review.
---------------------------------------------------------------
0002-mptcp-remove-redundant-req-destruct-in-subflow_check.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#14:
tcp_v4_reqsk_destructor() twice, and may double free inet_rsk(req)->ireq_op=
t.

total: 0 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

0002-mptcp-remove-redundant-req-destruct-in-subflow_check.patch has
style problems, please review.
---------------------------------------------------------------
0005-selftests-mptcp-fix-case-multiple-subflows-limited-b.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#7:
After patch "mptcp: fix syncookie process if mptcp can not_accept new subfl=
ow",

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

0005-selftests-mptcp-fix-case-multiple-subflows-limited-b.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


<wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8826=E6=97=A5=E5=91=A8=
=E5=85=AD =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> If check_fully_established() causes a subflow reset, it should not
> continue to process the packet in tcp_data_queue().
> Add a return value to mptcp_incoming_options(), and return false if a
> subflow has been reset, else return true. Then drop the packet in
> tcp_data_queue()/tcp_rcv_state_process() if mptcp_incoming_options()
> return false.
>
> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  include/net/mptcp.h  |  5 +++--
>  net/ipv4/tcp_input.c | 19 +++++++++++++++----
>  net/mptcp/options.c  | 19 +++++++++++++------
>  3 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index cb580b0..8b5af68 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -105,7 +105,7 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>                                unsigned int *size, unsigned int remaining=
,
>                                struct mptcp_out_options *opts);
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> +bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>                          struct mptcp_out_options *opts);
> @@ -227,9 +227,10 @@ static inline bool mptcp_established_options(struct =
sock *sk,
>         return false;
>  }
>
> -static inline void mptcp_incoming_options(struct sock *sk,
> +static inline bool mptcp_incoming_options(struct sock *sk,
>                                           struct sk_buff *skb)
>  {
> +       return true;
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
> index b5850af..4452455 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1035,7 +1035,8 @@ static bool add_addr_hmac_valid(struct mptcp_sock *=
msk,
>         return hmac =3D=3D mp_opt->ahmac;
>  }
>
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> +/* Return false if a subflow has been reset, else return true */
> +bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  {
>         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> @@ -1053,12 +1054,16 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
>                         __mptcp_check_push(subflow->conn, sk);
>                 __mptcp_data_acked(subflow->conn);
>                 mptcp_data_unlock(subflow->conn);
> -               return;
> +               return true;
>         }
>
>         mptcp_get_options(sk, skb, &mp_opt);
> +
> +       /* The subflow can be in close state only if check_fully_establis=
hed()
> +        * just sent a reset. If so, tell the caller to ignore the curren=
t packet.
> +        */
>         if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> -               return;
> +               return sk->sk_state !=3D TCP_CLOSE;
>
>         if (mp_opt.fastclose &&
>             msk->local_key =3D=3D mp_opt.rcvr_key) {
> @@ -1100,7 +1105,7 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>         }
>
>         if (!mp_opt.dss)
> -               return;
> +               return true;
>
>         /* we can't wait for recvmsg() to update the ack_seq, otherwise
>          * monodirectional flows will stuck
> @@ -1119,12 +1124,12 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
>                     schedule_work(&msk->work))
>                         sock_hold(subflow->conn);
>
> -               return;
> +               return true;
>         }
>
>         mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>         if (!mpext)
> -               return;
> +               return true;
>
>         memset(mpext, 0, sizeof(*mpext));
>
> @@ -1153,6 +1158,8 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>                 if (mpext->csum_reqd)
>                         mpext->csum =3D mp_opt.csum;
>         }
> +

How about adding a label 'out:' here, and all above 'return true' can use
'goto out' instead. This is more like the kernel code style. WDYT?

-Geliang

> +       return true;
>  }
>
>  static void mptcp_set_rwin(const struct tcp_sock *tp)
> --
> 1.8.3.1
>
>
>
