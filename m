Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937E38E8BA
	for <mptcp@lists.linux.dev>; Mon,  8 Jun 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907334; cv=none; b=n9a4zDdQ0PqihNE7lZWtUl95afu8x9Iu8NMbWkTMK+dkPh3wcHfW1OB508OzCMmXf1iXTfxrASA/PcKb+5zAyi90RFverseQGRWiOLXHqIpiIW4C5tyJxniD36wTCP0/bSdYQEEbIGwagxeLxY9gKBpiy+7AGopoyflCQ2LJIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907334; c=relaxed/simple;
	bh=Vcwx4wpDVfdW54CMOACwFWgvF0pKt/OdqNx3hxjiAA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6k5F+ORIfEOrZHonV1BbWgGSgBAZBugWdk7wV001c+NKfYDP3tgc6s5QBC2lHc8JbXCwb2EDlpaJMqaIgeMaOiLh7o74YFtQUAlZ2sLo1iysMhgEQKSXyrrg8xzJkfvML9iQka5mTWw20/gMFhdyO1AkPHi93eQKwb+byc43Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JApMGmvK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgMDP0Dw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JApMGmvK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgMDP0Dw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C6411400087;
	Mon,  8 Jun 2026 04:28:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 04:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780907329; x=
	1780993729; bh=/6YUVylcBJYIyGEqLW67qZMbT2/Icy8DuBaWz6AsGn0=; b=J
	ApMGmvKR48oa6d3kh98b1PClsqFNygmhFrq9/o3gWM0sgOwH8Jb5gDC3uNi9wPN1
	ER3bx+D3JFuXCnFY+xMg4jlVKJkeKm0ePiCUswzWz/u5rNdTztl6C/r3TSvB7EsJ
	qm32s6R84nfEqroH8oVvmOrxS0rMhn42NxAWwMe/Jggpb49fuZ0h/CozRfi0oEql
	/+FWHnm98J4kPIYudufwETKFFtfTcCVQN7pPKw0M5PhLkEhu4EJiMPXzeBjt6tVO
	0jpH5It4KGK7O13UFn99ducBhTvAV2Z1xiCNL4YOIMvpBz3tb1Hv1U0uhuJU2H6n
	dvb2NQ/PmOF6VVTW9B3Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780907329; x=1780993729; bh=/6YUVylcBJYIyGEqLW67qZMbT2/Icy8DuBa
	Wz6AsGn0=; b=fgMDP0DwWvTTQvyZoU9ZKL7YsmJA5049v4uCeQTwxpeFGoMPlhR
	+ekSpYBORKuJ5xIgvYkt8FZ97GDT88o1uwwd3F6Uu1Bz4RbgUP9s+1DI3i88EaFv
	yQ1MfeAw5/7Ao0kqbW1VK+m3Dd8dzY7V81o6CfQUm43v02GLDI2pulCeEIzLv8Ls
	J7CSEBWASlhhh0QKkXMhJ0ai5jHqDSI9Dr8olHJllOhcuRBpsiJAMucpRwu61Lq8
	rd5YYyOYzGMJXALkIKTgmKXoztp5N+0T/hIeZsanyPvHXfnviMxJ7FGIjlEOkZ6W
	a5M1vf6bc550YoUlG/CYsPxwbmKqxJGBUwQ==
X-ME-Sender: <xms:QH0mal6qvnbVLSQcFyzuNk1ivlvZgxBD9plFsuSu7BQwdxH7Jf837g>
    <xme:QH0makc7laETKDzoXItS3fgpdiS53JLdqIF7QVcYgiVARQhrXZEnnYPcrjQm0tZco
    PQXsSLXDhNb2dL78lxmSQ4N246SYVhRJEVfjbJdu_a6EWXo2nK0y5g>
X-ME-Received: <xmr:QH0marudyl2kZ9onPh4uDYwmYFo3h07cuTS6p84Hf4zNDUlaZDqeRtjiIHN7cWPUvOVrBaxpgQh71XM0HcyvgDw>
X-ME-Proxy-Cause: dmFkZTF5U5CZAuVuEjZLGgeINGSgcZQvwuZrthws7l1JZXZgYLWPF96nfLTV1NNhYnqybC
    dPOl/K5egFQgHbgKWGYwftJIIPeLIQPz/MCK5mLOG2bqHHS8gaW284kpfDq/e/v9pzj2nv
    URRCt9Wo0aK2WIKjr7j4UsPb091XzSNGPj7mu+5I1c3iIWsCq/6tODS3VS5cduYWoydDrK
    N782N1xY8dY3CmxkFqGsp7mmaYT86zpxPNCyT99qgQ5Ti7FechW5Xwvv4QAyC/ggcF6Bc6
    ygrsm4Aiat833ztMdNRBphDloAt7usBvvUn+qWplaxK4GoPRak2AeN21OVAQ/WwC7YghTS
    WKx6kZjHdELfpODAD+Pj6tfyFX3i36MFCwRX4FQRydzV7YWuQV3mLpJg+oZFg0ZDUZmRtL
    EWAIec1onbPT0GsUlnQmoAtiLqHaZ7hMvASKPyveJ7iGc0pN2LgFytVPy8KjXHwqicM+oH
    5oTNARazcT2xoYH0emFJKE2YMKfwx65js59B6pmkHjrSZJE/RGfeeDR4Z2wVUxeL3BF0zJ
    N/GaI4F+oyjciHBQi1IoV5IJnSJ/srgRCSTqUnOLHElv/WvyefYLFawKJ8x3qxypkDZj9u
    XEm1r/Hp0si//PweYaA97JTAEo9DITfgKOnFzK0tJZVWKjgWNhVqcZ0IkQMA
X-ME-Proxy: <xmx:QH0makn8Xba0EzgmiVDiHOCRajNmZqrvzHTSrFYPJlICfyTkD97poA>
    <xmx:QH0mauQOk8ELDJJl70zegWB4LvCcC9sj_bfyqIaJ8LZuhvNNTy-7Hg>
    <xmx:QH0maqKtmE_eug6dH2CiJQzE8WG_5Xvfb1W3of_xkwmFoqQe4OgkLA>
    <xmx:QH0maoGbSRo--QFb5Kb_rWYceA2FJYsLolZSkKoeZbyutx7tgkLxzA>
    <xmx:QX0maoNj5O_d3QnyVki3WS4z2ob1SoCaKB0WJ-3BWCRjSyseAWAOA49X>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 04:28:47 -0400 (EDT)
Date: Mon, 8 Jun 2026 10:28:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Geliang Tang <geliang@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Atul Gupta <atul.gupta@chelsio.com>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
Message-ID: <aiZ9PZxNyp9jik2v@krikkit>
References: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>

2026-06-05, 20:57:07 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces

Or maybe it's time to simply drop tls_toe? There's only one driver
that uses it (chelsio/chtls), and it hasn't been touched by someone at
chelsio since 2021 (2355a6773a2c [1]). Since then, there have been a
few fixes by people who I doubt are actually using this (Eric, Dan
Carpenter), everything else is treewide/refactoring patches.

[1] the author of this commit, and current maintainer for
drivers/crypto/chelsio and drivers/net/ethernet/chelsio/inline_crypto,
hasn't been around since 2022

-- 
Sabrina
