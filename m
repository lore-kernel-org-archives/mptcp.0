Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC676CDAC
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249218; cv=none; b=u6xfVht+ALXjfx7cUtOxvkr4NgjJteXSSe61gS23nbDWZ1kKDMD8Lm6zNZWLgwGJP53kMSf4/nJLblMFO9kfmmWztrUiK8EjJyOoj32vaIYbBux+Sw0frvgTyM7fE+D+WW6dQf1nntxEexPHIuTNrJ9m0fLON9FgfH2qXSK8kWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249218; c=relaxed/simple;
	bh=WTHD2jkBkYrza/7xYMvE4w1MhuQ+PYI0kMjvR0fKQOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4ao9EYZezZYiXJYS5VXVdGhUTNZX+3b5n3N7yBgxcu/CT71115iAVEGLREviY4A7MlAnnanFaENbXFoFHkkbbgmYM/bPV0r6xMCzS04NAmchb2HLWGCy7IlGiwIWeG1wv4pvOkWfRZE3y0jEWidlryMmOm6XVEklCrK0s421bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jz5jptms; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jz5jptms"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so5952a12.1
        for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713249215; x=1713854015; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhHm+pw/eRdnVPPPueSNaVg7FoAccIkjt6byD6hNEeI=;
        b=Jz5jptmsRLjCA2VGVqfvonThWv1wFLLWP86aupDUWqyS4UfuUmZ4GloolwyqsxdRDO
         kH2Rm/LvpunRVcM24FerMhlZjJT8Djt05P+vc34GAxFBnuRGvRn5PBbA5muqk4nOkUmr
         UYoURr6NNOvHUCeJz5Jmz6i6FeEWbZ+pFcSbjBwlpafpLDfLoNTXjKvhVn3eLrLNqdpT
         VSG0MoIMl3mhEGFjdMfX15PjpWs3lL9t5Dj9Cs/Hh12A0bVX+cb9xpYHzce3CBM+1gE1
         QsyCaQuqqc277juT3pRNg7ClVwGAJq55tTgwsc3nuCFKRJ6NU7YMlGRzG8Q/9T8GcH6L
         /KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713249215; x=1713854015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhHm+pw/eRdnVPPPueSNaVg7FoAccIkjt6byD6hNEeI=;
        b=umIjiYKjRQWJuOa2UjzlfunvOZONgBtkUPTCZziHbCIxrHEuyvu6giDmQYrkEFQ9zo
         QqELrEwdA59ozfKIJYKsJ/5gJpfaXDZ/uvYZ2EyuVGngCSGn4y2FahWnEcJR1seEC3YD
         u94eqVCOhlWHy+HB/qtKvjNOS0tMB3hLX3vfBTtmKiYtr4/j6+yl2Zj315cd6EnE+OFX
         8jyvgNmpjHaHjpor92XItV7SS+pSwm2fzL4HquLdFW5HE4+9eehPfXGLXrYzw88RCIVB
         CMhH9L34zJgg8lotu30UsdpeiyQfpqY+YfVaynybzjMoITYiHbwpnjyZToYBJiB2ewy0
         7JWA==
X-Forwarded-Encrypted: i=1; AJvYcCXiKSCMIU7Sx1rgqIFpBWl9o7vCXz90nNScokGOdEQhpvwYf9H2ZI3oJFsGhuM3ebMPPhLab9bNUA/2CgV3HZM5n1Ixb2A=
X-Gm-Message-State: AOJu0YxV3Q6AuMa0TN1jLWyVvkOvvk+LMBsy/hDhk0Tj6WGnv0KnvFCJ
	jQn0Gajn3oIZWDh/etabcnqrQkEz178nNCmBJ4ao0Tj+3PZlDzL++4BUK+fgWYC9oadSF8HFccs
	nTCObSDgLlinqOfIwANCnVmCGO4Y5U+iU6cJa
X-Google-Smtp-Source: AGHT+IFOt/KxCo19mR4iJkdl9hLPS2U2D4EmWT2c3QSG6XWl+TkYdWlRgqhHsRnMUjV/CcwRSqwsTD1xVC/nQR+vNlI=
X-Received: by 2002:a05:6402:8c3:b0:56f:d663:cfd9 with SMTP id
 d3-20020a05640208c300b0056fd663cfd9mr77869edz.1.1713249214893; Mon, 15 Apr
 2024 23:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com> <20240411115630.38420-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240411115630.38420-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 08:33:24 +0200
Message-ID: <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
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
> It relys on what reset options in the skb are as rfc8684 says. Reusing
> this logic can save us much energy. This patch replaces most of the prior
> NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/mptcp/subflow.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ba0a252c113f..25eaad94cb79 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
> +
> +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>
> @@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_N=
OT_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
> +
> +               tcp6_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>  #endif
> @@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         bool fallback, fallback_is_fatal;
>         struct mptcp_sock *owner;
>         struct sock *child;
> +       enum sk_rst_reason reason;

reverse xmas tree ?

>
>         pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, lis=
tener->conn);
>
> @@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>         tcp_rsk(req)->drop_req =3D true;
>         inet_csk_prepare_for_destroy_sock(child);
>         tcp_done(child);
> -       req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +       reason =3D convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason)=
;
> +       req->rsk_ops->send_reset(sk, skb, reason);
>
>         /* The last child reference will be released by the caller */
>         return child;
> --
> 2.37.3
>
