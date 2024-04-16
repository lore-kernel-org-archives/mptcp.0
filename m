Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37236CDB3
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249279; cv=none; b=QJvGdeoIxvhBhFdGaRgQm3/+cXvy3SWriKtxl1DbHzu1Y71Fi9LrbZCHKKQnmwOZgJzoPfEcnZd6djkk4GcovJI4flnMk0eXzHfAOkfB5xxGH6p2q8yd1//43rpAN3p7MqWsr69ZXsFRfqTPJAcE4cNw97w1R3v4isPP/+341BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249279; c=relaxed/simple;
	bh=1CcPLBBcUR9tqBl3DPRkilr/VMFRBBcZOijzvvRL/js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF5xOwZzsC0EHwxYef1gqLMX0W1hCxzs+Hl5houuoyVmw78vh0DESGc5IiffBA94zrXPUndpeGYZUFxBkjdyFQqMXeAReoDTEXYqZ8+1LNDjOzs4GDhnt1RVEPfSc+rDm3p9b+JLZyDH7H10AeL6WpA7Pc7zBo5/vVWXcVAYer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRaYUc3q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRaYUc3q"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso6480a12.1
        for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713249276; x=1713854076; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHk8qU35iBiOEsFbnIIa7RwejUtR6Xa78ABlgVMpLNg=;
        b=YRaYUc3qXK54VoPgyfLHJTlrz9iAQffmnEKKbws6Yss8BoQ0yfdkjd8flwayk2Bbkd
         33daxdoKlhptATijQy4M7XOsU/FQDchOJOPP21TJBtgIZcDkMPOrH6rP0WuUjl/JM+i7
         /Jy0JGVnuIgWimuFAcAq6JJeVj1KatgDCkYdaJgUy6XVGdKzr6UokVbSDPAk1bMF6TTQ
         Uu/2t4WKpzZ1H4VT7wzTrAzyKmEDMaK56kdjihxNjaD0s2Cz1ge56+FuUry29H9NYmxN
         35TdX0BffWLvOjHn3Mspld83mm7tsxCZYoCrI0XlhqNhDIClUT8vjwRi08/8ITCb7sr4
         k+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713249276; x=1713854076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHk8qU35iBiOEsFbnIIa7RwejUtR6Xa78ABlgVMpLNg=;
        b=DNuaAWZ2ZIhiaODbG67xcW+IsJV7XVlXQYYdyMmoyJtMSE7FmvduqRKe8j3Zlbc11I
         ++G3pAdUZ2E7KfSZdgn8Q8658DHPQUFpyDc9Gakci+V319A/h0QYfSlatdZpjVSN5an8
         8H0hQLh5F0uNJ3ODMgiHKnx3HCPPIEYFwzWVu41wqbGtU/D9t+M3QB0JU26tSfKuzc2e
         us2ORyDHyXvSjW5Y9SfNgIQAyJYeZfkNNJGpVGizBhlAiFNiADzYnZNS/7BXIFxOW2Xm
         ep6kmbzNFKVjaRj9/f52NdrqwKNGojez/0ple35RNMz9IKrwy0V3hsAj4Tf92B6Ey+lK
         cGSw==
X-Forwarded-Encrypted: i=1; AJvYcCVDd9oak3p2aj2m3CvEH8oggVXsL/f+4QhgMRzOma6BBbVd3A4bC57eFedWql55t05Zfw0gIsq9vE8c1H8DJPPdhdZjPDo=
X-Gm-Message-State: AOJu0Yx+ElRxxda7K3I7uE4eByK2R9MOuegbBNbD55h18u8CK7Ptf3Pl
	qb+AjSqik5j+yf8gswqW8BtzYR7ZeWi9N5Nx2wH9EM9PkKuIqQmNqDMc6HfmV8FA1KlYSk1WYqM
	ztcrs8c+vR+JDmr07Pyx7dBsYAVm/gP+M0PZt
X-Google-Smtp-Source: AGHT+IEEG66CmNPtCXqq3KskuZCKKecxfqW+vjjfNdvg2+tHOCOetxO5EEcJQkv96ccgaWePPi49wP3ed/5gdJU4DE4=
X-Received: by 2002:a05:6402:610:b0:570:443d:3cb with SMTP id
 n16-20020a056402061000b00570443d03cbmr59462edv.4.1713249275983; Mon, 15 Apr
 2024 23:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com> <20240411115630.38420-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240411115630.38420-5-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 08:34:25 +0200
Message-ID: <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Reuse the dropreason logic to show the exact reason of tcp reset,
> so we don't need to implement those duplicated reset reasons.
> This patch replaces all the prior NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_ipv4.c | 8 ++++----
>  net/ipv6/tcp_ipv6.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 441134aebc51..863397c2a47b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>         return 0;
>
>  reset:
> -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_v4_send_reset(rsk, skb, (u32)reason);
>  discard:
>         kfree_skb_reason(skb, reason);
>         /* Be careful here. If this function gets more complicated and
> @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>                 } else {
>                         drop_reason =3D tcp_child_process(sk, nsk, skb);
>                         if (drop_reason) {
> -                               tcp_v4_send_reset(nsk, skb, SK_RST_REASON=
_NOT_SPECIFIED);
> +                               tcp_v4_send_reset(nsk, skb, (u32)drop_rea=
son);

Are all these casts really needed ?

enum sk_rst_reason is not the same as u32 anyway ?



>                                 goto discard_and_relse;
>                         }
>                         sock_put(sk);
> @@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  bad_packet:
>                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
>         } else {
> -               tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> +               tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
>         }
>
>  discard_it:
> @@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>                 tcp_v4_timewait_ack(sk, skb);
>                 break;
>         case TCP_TW_RST:
> -               tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +               tcp_v4_send_reset(sk, skb, (u32)drop_reason);
>                 inet_twsk_deschedule_put(inet_twsk(sk));
>                 goto discard_it;
>         case TCP_TW_SUCCESS:;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 6cad32430a12..ba9d9ceb7e89 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>         return 0;
>
>  reset:
> -       tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_v6_send_reset(sk, skb, (u32)reason);
>  discard:
>         if (opt_skb)
>                 __kfree_skb(opt_skb);
> @@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_bu=
ff *skb)
>                 } else {
>                         drop_reason =3D tcp_child_process(sk, nsk, skb);
>                         if (drop_reason) {
> -                               tcp_v6_send_reset(nsk, skb, SK_RST_REASON=
_NOT_SPECIFIED);
> +                               tcp_v6_send_reset(nsk, skb, (u32)drop_rea=
son);
>                                 goto discard_and_relse;
>                         }
>                         sock_put(sk);
> @@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_bu=
ff *skb)
>  bad_packet:
>                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
>         } else {
> -               tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> +               tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
>         }
>
>  discard_it:
> @@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_bu=
ff *skb)
>                 tcp_v6_timewait_ack(sk, skb);
>                 break;
>         case TCP_TW_RST:
> -               tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +               tcp_v6_send_reset(sk, skb, (u32)drop_reason);
>                 inet_twsk_deschedule_put(inet_twsk(sk));
>                 goto discard_it;
>         case TCP_TW_SUCCESS:
> --
> 2.37.3
>
