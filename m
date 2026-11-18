Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997289;
	b=RuQJ8fnCkpBM56REaLq/NFfa+WpWt9/NHtEakUOYDHd7TNlvHxilnBM8WmHT4Wvlstu1
	 0skJeWgO/Bv25WX+vMMEANbVUmrsMOn/sh8GJaPCZxWV2D1KfwLd8VTN2vXwYG472VHtZ
	 ZtvDlyQq6AqqxjD4vb7DIwTmxi+Xmjw5qjzKaRI1FxgGKodCevk5yy7Eix4jKwfA6f8NS
	 +4vq9K99J1UmkkMqVczraI4o1LH3H+IHvc3cfzOTzy08rgg82lUz1Ff4Ge50QzDhuawYo
	 /nBh5mNgox8P6bANTeDdT9vK1yctbjM+3XqjD2wU+V/0qtxhLyrcluuHKrFdQ4QOKuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997289;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5JwEdw7oQnNfqJ3rJ8GXUaWGc0jOb4+cV+iqaXyWC9A=;
	b=zqWqXhss/hwPFKDNwqIGWfVwFEgFhh2u3XtAxUKQti3HQS8jzl8zGGCwIZl5w3jjNb3q
	 jOMmbS09pzg0s2nB71sxfejYATUBoT6TrzIzhDQtuKvnl+vhRyrhpw9acD2s3yg7NWnhU
	 NGREyUBVaAWQxKU1UEW0dK+4ozUn1dSbWkfmRp8Wqr9PBoEIGjsjoq3i2LDZsLOc/9sQF
	 RaMwk/ukmGe7N0YS2DoO9kFnTdfAU3G8J7m/OpusAMgP3a1o3jxMXoMqZaN15x+nemZ9+
	 eFxXDXlj8L1TSof/7czd/JacTXSQ8gyVbgOs4CuY1ywAum7kfrEtY16YA1MW8pmj4Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuQ8BFuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE977606A320
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuQ8BFuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567221F000C4;
	Wed, 18 Nov 2026 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997289;
	bh=5JwEdw7oQnNfqJ3rJ8GXUaWGc0jOb4+cV+iqaXyWC9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BuQ8BFuY105bg7g6nADgOlVFza8Ih7F5DPTknZq0Zmv9S9QYbtfi5WmeBXroq/QkW
	 ICe+sNmT8GLPH/4wnG0Un/4HAfVy9H3wmpMZ/oDkJrlyWVu+NSFSn4HtRwYb7aWin0
	 OeTbLgREoexRUGNb92z2QRc2TszSfLN0GUDz30G2SbpFI5kQ8f1/1QpFH8Nsdhakxj
	 eIoXckt3yMz3Imw0IWN97DXR8ZXEW3UHH8t9QnhX+Qv6c5BrrD0wC2CSi/iHvPt3QE
	 tO1Fd5NWBt6KSNduKWK8cMAG7E7eVsoWO2Lcm8L96L+2kGQIwbbr1kqiPcNdyeOIuT
	 gMbS2BGwkOifA==
Message-ID: <e5b05d4e-a3e0-4e77-a608-b58d0b89e87a@kernel.org>
Date: Wed, 18 Nov 2026 11:21:26 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v8 0/2] mptcp: pm: in-kernel: fullmesh: re-add
 of the initial subflow endp
Content-Language: fr
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
 <20261114082210.3439645-1-w453y.me@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261114082210.3439645-1-w453y.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdul,

On 14/11/2026 09:22, Abdul Wasey wrote:
> On Sat, 24 Oct 2026 11:18:40 +0000, Abdul Wasey wrote:
>> With fullmesh endpoints, removing and re-adding the endpoint used by the
>> initial subflow never creates a new subflow from it: the closed initial
>> subflow stays in the conn_list, and makes the PM think the remote ID 0
>> is already used, or picks its reset remote address. If the initial
>> subflow was the only one, no address is left for the remote ID 0 at all.
>>
>> Patch 1 fixes that, patch 2 adds tests for it.
> 
> A gentle ping on this one, in case it got lost. The MPTCP CI and both
> Sashiko reviews of v8 were clean.

Thank you for your reminder, and for your patience.

> I saw patches 21 and 22 of your misc fixes series touch the same part of
> pm_kernel.c and the same "delete and re-add" test. I checked that they
> and this series apply on today's export-net, in either order, without
> conflicts.
> 
> If something in it should change, I can send a v9.

Thank you for having checked that. On my side, my plan is to finish all
the series I have in progress, especially the fixes ones (and the v2 of
this series you mentioned is getting huge...), but I will try to do some
reviews in between.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

