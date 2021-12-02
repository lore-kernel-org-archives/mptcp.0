Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BD2C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 04:47:35 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id nn15-20020a17090b38cf00b001ac7dd5d40cso3616345pjb.3
        for <mptcp@lists.linux.dev>; Wed, 01 Dec 2021 20:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oqs+GJMXLT4aj9TrZW7iTX2Bz95JBJirqDST4zU1vac=;
        b=nwp29ScGkYt9L59zpjtqMhCYBMhPr4f5S3AYZE1MDNn8nr8Cc484ABf83Yncy0eZL5
         1K5eglYVSH8puveMXeUJgdUVhXW/Q63a+T7MwphCchngl3gdf2mieinaRIE7Zm+10Ne+
         FXytUKQ6jBo66CK42TY9HbaLFT9yrXgmRYR1CLYp3lceXi3o8NqvQfurU7DJgyeYgITb
         vlODLY9LfyyQN8QBi8WAPIAhd1sa/A0xMci4RweyWt7ggZ9Eh6A+zaBrNpGdI1r81+at
         6dqFz8JzUKpl/xOi6fa8UJ8g3lvni7rz3s0oWbFQFCz26MgQKvn6/3UqRw1+GFj4L/8W
         w5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oqs+GJMXLT4aj9TrZW7iTX2Bz95JBJirqDST4zU1vac=;
        b=PFYvzrdTVEZSYYT9zRKRV7MDnMzs1iqMWPBt26ZEt02wPj81C2Sg5CUqk9WI3FdHhV
         W6FbCt8kxFsBRA5S+KrIrYzBx+BvrVGzg+tPguWoqUPrqSWfZvyUdv3faND/O3vAhXUI
         FRFe+1MwV3TzpksI5agvaRynSG4xHGKVdP8bP3zJcgFfRu18p9ZuSCH3qpmnH8F04xl+
         RzA0kptzfMOjEPz5/ibRhyDqsCJCCjW5E4xpWk+NGveHQ93tsQvOjxjJjr0Vi8v1fTk7
         qOmwIeC5IB66E6LeDx5f9m6ik/MrKHgXdbVLsD58UIrKPIlRizAsw6S1vy6XgYlitDHx
         CdPQ==
X-Gm-Message-State: AOAM531OKlUz0tySTUoqNfSU/huEWiO6ASPb0wdUlS5JSPSqXAB/J5++
	MVBc8IHzIse7aCwEGt5wqM+KTU50SHoreWsjA8g=
X-Google-Smtp-Source: ABdhPJyjSxqbQHGL9FlW3Li53AR6VZonpe5Aqd1/QoG/Y9qbDSzRkRJmJK7RXFeUHYxMkgldm0XbjTBkWtYx7HvMtu8=
X-Received: by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP id
 a22-20020a1709027d9600b0014287dc7dd3mr12746731plm.11.1638420455158; Wed, 01
 Dec 2021 20:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1638418477.git.geliang.tang@suse.com> <4ff5bdca4887d54bb60f3cf491357f5b832c314c.1638418477.git.geliang.tang@suse.com>
In-Reply-To: <4ff5bdca4887d54bb60f3cf491357f5b832c314c.1638418477.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 2 Dec 2021 12:47:25 +0800
Message-ID: <CA+WQbwshZzBp-k-5abVnFBQTbOQc1jxH6rZAEP7S3kQ8iQSQ9w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 1/2] Squash to "mptcp: implement fastclose
 xmit path"
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, this patch still needs to be improved.

I just notice that MP_FAIL will be sent with DSS too.

In the multiple subflow case, MP_FAIL will be sent with MP_RST,
But in the single subflow case, MP_FAIL will be sent with DSS.

I'll sent a new version of this squash-to patch later.

Thanks,
-Geliang

Geliang Tang <geliang.tang@suse.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=882=E6=
=97=A5=E5=91=A8=E5=9B=9B 12:26=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> This is linked to Geliang's patch with the same title.
>
> If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
> and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
> MP_FAIL together.
>
> This patch implements this logic in both mptcp_established_options() and
> mptcp_write_options(). Before this patch, the first function was not
> allowing any of these 3 options to be used at the same time while the
> second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
> MP_RST.
>
> Small note: I tried to keep Paolo's idea of reducing conditions for
> "normal" options by moving MP_RST at the end and allow to jump there
> from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
> and really improves perfs. We can also move MP_RST check at the
> beginning.
>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Tested-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/options.c | 60 ++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1020e4285c..078187456467 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, stru=
ct sk_buff *skb,
>
>         if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
>                 if (mptcp_established_options_fastclose(sk, &opt_size, re=
maining, opts) ||
> -                   mptcp_established_options_mp_fail(sk, &opt_size, rema=
ining, opts) ||
> -                   mptcp_established_options_rst(sk, skb, &opt_size, rem=
aining, opts)) {
> +                   mptcp_established_options_mp_fail(sk, &opt_size, rema=
ining, opts)) {
> +                       *size +=3D opt_size;
> +                       remaining -=3D opt_size;
> +               }
> +               /* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if th=
ere is room */
> +               if (mptcp_established_options_rst(sk, skb, &opt_size, rem=
aining, opts)) {
>                         *size +=3D opt_size;
>                         remaining -=3D opt_size;
>                 }
> @@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext =
*mpext)
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>                          struct mptcp_out_options *opts)
>  {
> -       if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> -               const struct sock *ssk =3D (const struct sock *)tp;
> -               struct mptcp_subflow_context *subflow;
> -
> -               subflow =3D mptcp_subflow_ctx(ssk);
> -               subflow->send_mp_fail =3D 0;
> -
> -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
> -                                     TCPOLEN_MPTCP_FAIL,
> -                                     0, 0);
> -               put_unaligned_be64(opts->fail_seq, ptr);
> -               ptr +=3D 2;
> -       }
> -
> -       /* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclus=
ive,
> +       /* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclu=
sive,
>          * see mptcp_established_options*()
>          */
>         if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1458,19 +1448,39 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                                 ptr +=3D 1;
>                         }
>                 }
> -       } else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> -               /* RST is mutually exclusive with everything else */
> -               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> -                                     TCPOLEN_MPTCP_RST,
> -                                     opts->reset_transient,
> -                                     opts->reset_reason);
> -               return;
>         } else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> -               /* FASTCLOSE is mutually exclusive with everything else *=
/
> +               /* FASTCLOSE is mutually exclusive with others except RST=
 */
>                 *ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
>                                       TCPOLEN_MPTCP_FASTCLOSE,
>                                       0, 0);
>                 put_unaligned_be64(opts->rcvr_key, ptr);
> +
> +               if (OPTION_MPTCP_RST & opts->suboptions)
> +                       goto mp_rst;
> +               return;
> +       } else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> +               /* MP_FAIL is mutually exclusive with others except RST *=
/
> +               const struct sock *ssk =3D (const struct sock *)tp;
> +               struct mptcp_subflow_context *subflow;
> +
> +               subflow =3D mptcp_subflow_ctx(ssk);
> +               subflow->send_mp_fail =3D 0;
> +
> +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
> +                                     TCPOLEN_MPTCP_FAIL,
> +                                     0, 0);
> +               put_unaligned_be64(opts->fail_seq, ptr);
> +               ptr +=3D 2;
> +
> +               if (OPTION_MPTCP_RST & opts->suboptions)
> +                       goto mp_rst;
> +               return;
> +       } else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> +mp_rst:
> +               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> +                                     TCPOLEN_MPTCP_RST,
> +                                     opts->reset_transient,
> +                                     opts->reset_reason);
>                 return;
>         }
>
> --
> 2.31.1
>
>
