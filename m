Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2AC435502
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534755; cv=pass; b=POWoWhnluJ1t3oDMPK1z9NBjHAiMvlmFQLubnXLRaCNv9bZU1RX92/lrLwUaEellkty1xTfFrkuTz8aUpaIGLj5aspq2aKpx1iAHfDi1ZGYB2NADWMWSIpvXxVPKU1k0Oo2YGtaasTbg+9UA8T2P7s4izuF2O2Vvp5TU8wlJNA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534755; c=relaxed/simple;
	bh=DaN9nYB8FBMgKs+20JyrySVlwZ2Qv/MvcqfuuWBsD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aezsOs9+K/16xKYpgROj3F3tx5AqtNg7R9E6Gc8w1YsM4ZNH9JmITuwLX1OeT2aoYGPycYb04FTRKhhVD9XnKMQkwZzUiRFU+JgUvkzLFsKLhFF2rg3xI+oqATap3Jf28P/84whS98A/m0SEZYJOMACFJGIXypMiTBEYbSDdi6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcoCXoAw; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcoCXoAw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5218927884fso8689121cf.3
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 04:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786534753; cv=none;
        d=google.com; s=arc-20260327;
        b=TRu8SrTm2b9rivl8jPE3L/9/+uaGvwv7lYujD5KFRY3lIYffuaZfA3Ha9UF5Xi1Vwx
         ffe3t5aObNPk2nh7KU35Imn9kF357yBIMa65COaSPc51F7i7U4T8ZZQPe8sWFrwSSCcm
         7uV/FeWTFgLpRIQ28lNjMF97q37yCVaG+8zvfPPvEKy6rjrhyf70StnOJ9vGxrBzc4x+
         7eOGC6VokjDErFFEI+EYi2pTD1WTiTOPcrizZi1MU5YKdyD9Xg2rWgk2tbTD8sN6qpNU
         2TIXA9TH2MfRGkO1kvgEwe2BT+VPNxeqjyGCH/iDDXEDFuCjuXunIlZ8oTRjc+S9J/+9
         QPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        fh=BVvzbgECNPxYbEhODP9FSUu3SCzIk1v2IugetWJzlh8=;
        b=PYRvQLuB/3ENcPxE75Fovn5hh1sGd0nNYO19trq/jfAZDAvs4wh03R2/F8nXCC80vg
         4JztsBMwH+RfL7SXUpfNtkpljAU+5iSiZGfEOK6jvEz9DwwKQQUxNsaUtbe7g+s2DmeT
         inzVx8kSXQgUhoGuMcyauv3l0RiWoM/WcPu3RL2EHLR4rY2OMHfwaaPDQOmqAY/9OeLX
         sn4IfymRJZxTCL6VGn/sJUtNiZIdAI4F7qF1WNK4Nv2orxzK98wMJbne23V4HRLnQ0fh
         IUV/5Mokpwbe8jRLvUq0+j0YYNNFpyp4s7nD8LC36kn+eOdXSauOzrmVm+8bYSq49bKN
         oqBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786534753; x=1787139553; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        b=BcoCXoAwCtQQHeOMo15uiWU3ifdCGjFNTgZ8sfZtzddGwxjpcmeqplB+fgURciMPvy
         w946oOJHbRdkDlAhDUfhctZ39Qf6Exew98VyDRrKiJs8R37ufrGNTpJa6HwhHXyV4f5B
         TAhQ71/NIYjlNilZbAWGPPQtQSgeAUw7xW7Fxf/l9X0PZaAMvOQUErRBP/vPycOaciJl
         jYP/iQipP30BvfzPSN9BsC6jM/TSMCdTNlPCHtNDDrSmF9XD9iKMropYWzd30lH2YuCj
         0YIwYJCpSVQ+JxLX6YhhgvbYdUlu0JhbP9cWgUKMOoovOfYo0cYrEL7/njGgdiUL5oEP
         D09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534753; x=1787139553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnlrKC6yQpr/o0E77FIxd6sNz6VZtPb046x8kNGEgp8=;
        b=PuLGlIyZCosxgTegIEMy84b1cTJHoyfF5eGEzVfDhnOorQpxzDH/4L91wxAmViNuMB
         hCF8p5HRV9bvk9aZXgRhXbitcY1MrHIrylMBER1D1rrZcnQfajxlpJfFczu4GE+WvMfo
         DGKrLTRp3i/7w1q5whD/AQn299jBWmfUKE86+W7/JNb5qGEgvl3ak7L1rIBOm0z5JLRp
         TsenF5t8AvxfX9TX7ZSCjSzqkLVG9AEm9zxNS8rQXpFr7yFJ1p/1bfD2G01GnQISaob7
         +HKAWN8EeEk4YMR0T8BenXGxt7PBICGPFJoVC6TbAv3TXABoUjiXMrZ4AQ1lYL7z3Co6
         wBIA==
X-Forwarded-Encrypted: i=1; AHgh+RrQOoC2MWDM47GO4o/1Rq8LPBiVlkwwySTeCxaz7SXWXbfkEpCxwq086+ZPf7Puo1Vi8i2JPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsjDBOfLC9aWrgx9xgmBC0lJ90Lj2TYWuBzob97kmQ1ovpK48w
	ebMQhGzCoO6I9cs2zq0HQVCYwyq0sgQU43qOQIhP0mxl/eXHfnpUIBBx2a2DFgpdf3BClgeZeOw
	vKLFyOTLpBU3BXWv4Fj5RtljCp0LKlihRbYDaUWyX
X-Gm-Gg: AR+sD10JRc5uFwKOIxm9vZiRh1iiVO+Yqc3pu3Fra6Nwvovh1JTgQ8JF/wMMvL42c3E
	rRl81CxFwu9im8KI0na1SRafkC2UP1XQQvMpk3k/JBvM+EDEYObumdw7CYcVqjX/3zo7SFAeEBE
	DGLIgA+T/qTx8dYCkaY1Lyi9+A4GlaxRbGbjDr/CTeo8a/BBnum9XeKfjXT9ewIDE/Dvdx3fITf
	w/AqUg5i+JT1RrlaToq0HITbp47XFnpTYHAww8yOsrioQd5OMxNYr736P25qDBnVQ7XCqn0ch3Z
	QGKCBsUPCd6kuL5ZQPPv4M5FVNI8SPelBRlGeRS5pJ/yvC83t94ASzOF02Y/RGkyXkztIbA8Ttj
	s2YZyMBrYAOgRPvDh+KtD7Pv2TdKWWaZc94W+QzDdyfYzL1OjkYyvAK9ve/t7QsM4NmzyO/uLP5
	bLZfYPEigiWwJiqmGpYpJc8lY/wg==
X-Received: by 2002:ac8:59c4:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d646b8dabmr31842851cf.1.1786534752356; Wed, 12 Aug 2026
 04:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
 <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Aug 2026 13:39:01 +0200
X-Gm-Features: AUfX_mxA46OtJnZFHzG9nKl9iGiktqoxt39eRI-qnZy1K9dxmhi-xoA6rpd0mD4
Message-ID: <CANn89iL-rnJtxVxJEf3j0PX3X8A04vsf-XXQvb-_FyjMBBM5nw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] mptcp: implemented OoO queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:50=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> When moving incoming skbs in the msk receive queue and the latter
> is above limits, prune it as needed quite alike what TCP is doing
> at the subflow level. The main difference relies in the stop condition:
> since MPTCP does not perform collapsing, it's better off dropping the
> bare minimum to fit the (newer) incoming packet.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Gang Yan <yangang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  - Uniform the new counter with the other OFO ones.
> v3:
>  - prune only for new data
>  - reorganize the code to follow more closely TCP
> ---

...

> +
> +/* The stack can't drop packets for fallback socket at the msk level, or=
 the
> + * stream will break.
> + */
> +static bool mptcp_can_ingest(const struct sock *sk)
> +{
> +       return unlikely(sk_rmem_alloc_get(sk) <=3D READ_ONCE(sk->sk_rcvbu=
f)) ||
> +                       __mptcp_check_fallback(mptcp_sk(sk));
> +}
> +

This unlikely() seems inverted.
