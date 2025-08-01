Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434516F8E9
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085254; cv=none; b=ABdIxC6gVMb4jkGZ+ZjnbKTZ8ZrDc71Qy1mIAJptO06GyXBdQOSYms0JzCemCwUToz8a9fAfOlhrBMmLVpxwPTiDN4B69g0bqD+D1ZOMFkiV46jj6ZoZ0zZOwwCUEli2s2THuhAPp1VxwmQ+Cai657Sbgt6Fo1eRxFO7WV/q6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085254; c=relaxed/simple;
	bh=IBwU5NZ9rgklDZUs5GKyHXWVyUaVMGjdp5g98WftyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wto4Qlq2fJrZfDUgn/C9SnGkBiPEZBscBk3eFl5mW66A3sVEGkdUMxe5Knl6yXMcqwiNWVr0R4xvlFg3Q48GzRAn8WXJl61EAB5EcQNcAZNZkiSJUnH4keDEMZuT5H8p/NwLNfsxnV7RvEd2kF1NgxDQ3+8cB+PgDEtHpSBnq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=W+AHpfzE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="W+AHpfzE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33229f67729so18728421fa.1
        for <mptcp@lists.linux.dev>; Fri, 01 Aug 2025 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754085250; x=1754690050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJGDdasUGkhtr2EKSB3vuUtXhinSww/6fzk/bJspE1A=;
        b=W+AHpfzEUseI1Y3Yq9bdOQ5+mrOgBnypxE+/bepHtEWIkkeZcMhhrVTEXPXPI/g5Az
         zszjvRT20rQaw/PADYhIQNiq7Xc7BtYPEY8kff+mAdLmyfvPPi4KJhhIl75Wf5xJ5zYr
         ZtgkHYeT60TZXWTbKeJzFQOrb9hHSIB5AooqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754085250; x=1754690050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJGDdasUGkhtr2EKSB3vuUtXhinSww/6fzk/bJspE1A=;
        b=NnQ6jxZwHd13nil5bcEv7JtNqNKCQ6ZpHcNju37lFAgDg2tO0NlkGmKuxl7AB59cNH
         B22+78Y6eojIa1sQr/gaGlXpqMS4+fZ+YrVtvW30od8r8ZxnYdRH+7EqzNh81zSpHUpv
         USWSxtbobW+kdlWL4klzawJBFYdYZ6OdPQ1vQTrvSIRU6+WeaFCBeZroqa9GeHa2VBge
         hqUpvHs5/mPO9kbN+9KibUvPE35DNyhIFl2kGiu9yP5+cS/IKt+dpNC14ECqkKyMD0Sq
         41hExtHDdSkqpeqX5WXJyEvuOa2x9nk8y839xIIsfnxy/EHVqS30rHIshWrnpQsigs+2
         fEMg==
X-Gm-Message-State: AOJu0YxdlHzTtLq16kVIND22LDvTaZYS1+/2H1vYxzSpUqKQCkg10q3D
	2KU/1EWRmBYPTtvR78aKobOd8HRfiEHK879xfsaP8nbVihBbBn7BwQyLAe88OU3YGl26HdejMzs
	+A2SOhVJn/lmtrmwpkwNZeAJ6deGi4nf4ZXDqIZfB2w==
X-Gm-Gg: ASbGnctmEQkZ+p3CMEP70mSOKDwLYgaUu62f2bbZaN2J6dj1iXZH20e9czF8G4ZofdA
	GVvJR497outd4qK5MATjR55hLUwesUQXrkY0yaFIuU5ImQyP/6AaSgvFi+wFX+ZpH0EbvmrEvdD
	FfGmWsHPoWTWe8MwlxZaIdlkiMyn/e0PiNMIcLWNVmmiK/bNvcwpemnJ7pjW3QTRF/LM9dQtorH
	Exm+w==
X-Google-Smtp-Source: AGHT+IHtY9+pnf1hw0KReDyIyIvOABHDpP7olzvdcHA+kA+RhTdRrjt06q8A3/t4+1x0CJ65FF23za+tZ65PZZTta8g=
X-Received: by 2002:a2e:bc17:0:b0:332:2e05:6ba3 with SMTP id
 38308e7fff4ca-3325683964bmr2097911fa.34.1754085249732; Fri, 01 Aug 2025
 14:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
In-Reply-To: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
From: Christoph Paasch <cpaasch@openai.com>
Date: Fri, 1 Aug 2025 14:53:58 -0700
X-Gm-Features: Ac12FXyD2VtdhsAdDA574MWXYJMgneGyg5xPSw-0L2SwsnCmyNST6KhBcDzCVs8
Message-ID: <CADg4-L-Fh7HpUYCsz8HoSAxdMFHz1pTKZT6tP9HjEKz-ipB-Aw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum
 subflow RTO
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 11:07=E2=80=AFPM Geliang Tang <geliang@kernel.org> =
wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
> patch makes the retransmission timeout adaptive by using the maximum RTO
> among all the subflows, while still capping it at the configured maximum
> value (add_addr_timeout_max). This improves responsiveness when
> establishing new subflows.
>
> Specifically:
> 1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
> timeout.
> 2. Uses maximum subflow RTO (icsk_rto) when available.
> 3. Applies exponential backoff based on retransmission count.
> 4. Maintains fallback to configured max timeout when no RTO data exists.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - do not rename add_addr_timeout
>  - use icsk->icsk_rto instead of tp->srtt_us
>  - increase the time after each retransmission
> v1:
>  - https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.=
tanggeliang@kylinos.cn/
> ---
>  net/mptcp/pm.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)

LGTM!

Reviewed-by: Christoph Paasch <cpaasch@openai.com>

>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 687dbb59d084..22198609be2f 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -268,6 +268,28 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk=
,
>         return -EINVAL;
>  }
>
> +static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk=
,
> +                                                 const struct net *net,
> +                                                 u8 retrans_times)
> +{
> +       unsigned int timeout =3D mptcp_get_add_addr_timeout(net);
> +       struct mptcp_subflow_context *subflow;
> +       unsigned int icsk_rto =3D 0;
> +
> +       mptcp_for_each_subflow(msk, subflow) {
> +               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +               struct inet_connection_sock *icsk =3D inet_csk(ssk);
> +
> +               if (icsk->icsk_rto > icsk_rto)
> +                       icsk_rto =3D icsk->icsk_rto;
> +       }
> +
> +       if (icsk_rto && icsk_rto < timeout)
> +               timeout =3D icsk_rto;
> +
> +       return timeout << retrans_times;
> +}
> +
>  static void mptcp_pm_add_timer(struct timer_list *timer)
>  {
>         struct mptcp_pm_add_entry *entry =3D timer_container_of(entry, ti=
mer,
> @@ -302,7 +324,9 @@ static void mptcp_pm_add_timer(struct timer_list *tim=
er)
>
>         if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>                 sk_reset_timer(sk, timer,
> -                              jiffies + mptcp_get_add_addr_timeout(sock_=
net(sk)));
> +                              jiffies + mptcp_adjust_add_addr_timeout(ms=
k,
> +                                                                      so=
ck_net(sk),
> +                                                                      en=
try->retrans_times));
>
>         spin_unlock_bh(&msk->pm.lock);
>
> @@ -354,7 +378,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>                         return false;
>
>                 sk_reset_timer(sk, &add_entry->add_timer,
> -                              jiffies + mptcp_get_add_addr_timeout(net))=
;
> +                              jiffies + mptcp_adjust_add_addr_timeout(ms=
k,
> +                                                                      ne=
t,
> +                                                                      ad=
d_entry->retrans_times));
>                 return true;
>         }
>
> @@ -370,7 +396,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>
>         timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>         sk_reset_timer(sk, &add_entry->add_timer,
> -                      jiffies + mptcp_get_add_addr_timeout(net));
> +                      jiffies + mptcp_adjust_add_addr_timeout(msk,
> +                                                              net,
> +                                                              add_entry-=
>retrans_times));
>
>         return true;
>  }
> --
> 2.48.1
>
>
