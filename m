Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C51DFCC
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9BdqKoz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so522a12.1
        for <mptcp@lists.linux.dev>; Thu, 02 Nov 2023 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698945563; x=1699550363; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+2TP0FOAoKmUn3WfaKaiXhu4WWIWVZ5gwov43r9xf4=;
        b=T9BdqKozZKU+uYV8r286h0+bEV7yQ/ZGKhZqnhT8zslI7UedgkryOKTMpIWv22XsRf
         z04mQhEIFB9/Yn3ukvc6ONNapyzS0CbG3GsnrDp754xj5S4OD1BDCm8QfKcKrUWtBTie
         T5Q3r24IbJKPmzHtDnrZIOmvcku8uCiTuzBnbzdYl0B3zXcTol8lzpjtkyQq8ACHakD7
         Xfj1BgTyWX+cFaW3Ph90yugEP2wdMuEmysOx7ZiHTAdiMtXDEFyOoTwvwb1kmM2WtaWc
         jMu0WiHqoodGvlcVmPCVWn4y7pPT5U0/zSvORFmlQIjzWHd+9EL8C/aCtH5eM/4UAII/
         Z2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945563; x=1699550363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+2TP0FOAoKmUn3WfaKaiXhu4WWIWVZ5gwov43r9xf4=;
        b=HSPcb0JDKaAAAvmgxExPJqVE8YYNNyTEvPj//s7l7/FsjcIlqiZmQsSU7qEm31UR+V
         8SeS7yP+69UfyFXDjPuzzuN3FDhZiR6/IT3nddQNec7P1GHTX3o1kXy3Q8/vgVvhjRqt
         yP19u/staXPPLYIG9HXLPWP9Ow1dbxlf1gtyYc/nBpxPCy1Q3NRwdRpSDiyBVqT3wNgy
         0KGQNS5ObcEiw3MIR7YABJYO2Cj83gCNW3COWORltCuomLWpw7kiJqP7QcOHNuavb4XU
         /OZrERPTZqZMOG9eZkW2UlTGn8u5lSIyMxrpC8zXSawsZXmzhL3Gfl7O27dlQeDv/GCu
         GTjQ==
X-Gm-Message-State: AOJu0YxS+O8zZE0j1D4VwIhvR5Pz4OwY4bAOZrAzoz1RMXmzdS8/g/HU
	YWJnGfIMqTM+LZlLZ6IGxfxDU+01xoBTEKqJmBuqPA==
X-Google-Smtp-Source: AGHT+IEl0B2JCgmhu5tHja5ZriE678sy3KdjaYV4bixvTouZPN/RkOvRcUSTmkfTdoy+2v/LEkWPE9gWCaQvAfiHb4I=
X-Received: by 2002:a50:d543:0:b0:543:5119:2853 with SMTP id
 f3-20020a50d543000000b0054351192853mr93522edj.6.1698945563136; Thu, 02 Nov
 2023 10:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org> <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Nov 2023 18:19:09 +0100
Message-ID: <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:45=E2=80=AFPM Mat Martineau <martineau@kernel.or=
g> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP protocol account for the data enqueued on all the subflows
> to the main socket send buffer, while the send buffer auto-tuning
> algorithm set the main socket send buffer size as the max size among
> the subflows.
>
> That causes bad performances when at least one subflow is sndbuf
> limited, e.g. due to very high latency, as the MPTCP scheduler can't
> even fill such buffer.
>
> Change the send-buffer auto-tuning algorithm to compute the main socket
> send buffer size as the sum of all the subflows buffer size.
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org

...

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index df208666fd19..2b43577f952e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_=
sock *msk, const struct soc
>
>  void __mptcp_set_connected(struct sock *sk)
>  {
> +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);

->first can be NULL here, according to syzbot.

>         if (sk->sk_state =3D=3D TCP_SYN_SENT) {
>                 inet_sk_state_store(sk, TCP_ESTABLISHED);
>                 sk->sk_state_change(sk);
