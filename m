Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F811CF5EE
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805532; cv=none; b=fh0b0rkvcHlOt79Z5LyA1DJ0d3ZN55BRfUbLZ+Cawz+kQJxA0rvcyyUAeZ2O7OGFuQFsNm8vwT5IS9nEwveEqZylh3CMbAHFifHWdwJ/zmcxo6Wmta/6O8A9J9RruIBXlXyQdrhWHEfEbcXMLWQ6xG43BUBzqZ0vL2KsF/YGG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805532; c=relaxed/simple;
	bh=YT7tw+yLpBD8mm51eiJecrgQMxOp6GEumiwHGuJ2WQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crS8Rwc1bYAp23G9SocO22wL3YrVa0Q6C30THR2kaHDxuit2KoHQbtzWkyB/C6UhE6UTXp/a8hizmuqwYwCaLOvgIa+xLJny6uLma7eSv9z3NxZxX50JhnGJ8ts3Vs6jM/WYP7nxtCMHBvBcSeakhv593OUGwMxDJZCyxlTkTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LqRy5HOX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LqRy5HOX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso87819255ad.0
        for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736805530; x=1737410330; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1twCwD/6lZcYLaRpkR8mPmSDuI0NT9StKcevPHbSPFc=;
        b=LqRy5HOXRjmzv0T2EfVpZQuv0chJZWkNY5scArHVe2SC78Kmmt8su6a+iO01An0nyB
         quUbI/xvnneUGnVFWXvjS1Dxo5Z2puWc+64d9sJgse52lnxLt/1pkjVp5y47ccSuvRm3
         WfZr2HpPFuK3Mz5hxvuB3lhDQ0xMrZ1ZR/0kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805530; x=1737410330;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1twCwD/6lZcYLaRpkR8mPmSDuI0NT9StKcevPHbSPFc=;
        b=ghJOAr7mj7TGES+VMNNZ2FCLRb2C1onYUQZuvoLtqEZpQqOVdfZ0fuOGxJLIpoJZ2w
         fiPXNfGrVJypRhQGRyAFVFMqeyyf2LwFBihgTUwQjQ+aenZDpgQiDCiai10J2KdHiGKe
         TXz4J8GaoGRpODJ4KrRFX3XNKbr6tnuK/f79pwLGKueLXXuZdMz9Sul+Jzx1n94OQk0a
         WMf50ZYndZs8R46bO/DL2kSyDelNHYbooFZsUSIII8dnotsKviol+3tUn07PkM14mMhc
         /D46hPMBagg7DgMOs4gcqlRmajr/2cVQM24A3b8/0EYrOuODyiNxfSzsqA9OEurrRfcb
         0tdA==
X-Forwarded-Encrypted: i=1; AJvYcCX6kqrP6msIIYLow1ik6Jmja77HyUSLJSR+QzSmoyeu7gZmGPcbuA4NbcJyZQ1KaLvTHFqW/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh1RLelDHkdJd3WGmXhJvYJUc0OEl10n0X+onbDAdivMyqFFDw
	X4m9aoPLKRh1tOAIB21Xe7Qwq+OCs2/l+T83gkZW9h7UtWYdpLOwPdwqJvEMlss=
X-Gm-Gg: ASbGncu2i5U1e2tjGRnfrSNDOISc69gzbOsMlnZppKSESH0XP4ZsC7X7v4447wy39CU
	DwU0WMd3COJyK29eTyuL14RseZh8rXOSTnyEdr132t/i2Ck0ZKJyHF4kAzFqoriA0v7y4mhcXbK
	TlmCGXNvqEJvou9THsPVDsCYBZ2vf9qeHSRmSjhPeIA1DhROFELNJ8Sqnb0+Uk8dhBGQT+2njOe
	iN6PGM1VhdzjZ4AY9HZtrgetku4JHRvPyqkir6F+VGjlBQzJeq+RfU+izsrobEyDGgVWR2rUohT
	LwIZY4Bb7kSxsPf46Pxbdwk=
X-Google-Smtp-Source: AGHT+IEy4a+fqtFSueZzVtc2SRzJuoPJNIUP7MY1bj0DO6uOAeEg/SwVA9O4cbddmsDMAe+fWeCj2g==
X-Received: by 2002:a17:903:244a:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21a83fcf7a9mr342201385ad.45.1736805530337;
        Mon, 13 Jan 2025 13:58:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22ecf2sm58329325ad.192.2025.01.13.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:58:49 -0800 (PST)
Date: Mon, 13 Jan 2025 13:58:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
Message-ID: <Z4WMl6PvgRFRQEMm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, matttbe@kernel.org,
	martineau@kernel.org, geliang@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	mptcp@lists.linux.dev
References: <20250113003456.3904110-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>

On Sun, Jan 12, 2025 at 04:34:55PM -0800, Jakub Kicinski wrote:
> init_dummy_netdev() can initialize statically declared or embedded
> net_devices. Such netdevs did not come from alloc_netdev_mqs().
> After recent work by Breno, there are the only two cases where
> we have do that.
> 
> Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
> Dealing with static netdevs is not worth the maintenance burden.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: change of plan, delete init_dummy_netdev() completely
> v1: https://lore.kernel.org/20250111065955.3698801-1-kuba@kernel.org
> ---
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: geliang@kernel.org
> CC: steffen.klassert@secunet.com
> CC: herbert@gondor.apana.org.au
> CC: mptcp@lists.linux.dev
> ---
>  include/linux/netdevice.h |  1 -
>  net/core/dev.c            | 22 ----------------------
>  net/mptcp/protocol.c      |  8 +++++---
>  net/xfrm/xfrm_input.c     |  9 ++++++---
>  4 files changed, 11 insertions(+), 29 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>
