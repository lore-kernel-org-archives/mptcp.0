Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B05B21A
	for <mptcp@lists.linux.dev>; Mon,  1 Dec 2025 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764562082; cv=none; b=ZFllAHTzLNN5deLmIlV9wYnbZMvvHirpxTYIxZz5+TjcI28I72i3JKO9V4Lp6UgSiuwypF5e1hMOZdDthTSiDmA/UN/2h1dqygOkhEzVjdUlrYziTP/PzSBXhpWZ1R4Y+HRwKA94cJ5iqUP9Y/3AmKtMZTdhgH1Ev90r5q1+Iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764562082; c=relaxed/simple;
	bh=I5WnbEMYMvxMMyC0dGDFfkJkD1UwMDR1rRygcGxyK70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E86Il+mFKzqAzgL20HdKvfAl8tjLPk4OkUGO49GyV1B12ip+BXXbWHMQIaI6tlXrazidy4hmZu0YOR8bi9GO9iOYO7MqIwyANAsGTCQxcWOzpwTgPnBbeRhnvBe9TErzOWY/XeQsPKxSVszupaFQS19H1vgMhRMyTigGUtx4kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK7/pCvy; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK7/pCvy"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34374febdefso4025868a91.0
        for <mptcp@lists.linux.dev>; Sun, 30 Nov 2025 20:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764562080; x=1765166880; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHYB6uxWCS1cMIYtl4torJ0Vkz15tXZo+qs17i5jW2c=;
        b=SK7/pCvyxx8/WjqLxd8z5YX+vJ8AZzN2xdM9Ljd9jroS0/zWpbEuKwYl2VX8LHUapq
         MMQDlC/zLiK3az620Z2/Av3brgABYvOTKwgXijNWPvfBM0BfZUOt+HU3wYFM/nXFJh4q
         TwVAqtmeTCWVwO4ESBDj02P+3ci6eIh7Nyj3kEi5O362Ek3OX/wEo2RgDtq48UHy4Xqr
         tvzS80jWvaqbDa4GEgTzgqHL+SCYl96zyGrDVBbe1cS0DPcNW3kcI8VQtH6oLk/g/rzM
         jsIEbhK5+5Ov/9T/WhmR6WKQwXb8nQpcX0ZrwLD7/jqvz/w+EsDJpEyi1VzOZgCzgDm3
         i14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764562080; x=1765166880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHYB6uxWCS1cMIYtl4torJ0Vkz15tXZo+qs17i5jW2c=;
        b=RR5DHYRSqPxyjWObwhF7eGJJrDiH4Is4O2oM67i+mSkllFB1IECatgR1p1C+yFSWG9
         cRtKx+4sb51y+VPtK4aXh1Jm58hfwlH7TRi+4kq9FKmwY1yk2WPaIO/CJ9HYfPVtQLzQ
         qIxywG/9zZ+f7TKP85pGO3VIYru/xN3IpR+2oaf/cE7AM8D9BZlT8j71q5JIDkI3qmDr
         1qHCXjUjXpxCTr5BX+Ndnlk1rOpyqUl57iQCIrGIzv3x/cODbC7SEFCHHN2y1B6cfc7k
         9obZa92aFIDi8Nmx6dFtb1GtXO7OnUibQfVxtFgRnNF67Yq/ZVM3UInW8wOrEMFNaXAL
         YylA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBJPNovQjUBijN0E6BBI+L8EtaU1REJGA/xAz2CsYRLNoGR8Y7l16CBqt4mgvJBDJ0Cybpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUEA0nFL31GamxJiGwS+Mu3ph8kaxHLFDebOLP04qsxxZyneft
	DKDRXagOI2hJPO2tWeyc/Min0rX22wh5E7I4b4PF1NdZ63m9CGIQzV9L
X-Gm-Gg: ASbGncsaaiiFF1MSR+sEiGHZieT+p8+TOMGL8WrHpuGYm/a6AAEp7fXMIdr1Vwe9BCS
	/Yy7oh2xkSVtS4cXiB8wCi0TD5KilJkEBRKJ2UxTivHicEsGHySOPG+KPrR8teOQk45iopjH3Ey
	8DpE2/2rF2ExrqzZCi1kvRW7P7CMbcJZpgZUif/wqr04HNUzuSQhGczf5BoVd5XDoTZOw4xuB+e
	eUt8EdfLIIeZZaWU5Ws67f1VxteVEd9N46QXGDWdUcPPtxdhmU8ov/T4BREqYzsEs0nUd3ffvAG
	6CwzS5j92OJWuG5tQ51uyhPv5v3xGdLPdGXiTsoWXPmmpv6QdtfVLafp02mHC3hhU7kY//wYr74
	rZ8OaQC+13xNbRWuwWHjocoUpvcdb3al81aRXL02mqIg3XVr0ET3tB1ccAHQQ8jnhP6NycJxm1b
	Tyi/q/e9g++wi6KFp86j7/mB935sxcwAWU65C+9vPO
X-Google-Smtp-Source: AGHT+IGPl5jq66QKAxKuT1zbMmX7cVCg83U7Ow4OS33Os0vlctAPTudYRAxHElLQlJEOckDjjbES5A==
X-Received: by 2002:a17:90b:48c5:b0:345:badf:f1b7 with SMTP id 98e67ed59e1d1-34733f3eb64mr33856675a91.28.1764562079912;
        Sun, 30 Nov 2025 20:07:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477aeb88a1sm11486769a91.0.2025.11.30.20.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 20:07:59 -0800 (PST)
Date: Mon, 1 Dec 2025 09:37:50 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Message-ID: <aS0UlhHP5aEzDZlv@fedora>
References: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
 <632d57cf-becd-4d09-bb21-0e3db6776c49@kernel.org>
 <20251129174133.0e369f80@kernel.org>
 <d4656eca-3c65-407b-a487-0a1816c38036@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4656eca-3c65-407b-a487-0a1816c38036@kernel.org>

Hi Matthieu, Jakub,

On Sun, Nov 30, 2025 at 06:09:18PM +0100, Matthieu Baerts wrote:
> Hi Jakub, Ankit,
> 
> On 30/11/2025 02:41, Jakub Kicinski wrote:
> > On Sat, 29 Nov 2025 19:13:08 +0100 Matthieu Baerts wrote:
> >>> +$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
> >>> +$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
> >>> +$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include  
> > 
> > I believe this is being added via MM or kselftest tree at level of the
> > main ksft makefile. Since this is a false positive, maybe let's defer
> > fixing the issue until after the merge window? When the -I.. flag
> > will be implicitly in place?
> 
> @Ankit: do you mind sending a v3 without the modifications of the
> Makefile, and supporting die_perror() in a bit more than 2 weeks or
> later, please?

I will surely send v3 patch after merge window with the requested
changes.

Thanks,
-- Ankit
