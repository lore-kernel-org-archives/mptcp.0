Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345664122D
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763199; cv=none; b=ngrYQDQ2CVwte2e8XnBWLeRznBufDYpfW3zVP9bGS3Uer+fizYcYi2XaPhd46o9nYVXosfTLyfAp3XYJVM2u9OzBpQXfLKSkVUVbD7v0JfHoyw4/Dpv28JSJaXl/0+r4/MUZ+U6FCxZYkdEvzeGUFTmi1n8ZnsAKjboDZraWfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763199; c=relaxed/simple;
	bh=7KtAdzkHlAnlWvBMfwT8WuB4d0+O69tA+YUmbppsXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRnsr3N1xqDz8lyZb/7oXdKMwAd9OT3SZaNQl5l1iaONFoMEQE9jWS9vemt0voww+1SsTD1L5SvFGdjUug3oYI20xRs5Z2CVHULagQ1qYPZA9Amx1qS8KXcimGYKH7Rp/ibO5NHlL6uotD2mrWZz7hR2zIQexqlmEpr8svid/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W2MHcjza; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2MHcjza"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d94323d547so30649965ad.3
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763196; x=1708367996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=W2MHcjzazMqP8K1psH3PZN+OFyNSMqOyKb6P4qURcHAm2Gj2vMpScMd5H55Tr2+D6H
         ulMm9MKvR1zD85iCyUHyksREeOWVuG6l0Eb3kqSQPZW9eVCcbbzJvEQfJQOxWUnceVA/
         Bp4m4BnAthgfUZfPnDx+WTuKBxL9LTThtyBLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763196; x=1708367996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=XVlIhH6sCrM0wge1Qe5QMUQALgqKA5VRUt6JWyFWJaNFmkmv30MtGyRNRmrF32c3FX
         ePVaRT2RmkFbN0nhsm+eZXOYniNNz4ArTffN5RIw/MOY2oUFQoV778zjIHiB7Borb1f4
         pvDjZKQvwWuJETzfRns1l40ggEw/GRJFXSUvW6FXvVePH9IQt0YK4S5vsqgrd1e/74Oj
         zvGILYcifx2eF7pRrJMk3rQGtjhO4PaPPGU8WErg9Kp4xstVRgjRgwxeuXGlpcbDwaul
         BJZ/CgSNHxp+7Tkh62rSeYUoy0sjZXB37v53yu73i0pKcBf1hUkEG6Un00GsIPBJwo7+
         CTMA==
X-Gm-Message-State: AOJu0YyxL2ouU1irBHLVbsIgMFagBO9xleLvzUCQl3E6RSilulJT8Eqq
	grvue1xZE8aNB33vMLoFEGpOkuW3Bc3AeCn6xnycpjVXv0D4ymG0hQp7bZWkNQ==
X-Google-Smtp-Source: AGHT+IFNcP+SAxS7irWemqCnEtzUPbDRNv7kDAYXRdvsinYmZVPoZxaqJoA4GLxcd3SxCHhrzLfHKA==
X-Received: by 2002:a17:903:643:b0:1d9:f5dd:2480 with SMTP id kh3-20020a170903064300b001d9f5dd2480mr6438396plb.54.1707763196526;
        Mon, 12 Feb 2024 10:39:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkSQrFxcWP1o0ZHsxTq6YWmTvkekg3UtzXbispm3ZC82vaz4gnDazH6bGYamsNT0Ix+wPRjHrJzl/hnlZnJTjvX2ya1cGzvLypKkd5rsfVF8Luo3EZGRKp3Sa1DRT66UK0NL7/w1w1ZkEFX06lirixckwb5i5dUm9xWEvGP3ukeMVkNNxLjpB7IYca0F/BJ6SgGeCABxuSjpSgPKeijZrq/CxNmOpX10wEqvU9WDEypPV5ePHIVPlm7DWOI3yCm90l4uWFb0L2gaLgrHbv59EnaeSyGULKK2SQRKTZ9idGsg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001d95eec000esm664121plb.27.2024.02.12.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:39:55 -0800 (PST)
Date: Mon, 12 Feb 2024 10:39:55 -0800
From: Kees Cook <keescook@chromium.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qian Cai <quic_qiancai@quicinc.com>, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] configs/debug: add NET debug config
Message-ID: <202402121039.E14DF37@keescook>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>

On Mon, Feb 12, 2024 at 11:47:14AM +0100, Matthieu Baerts (NGI0) wrote:
> The debug.config file is really great to easily enable a bunch of
> general debugging features on a CI-like setup. But it would be great to
> also include core networking debugging config.
> 
> A few CI's validating features from the Net tree also enable a few other
> debugging options on top of debug.config. A small selection is quite
> generic for the whole net tree. They validate some assumptions in
> different parts of the core net tree. As suggested by Jakub Kicinski in
> [1], having them added to this debug.config file would help other CIs
> using network features to find bugs in this area.
> 
> Note that the two REFCNT configs also select REF_TRACKER, which doesn't
> seem to be an issue.
> 
> Link: https://lore.kernel.org/netdev/20240202093148.33bd2b14@kernel.org/T/ [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - It looks like this debug.config doesn't have a specific maintainer.
>     If this patch is not rejected, I don't know if this modification can
>     go through the net tree, or if it should be handled by Andrew.
>     Probably the latter? I didn't add [net-next] in the subject for this
>     reason.

Adding these seem reasonable. I touched debug.config last, so I can take
it via the kernel hardening tree if netdev doesn't want to take it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/configs/debug.config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 4722b998a324..509ee703de15 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -40,6 +40,12 @@ CONFIG_UBSAN_ENUM=y
>  CONFIG_UBSAN_SHIFT=y
>  CONFIG_UBSAN_UNREACHABLE=y
>  #
> +# Networking Debugging
> +#
> +CONFIG_NET_DEV_REFCNT_TRACKER=y
> +CONFIG_NET_NS_REFCNT_TRACKER=y
> +CONFIG_DEBUG_NET=y
> +#
>  # Memory Debugging
>  #
>  # CONFIG_DEBUG_PAGEALLOC is not set
> 
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240212-kconfig-debug-enable-net-c2dc61002252
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

-- 
Kees Cook
