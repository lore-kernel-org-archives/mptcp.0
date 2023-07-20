Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3019BCD
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 19:07:52 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-401d1d967beso70631cf.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=lHLZY3Ewd8Ty/3BcHCByP7EV4tgjVjwB9NSqtCgVqzs95PgXPyLDBRvrA7C2uJBnGP
         lnOwzsq3sqNxj9jEUP2/aVqPJFk4I9QWp/z+Uq+fI+Q/Xyh2zcO8BYvF+8gNYwhis8GX
         BcjfAYa+Wcnti46YaH3C+G45A79yR7/YR7di4XdREX7pbNR7g8dpW59GmEYKhigkvZqz
         wL+MHGGVgKLRUShoM6vlJaxdJqkMF673n+jvCweu6jJrujfqJzsmD+J9ZPlDlzbJr/zU
         g4nMAhm5+VYavMaJC1CbD3XFAMMGqv8i6cTVzbOBmhRKKID7TIERIAvYG/wyX6RgT2yn
         PQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=VEkK92tESH7tFpRh02WDmOQRsFKtE5bM3y4JIbfqaKVX8hhm5Q6EnpGeZb5i53DMXE
         o5FC63LDnQz/VtMIs6KRxNiHeNvdei71LXklonyDqcQAqMUU6+YF3WLgSkcRby3uYUJc
         ggrl3ZyqNl207+/WgIrFY7z2SD747JvBb6fRTavTtfZjlqcMci3DDFoFjHUy7ezUX8Qk
         AG4rzJmqWkr9UQ1jC+5lUYBI4HhzKf1uXR9Oln4V1sgAKQGZK2FV5SdIgyouDSYQPAJN
         UfNrlW9Tp5saUi+ZwBu4hZoPa7oXdYktTh3Ka8QbLjVympZMRlc330uCRcwW8ozDv8ha
         T4vA==
X-Gm-Message-State: ABy/qLZ5pRvvQBy7DKy1VXqWjx1CJ04ZqR2W0W0yle7RFvORkj6RwUEE
	MTs2BZog1gJb3IJOtZ01iqo18aylcF87NUZQPGpfnQ==
X-Google-Smtp-Source: APBJJlEur6cHnlzJHXbLUn2GBZ0Ah3NwAqthv5DSX4rSx/tBDaSx89c7j31E72vgVfMeFIXZvzcYQK3D0t4u03+tbqk=
X-Received: by 2002:a05:622a:1a87:b0:3f9:56c:1129 with SMTP id
 s7-20020a05622a1a8700b003f9056c1129mr31665qtc.5.1689880071131; Thu, 20 Jul
 2023 12:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
In-Reply-To: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 21:07:39 +0200
Message-ID: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <martineau@kernel.org>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
>
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> broke such assumption, and as a consequence most MPTCP connections stall
> on zero-window event due to auto-tuning changing the rcv buffer size
> quite randomly.
>
> Address the issue syncing again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> MPTCP level scaling_ratio is selected as the minimum one from the all
> the subflows, as a worst-case estimate.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/net/tcp.h    | 20 +++++++++++++++-----
>  net/mptcp/protocol.c | 15 +++++++--------
>  net/mptcp/protocol.h |  8 +++++++-
>  net/mptcp/subflow.c  |  2 +-
>  4 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c5fb90079920..794642fbd724 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space,
>                                __u32 *window_clamp, int wscale_ok,
>                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
>
> -static inline int tcp_win_from_space(const struct sock *sk, int space)
> +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
>  {
> -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> +       s64 scaled_space =3D (s64)space * scaling_ratio;
>
>         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
>  }
>
> -/* inverse of tcp_win_from_space() */
> -static inline int tcp_space_from_win(const struct sock *sk, int win)
> +static inline int tcp_win_from_space(const struct sock *sk, int space)

Maybe in a follow up patch we could change the prototype of this helper
to avoid future mis use :)

static inline int tcp_win_from_space(const struct tcp_sock *tp, int space)
{
}

Reviewed-by: Eric Dumazet <edumazet@google.com>


> +{
> +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> +}
> +
> +/* inverse of __tcp_win_from_space() */
> +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
>  {
>         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
>
> -       do_div(val, tcp_sk(sk)->scaling_ratio);
> +       do_div(val, scaling_ratio);
>         return val;
>  }
>
> +static inline int tcp_space_from_win(const struct sock *sk, int win

Same remark here.

Thanks for the fix !
