Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FF3803EB
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485738; cv=pass; b=tD0v1S45qUdWV6CaR2GsK6/V3mFQvFa4vziQexM+3asfcgn4+DBL6SS8XnpTca/BsxlhlQCCSj5inTs7NRAzSA7TpjJgOs55sTbmJTr7bnx6RLILdhUgIjIb0VGI7AWtGKKHgYC4wsViKtvflBapPu/xAEFXRgKW+6OnqfXeLO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485738; c=relaxed/simple;
	bh=RN4e1YhDSg992awiDit4aQ/vN6UYLHpPa8oGR6pnBZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2KuvoaDp2QdfqbMn/c6ajdEh/wHGdZj3fbOrNFqpjwVl0l81owMsveBW/yb6dmxYWQaaKmHx6ZqiNwBR+HmHQTV8rEZxtzKIASQkX6hiUfvLG3OREbObmpTp48fdCLO5cLH4zGNOUnKCklruO7DktxpU3HC4HGXnIUYXNBONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UADwB2cC; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UADwB2cC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-685013eb590so739951eaf.1
        for <mptcp@lists.linux.dev>; Mon, 06 Apr 2026 07:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485736; cv=none;
        d=google.com; s=arc-20240605;
        b=H/skXNkV2IP2RRdANi99qPaY122QYwD4yIu0KA1UTnNIxiSYITwuadFjtC3chIl39m
         AbzBlBq857vftHFG+Gw3s9OXQpFyMEgh4CRKgERTUWuSRzrk3fuIzHGUDx2/SKHSNhq5
         2i2wtqF85ZGcKFllximKj/P+NkTHPmNEqEWEIraQjt6qFo+W1xpDbLDhsZd4l6+vf90R
         M0/BDHVhbcz6Mb9nrITZuIkYr3G+9a4pMXWaahPaNEElyaRSzij4PJugkjFaX7MQRH4f
         PgGELQu4mq8UMfzGYMmtDUASO7cZpiQICU3Gp/rnDUB3AF6DT+CFgiZGJqoU9bgj+3jR
         lDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        fh=kCVK64HDVHySSSuUyrtIcMB6Y1Dqg3cWizeG7UvJbjE=;
        b=gZthPrdvmb+twG5iD7J3gyd31cJ73g/JHwOd5QVoFKTs6Hia0I5iVQTWUnMWo/TEOC
         kyMm0fNPN8eeJKQiXpKb+K/SqXCVsOHzm0pwUfywamWdT4+4bbNP8dITSWnNfMMXx+QK
         FznzSL9GrPeVfIX9qYFMliwsvMF1PWEH+JxBRuRcaqNdhJhhrEf4pUoNwnORxd6N6Xhi
         oJ2HWbw61Ns29wk0UzxlF3Emw61NTZvkHYlIBSLWzB0j8kJCV3PwN8A4fLAjNA4goAWF
         YYcfuxCrFiiWPmWMvBnoCzOzt+UD9BQk6w58XxQ9gfBdPPd5wOsuHCh4r8Qv+9Ps3Rdi
         nfCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775485736; x=1776090536; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=UADwB2cCnOceVcxkDiIwoSW2PYH87KN+sSmQ41fnC82gk6M8psNmGMNpVs9wZri2dL
         eFndlCD8DoruWjrmnd5wvQwQHsWPMk9HaQu+/0JtoJQT3GRRqAowYRSP7jO7RE52KEd6
         fR5n8wtGvcgrCE/O5TONquBEPTCCezrRhWuET8xF5w8D+mx87xm6QyCC9YkZmPyJ2x3V
         sUIzTsnYqrWxQQU///tjxFqub/6BmuSa6fDtnXURXgGLje9XXHISyr7ZPylzoKC7DTYf
         tFOLSV9Xup9Dxwf2k1Ta/8GTwY28kfN95GRikyWpWDhszFd9H3o3DonlCL/nZkc0Sm47
         9Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485736; x=1776090536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=rHK1Mf9mGFmFAGzVxuU2pE0rQMHNmosYDeg/C/0YHqK5ajUTuj/cN/R5d/w9dwvrow
         LGEcJ5vNuOks6atzTnQgAf7SW72pFRi50AjpA42saXE6l+aUCacEP+5eD8b6uxkwoQFa
         2qDE6rjYeevoOuYK8h4rPSLYcWxykUctMZCEXpvBjpejZi5o6HgsYOxaT7OSvwheuywI
         XCsYJYQAe/OkNmp4mUrviheqJTTolKn9UJBoj7qZJXycbcQ/Oo2Xt7sMAgfzGQpC3e+W
         WODYrlsOQtxMI7gI7eafjJPdOkU78021ZZWK7Srxm7G6Wvx7C+/qSIRzYKqhnZcjQN6r
         jr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM6U8zJ9hC89SZ6nW+KcPOjw+Ye33QqIhO8KUaSp9TT4MPo5IXsrR+koDoKA6NBPmx/xqlNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4A0MMwlxirhLFOtr69WJVAN3++tzURmq4aWIKFwQacWRk4ijc
	YwQ76/IW+AUZCDvzPXYDTZ4wV3onZ6UcT8a4etBNkDwBSEYmfIExqkwdHTNB+7p/co5+TwDiRR/
	2PohTNpnKmo4huLDM3Im4PFn9dNqqtEk=
X-Gm-Gg: AeBDietvvFf5tuCxsfG9koySytcesalvjLqKUJcsZ/JzHFALZ6Ypn1aviDJM3NzTaPk
	0dCHR7emVx2CbPiqViWkJXkzBA5rIO1gQ9jrDQD/0nh+8XcDr1ueJlcbPeGXAfpXa1zqQTrtO7/
	U4yZT3nb3f+AhCzYKZKj2fylEx2YYtVnXinIMjGy4v1lJBw94grbnyuZonjkHYnB6kGOvwyip2N
	7TRGY3AkcNEHSoEURWCnAQMFjBnztONvRC2H8kZB6glfKYl+rqeQXMKw109dNXxam7YrW1VWXgW
	gbODZnEEpw07n+NHyW9Er296vHh3hDnwCs0/Lg==
X-Received: by 2002:a05:6820:8318:b0:683:6dbf:c6d4 with SMTP id
 006d021491bc7-6836dbfcb7bmr3030718eaf.22.1775485736189; Mon, 06 Apr 2026
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com> <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
In-Reply-To: <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 6 Apr 2026 15:28:42 +0100
X-Gm-Features: AQROBzCw7pv9Q_nhcb2cp7aOThL8Ubn1v1x8P2vXHbgAOxV1wipCcpu51-53q2E
Message-ID: <CA+XhMqxNzaXZRd0co=_gaJsN4zS9L_4OVqhC174EPxA-pzEUgA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev, dev@openvswitch.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu yes this is indeed a valid point, will address is for next
time. Cheers

On Mon, 6 Apr 2026 at 15:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 05/04/2026 17:48, David Carlier wrote:
> > Use the typed random integer helpers instead of
> > get_random_bytes() when filling a single integer variable.
> > The helpers return the value directly, require no pointer
> > or size argument, and better express intent.
>
> Regarding the modifications in net/mptcp, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org> # net/mptcp
>
> > Skipped sites writing into __be16 fields (netdevsim) where
> > a direct assignment would trigger sparse endianness warnings.
>
> Note that the AI reviews are mentioning that auth->client_challenge from
> net/ceph/auth_x.c is declared as __le64, and it might then also cause
> sparse warnings:
>
>   https://sashiko.dev/#/patchset/20260405154816.4774-1-devnexen%40gmail.com
>
>
> It looks like they are right:
>
>   $ make C=1 net/ceph/auth_x.o
>   net/ceph/auth_x.c:574:40: warning: incorrect type in assignment (different base types)
>   net/ceph/auth_x.c:574:40:    expected restricted __le64 [usertype] client_challenge
>   net/ceph/auth_x.c:574:40:    got unsigned long long
>
>
> Note that the Netdev CI currently doesn't check sparse warnings:
>
>   https://github.com/linux-netdev/nipa/issues/76
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
