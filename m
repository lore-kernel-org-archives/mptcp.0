Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC63FC3
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 02:56:33 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id r2so1270961pgl.10
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P909qM3GriJXOMBE2UzD0eEKIV6Rucgk31rWOM3ko20=;
        b=UJIdyRpj2VdZ31P6PGyQrLjENQu2wGCdFgwqHQyiL85KfvWsDfoMv/kdX36NGHxoQb
         R86AqShbIlV8nUNDfIv7OBPpl8MIo+N7WXd/UEzK11AIq/p63KEYwuiyyU4WwfCwpn0e
         ijpW3EXqIchb+bjVjQ7Xoj492BaDBMaqXCAIB9rnpAxy6YMoy5nBwO0MAp2sgH4nYrwm
         Tb71jXbMj+x1MTPKI13BoX9CVuJS8kZlonHciOePA881OAM2GQxoqQI4a81D5Yo6wZeu
         +SK60o6g7vA0JOeB/iHa5TAqMarNwcA68aMBrrwdQ6cmdielBbrN0PWHGwNZMNtpSmyG
         ClBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P909qM3GriJXOMBE2UzD0eEKIV6Rucgk31rWOM3ko20=;
        b=npECNLo3CuD3GDymL8ebA0OHesO5VaOBq4rPrzv3hPlStbUV8t56FOBFJXi1Fi39WJ
         tGsmXJxhag3MlMdJFZ83B2oXtF2A65BQsoR5OoMpAScNrjLSvRIfSOt0ZOGDXs2Y9q4x
         Y8QzONDWXr3XVZa1J5xs2VXbJZblKS9SML8UAWJD179fJRFtWCfr77n55v5Z30DcQAvg
         T1t/0yjwTvNHhuaxQR9QjjITHfuK8QHZR5zgeK6YAijSxn1KABe73YF+5WMfmASk1peR
         3t2n6uV3XAdFFKQTVzW/nDm9hcqIAR0ydDHJYX4Kvpdfyxfcc0KaHzaVzgJz8gVhujaq
         LVyw==
X-Gm-Message-State: AOAM532YbQyW0lhwF3VxSM+clhPalh4zY5iLll4hOs7CY71l93UWMmCH
	s1vBzrMC8lB1Gki69Y2DRJLrfjz6ROutZzeQE64=
X-Google-Smtp-Source: ABdhPJyOPkYEgZTwYHXIkHbGdvtfffCDWg3vf3xDaA6Vrl3zhHvkyXYgbGNg6EC4zkTlxo+ISoQkK6Kx7aDV64y+MNc=
X-Received: by 2002:a63:b59:: with SMTP id a25mr29469814pgl.373.1630464993271;
 Tue, 31 Aug 2021 19:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210901023205.5049-1-wanjiabing@vivo.com>
In-Reply-To: <20210901023205.5049-1-wanjiabing@vivo.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 1 Sep 2021 10:56:22 +0800
Message-ID: <CA+WQbwvjzadxGi2yCs+PRdJpwYnj64jkXdgiYset8oX0PZX6xw@mail.gmail.com>
Subject: Re: [PATCH] mptcp: Fix duplicated argument in protocol.h
To: Wan Jiabing <wanjiabing@vivo.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	MPTCP Upstream <mptcp@lists.linux.dev>, 
	"To: Phillip Lougher <phillip@squashfs.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, linux-fsdevel@vger.kernel.org," <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiabing,

Wan Jiabing <wanjiabing@vivo.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:40=E5=86=99=E9=81=93=EF=BC=9A
>
> ./net/mptcp/protocol.h:36:50-73: duplicated argument to & or |
>
> The OPTION_MPTCP_MPJ_SYNACK here is duplicate.
> Here should be OPTION_MPTCP_MPJ_ACK.
>

Good catch!

Acked-by: Geliang Tang <geliangtang@gmail.com>

Please add a Fixes-tag here in v2 like this:

Fixes: 74c7dfbee3e18 ("mptcp: consolidate in_opt sub-options fields in
a bitmask")

Thanks,
-Geliang

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  net/mptcp/protocol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d7aba1c4dc48..64c9a30e0871 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -34,7 +34,7 @@
>  #define OPTIONS_MPTCP_MPC      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_=
SYNACK | \
>                                  OPTION_MPTCP_MPC_ACK)
>  #define OPTIONS_MPTCP_MPJ      (OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_=
SYNACK | \
> -                                OPTION_MPTCP_MPJ_SYNACK)
> +                                OPTION_MPTCP_MPJ_ACK)
>
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE    0
> --
> 2.25.1
>
>
