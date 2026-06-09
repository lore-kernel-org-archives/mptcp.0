Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC440DFAF
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007186; cv=none; b=ai52UvGDjOs4wYNZNOl3MbMjSEV9HJNwTKVSR97RtAMaM0NFR+yJBlkclscbpDROactnE6odlYYXLHslPAfUGMLxv9rUY1N7Ix0PxqmQTjAdWJ8Gu62bhCeRh3snAqeht/0Xjy4IhUeW1wG9uHqfepyOndqffrxPfnNgycuspPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007186; c=relaxed/simple;
	bh=G+vHkhOQyvX2lmekbnAv6Ywkb+ODNa78R7s251UQToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq7YhSz3UjlZrb/zQZMFoQMsoi0S++t9w1+eU6ZQBqZX34V8VggXIcXlSi4Ywm3sho3LDstxUXkazVho/Zn86sTrUrlx2Sw3J+jH8HDs4gMEOY11wGppobiSTSM8TAUSCHtFsfPUDE3RCRtubi56D9Bg1zIxTGxeIT/QLs/Euqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lwj4AgJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxpvdnPI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lwj4AgJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxpvdnPI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 83B401D00131;
	Tue,  9 Jun 2026 08:13:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 08:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781007182; x=
	1781093582; bh=4DKX5bDGTzVNeK9Ona+JNrqFwEcAU1ZbrrtAEpOhs6M=; b=l
	wj4AgJHVguL4xMYYDdth4JYognTCap74E5Fd3WjamFZJTd7uFy5GJXWoC9O+zMp7
	YWRQ9Hr2smEQ0p6aR8n16ZbeRVqLbE1BkXz3IeIZzLpYEviK4VFmrUozbkb00m27
	ekENwNi5pBKwyhGE/Xdt7kYiSEom4qejArx5Q3aOhoPfOiN6iL1xbV+Or/lZf3HE
	83kyhROaKVt5m7JsyPzuXXZE6eWFLsgecCXT7Str8s96E9GT4NHz1Sz7fhjBVdYv
	k9Yi6/QSkz8Md7lFq8SAApYsuhdkq2WlTD/rDW8YpiJ7Hu/bkvWNUYOqx78GOiPu
	+9J768WS5B2MbWbYfU22w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781007182; x=1781093582; bh=4DKX5bDGTzVNeK9Ona+JNrqFwEcAU1Zbrrt
	AEpOhs6M=; b=dxpvdnPIxvrkOm/Wx606TBlhjX67Ure4Jk90g/y3+A9A4w5JJeY
	HvmunRovsZbiX3wCcNYRIiuIx8VDICWSGCDdoTvc6XelfGiw0NRWktPN7uWw30ls
	dwjh7hLXct/iidkcl7ouO8qEwHqEIPrEfAOUQbeB7QoUdg+cI7hPydC+WTZ6zXFb
	k8Rb6gZx85rOyTaEKNakLkR9m3qsjzR/PBWVvrsclyUYtb3DF5MajQ/eyWkTDOeJ
	pHHCHPuMlqmJ5VFVdmyvWU6x9/ULp2Vn90grNG7dQ7LGp4jof1gjGfWoV76N5GOW
	XywRqePzBa9fYYnOvtDWrEonI/DbUtJ8aPA==
X-ME-Sender: <xms:TQMoaj9p7SFQDDue_M7hHRwTX22bZqGlv-Vo_HDqV3qdVmrzsKKEXA>
    <xme:TQMoahSnZpmIMMLaLPNdLcHg0AH9KHM82LrbhVSz5WvQex06_GCIk4adReFbmJAdz
    8xtKa1YhXO_5sNriu8wMi3awVHQ1N1EqdYOk6wYXVmmngdgKdjo4SCU>
X-ME-Received: <xmr:TQMoagSyyy---EULH95Lj7MoS8BL4_nQjThbS5DYZFwrL5xTGK4yBifiNzijolt9x06nnkVf_kTxhWTSxmne2nY>
X-ME-Proxy-Cause: dmFkZTFBYXm/+Yk5a+LVIvXPE+WgdUmcYXfyJ6+z1jaKtAJYdKcOrEJ3Im6UmG6F2r2k1l
    23aLRp0a5jfBLU7R4KD/n9voZXAIncB5XJMS82spkGQx9wLRUNgIIegmssaF14t+D+oWe6
    3XqVATEcZsmcEmDBtp57QzSDI+HJDxQPQe+/4UJVEdKKLq1b5QfZ4CSPGy1x7jcZcuMTqw
    qttXSwHFgaIwmHFFPVm8XpdEBbNl3rUp2nNdzyNsx7G5ZiHaXPDcTBIRZOMaVo1YiDF7gL
    7yCXiXUSd/j/u8nAkJVP2BfJpqwDu5oBHfi8EUL+5LV74btlJ/FtJzcb1dvu8PUG91kLhS
    8whIrBZwa4bpbkkPw2BcC4yyiNrPABxcn2VjvbjWlzA9Gc6ppVv27A0k/gn718l8JxS/NR
    pUL8Zw3M+eB+JlzRwY5IJPKmlvWe5rm1Fq6XBTmSX+8S2VsG+06YmXEg3cAbwoWyykatBb
    OCylq2JXrhPi46R/+FEAX4Hlr7u2m6SpO8tWSWMGh2hzurwu69xK5tRTzNM+vTigh+t1Ra
    12+i/pdwXZcuhvzYRH1at+l+YIdupz5nSDRGV0wr7csHRCFnOkFQur7s7/yWi++Ch9vLhT
    xDTjcZ2vSd/Vjmx9dnlb7/itWLIPSkayCuzx7VmSAY3iSFWZYk5c2BCcglMw
X-ME-Proxy: <xmx:TQMoal41WRr5yJk96trBcoAlZsjg-3_141-rr_urAoj99NV-7evH4A>
    <xmx:TQMoatU6L96XdICYTGV7ctran5szrVe1hxbLPT53C1E1nEDhPbSQlA>
    <xmx:TQMoaj_pvU24azqdJoiohgkcrVXFYURgeWo_brOBnN71F3eOv8mbig>
    <xmx:TQMoaloLb97sLiZ894qMGKshT1V62WFirC4usl2S-_OKz0xoTlFP4w>
    <xmx:TgMoaux5AacP8Ju3CM2T3Q5xE_ITGv3zUVXaty9c13R00KJno8qEI7BG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 08:13:00 -0400 (EDT)
Date: Tue, 9 Jun 2026 14:12:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Atul Gupta <atul.gupta@chelsio.com>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
Message-ID: <aigDShl67-mqMs2S@krikkit>
References: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
 <aiZ9PZxNyp9jik2v@krikkit>
 <20260608200254.3be56aa7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608200254.3be56aa7@kernel.org>

2026-06-08, 20:02:54 -0700, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 10:28:45 +0200 Sabrina Dubroca wrote:
> > 2026-06-05, 20:57:07 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces  
> > 
> > Or maybe it's time to simply drop tls_toe? There's only one driver
> > that uses it (chelsio/chtls), and it hasn't been touched by someone at
> > chelsio since 2021 (2355a6773a2c [1]). Since then, there have been a
> > few fixes by people who I doubt are actually using this (Eric, Dan
> > Carpenter), everything else is treewide/refactoring patches.
> 
> Yup, tls_toe is unsalvageable. Sabrina, could you float a net-next
> patch to nuke it?

Good, I'm on it. I'm also removing a bunch of EXPORT_SYMBOL* that are
no longer used (and should never have been used outside of net/ipv6,
but well).

-- 
Sabrina
