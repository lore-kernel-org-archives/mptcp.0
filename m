Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6E19CC34
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238555; cv=none; b=Gw/IJB0d+qW1yoiqEEG853F79csK9Aza8wvEa+aVyIzMYehT2naFkLOZVnIZN2GJhZolm1eikGTCXX88F3+46LGfLrqe77tgeKQ8YHkRNcKsUnx1LxDMTXi7OXViEY4dZ/RNeHuKRlThc1G3o8fuSV4XSoMe7AV0h7+M/r/UoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238555; c=relaxed/simple;
	bh=0z5yhqvQqhdwGnoq2F+YoE5Fl3fUyiC68CgC2ANTf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG6Li1dFEAsNn8wKKwypCXyIstD3dCPky4k/L5hyOtE767JUDF79ZIoGfNbxIDb7oTGBohmA7ISdOCAuHG/5CIn/SSzvwJ06MWpjEsUQjIjijDZbjiUYBhI2AV14GWD3Lye/3FLlMxxxSYyK4ZHmONegiNuHuof2cDQSoI9qo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ4uvd3n; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ4uvd3n"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so5320095ab.0
        for <mptcp@lists.linux.dev>; Wed, 05 Mar 2025 21:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741238553; x=1741843353; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVTkF/tobSDNmB1ZjwvbLTru0Ubgqet17u+KkorpADw=;
        b=JZ4uvd3nVS34aRdqdN/aJgMkive8MjfH6soLoAdQbh8pzgjq55plURPczIJVBs0leZ
         Q9IPs7TuDxLQvMex1VSm4LvRAQQNyO+aAqUReOGJPqBxwhOwfreQM9ana+bdcSJ8gf9i
         7CDMQeX5PsS71PTBONhG071I6yV0V76vfL/Ad7fHwgFMACZGCAp+tCg5ESS/a7HJf/3S
         ByRsP1ZR0jcQ1ZWocfTt7dneBv4PwDqBuv3WWaXWFO51QWpZrntj8FJ6odz7eMNpe6vD
         frz9QzH9OuLBaZla+soOR7IAeQ2LBr2bW7+RH7MIlCvueRbyjuMWraSPn8TXBE7Zjrle
         fkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741238553; x=1741843353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVTkF/tobSDNmB1ZjwvbLTru0Ubgqet17u+KkorpADw=;
        b=LOlVA6NfoEt89qmQbM1f0/PLw9oyXX85NtNvorNtHcGq79E0mBLYCtMvmaVlHalT3X
         TNQBHc41n3LhmvhKX9Yf8ue4X5ClpU5sO5SFiBNIk3DBVFZjpAEC7rCbBaKkTBuOGf6X
         WdJSFEGeFMCHCBdie6LbBlrFxz4rT+9ehhZxMX4t030DHJhK7dKipqXInc6G23GhM5qm
         qtpyPXwr29hd7JNuYIBw5yiroHXwlvkShhQJxCWR25SVR/4QRwnrkifCZAlMQUVn6lUJ
         o09oxjUbeRIZrjFxDNMsU+dAf4uTP+H1QP6s3apanq54DBBkcPSsuQ5B/bgKpX9x8iqV
         uLhw==
X-Gm-Message-State: AOJu0Yy0juYLYW/Y5BK7xjQmuNAN6kctLlNJTsG7PV6eRnwdC0G2DiOq
	hXRZtVl9IDjmmLSMMUEq9etSTZS1oeG9XwMtad06YBTHlc3ThTpH6BuMBWQMpuhD8N5wClkDcjq
	awEM4BVvOlCWry2OHwV0p/ble+Rs=
X-Gm-Gg: ASbGncvqhz8S8Oh4hX4R4FRyBUpgEDtt8VxmiT6gg2W+iJjC8jPY1iD8GrIyXq87C+s
	3YgvA+7yZvc/6Lj9DZBdriM57SFBuNLRSQasbXH31IlBKWIKZ4H8U5nAuoCOaqM8OI2GYngcYFl
	VVw1Ukw4MNreFMb1QCODw2xOLC
X-Google-Smtp-Source: AGHT+IHCu3R0Gkmwvr/d9D10F4Fnp1D31Fns4gsp95Cvm16wLRe/2+tUmYP2EhB/RwGE6zwifzgmFMixL2an/0JA4H0=
X-Received: by 2002:a05:6e02:221b:b0:3d4:27d4:f76 with SMTP id
 e9e14a558f8ab-3d436adf50bmr25879205ab.7.1741238553323; Wed, 05 Mar 2025
 21:22:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
In-Reply-To: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 13:21:56 +0800
X-Gm-Features: AQ5f1JohJfb3wH0oihOcAk_5UlajfKw7zjaDJ6N5o0gNhKuh5XmYb8DNNJeXchw
Message-ID: <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> A recent cleanup changed the behaviour of tcp_set_window_clamp(). This
> looks unintentional, and affects MPTCP selftests, e.g. some tests
> re-establishing a connection after a disconnect are now unstable.
>
> Before the cleanup, this operation was done:
>
>   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
>   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
>
> The cleanup used the 'clamp' macro which takes 3 arguments -- value,
> lowest, and highest -- and returns a value between the lowest and the
> highest allowable values. This then assumes ...
>
>   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
>
> ... which doesn't seem to be always the case here according to the MPTCP
> selftests, even when running them without MPTCP, but only TCP.
>
> For example, when we have ...
>
>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
>
> ... before the cleanup, the rcv_ssthresh was not changed, while after
> the cleanup, it is lowered down to rcv_wnd (highest).
>
> During a simple test with TCP, here are the values I observed:
>
>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
>       117760   (out)         65495         <  65536
>       128512   (out)         109595        >  80256  =3D> lo > hi
>       1184975  (out)         328987        <  329088
>
>       113664   (out)         65483         <  65536
>       117760   (out)         110968        <  110976
>       129024   (out)         116527        >  109696 =3D> lo > hi
>
> Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> higher than rcv_wnd (hi), so having a different behaviour when the
> clamp() macro is used, even without MPTCP.
>
> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd)
> here, which seems to be generally the case in my tests with small
> connections.
>
> I then suggests reverting this part, not to change the behaviour.
>
> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Tested-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for catching this. I should have done more tests :(

Now I use netperf with TCP_CRR to test loopback and easily see the
case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
tp->rcv_wnd is not the upper bound as you said.

Thanks,
Jason

> ---
> Notes: the 'Fixes' commit is only in net-next
> ---
>  net/ipv4/tcp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index eb5a60c7a9ccdd23fb78a74d614c18c4f7e281c9..46951e74930844af952dfbc57=
a107b504d4e296b 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3693,7 +3693,7 @@ EXPORT_SYMBOL(tcp_sock_set_keepcnt);
>
>  int tcp_set_window_clamp(struct sock *sk, int val)
>  {
> -       u32 old_window_clamp, new_window_clamp;
> +       u32 old_window_clamp, new_window_clamp, new_rcv_ssthresh;
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
>         if (!val) {
> @@ -3714,12 +3714,12 @@ int tcp_set_window_clamp(struct sock *sk, int val=
)
>         /* Need to apply the reserved mem provisioning only
>          * when shrinking the window clamp.
>          */
> -       if (new_window_clamp < old_window_clamp)
> +       if (new_window_clamp < old_window_clamp) {
>                 __tcp_adjust_rcv_ssthresh(sk, new_window_clamp);
> -       else
> -               tp->rcv_ssthresh =3D clamp(new_window_clamp,
> -                                        tp->rcv_ssthresh,
> -                                        tp->rcv_wnd);
> +       } else {
> +               new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> +               tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthre=
sh);
> +       }
>         return 0;
>  }
>
>
> ---
> base-commit: c62e6f056ea308d6382450c1cb32e41727375885
> change-id: 20250305-net-next-fix-tcp-win-clamp-9f4c417ff44d
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
