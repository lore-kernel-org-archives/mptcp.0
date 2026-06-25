Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B6346E56
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374813; cv=none; b=e7XjAEWffzt934CBa6OLrxptJP8fHURPWiJa19hHJOJ+ZtYvQPVeJ4ROTl4cNFGeHX6RscDAoaY6Qlaz2/ckec4pPjICFETrOlXkHLYyFA43eIslqUPEOUBTGK7moE2F5I4/co5boOSpOFyKsGTBlzuw+AnBCqXOk97NtLA1Y0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374813; c=relaxed/simple;
	bh=UZorJyRJCbjLFU0v57JVCEwuxeyqGU5zoYPDWorPND8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYBTWRuFXGptJUYm5nNomtelWqxc/7V0QuYN8ux+V8///3zCUletS+mOsRdHSOdN/ny3Mu8CLl7CUa9Ed55KpGYyKBuMyGPyEE33IZmDt6iBJ4AYPikApI14gwDsT7WOEtUnv+f18tS+JHLtY2MKQ5zoixA9CMz9+XDOK8p3qLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwX8YFnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwX8YFnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056FE1F000E9;
	Thu, 25 Jun 2026 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782374812;
	bh=yLIufNj5YV41SuqrDw4KB4nFAZ20h6o5/nheUz1DE+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TwX8YFnrt2PFPKt3YeDnUxGjLsPWjdGoRQISc7KRpbenPrPHHgAYpWTLHxY7kWGON
	 1oAa21GBQMMDOnKMKOf5lzv5XohdBM0aHikVYZ7Ur2NtDCSCcp9TulnRnfZNrjxIV7
	 14mRgeyIL/4El65HdkDFnXKPbcR8XsBWbskZC7WxyXgbDUm5qfOkonCOQipdJBhnHO
	 FjwHgla3ViMRcjLPhlfge8qk9heKvtJnty2OWJrXRBcWX1xMjaT2QcBxyVBN13Wi8i
	 mmj1qyYOYrri0C32SVB3GfT0M8JQII7c2gG75/86zlq9VNsPOXWItCNnJ9LF06ywba
	 Gr2AKv/3/LAeQ==
Message-ID: <ee4535dc-81e9-43a8-9b4c-e43be89e1628@kernel.org>
Date: Thu, 25 Jun 2026 10:06:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 mptcp <mptcp@lists.linux.dev>
Cc: martineau <martineau@kernel.org>, "shardul.b"
 <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>, shardulsb08
 <shardulsb08@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 syzkaller <syzkaller@googlegroups.com>,
 Akshit Patadiya <akshit@mpiricsoftware.com>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
 <19efd82a727.5577df63663915.5557063534077196375@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19efd82a727.5577df63663915.5557063534077196375@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 25/06/2026 08:40, Kalpan Jani wrote:
> Hi Paolo, Matt,
> 
> Gentle ping on this patch.
> 
> https://lore.kernel.org/all/20260601083010.924938-1-kalpan.jani@mpiricsoftware.com/
> 
> I haven't seen any further feedback on v4, so I just wanted to bring it back to your attention in case it was missed.

Sorry for the delay, your patch has not been missed, it is tracked on
patchwork. The delay is due to unfortunate timing from most of us at the
same time, hopefully this will get better at the point, and the load
will decrease!

I will apply the patch, the v4 looks good to me.

> Changes since v3:
> - Rewrote the commit message: the old backlog traversal in mptcp_close_ssk() ran before __mptcp_close_ssk() took the ssk lock, holding neither the ssk lock nor mptcp_data_lock(). The race is a concurrent softirq RX path (subflow_data_ready() -> mptcp_data_ready() -> __mptcp_add_backlog(), under mptcp_data_lock()) adding to the backlog mid-traversal, not anything tied to a release_sock(ssk).
> - Added the missing Fixes tag (ee458a3f314e).

Thank you for the changelog. It is always useful to keep it in the note
section (under '---') to help reviewers.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

