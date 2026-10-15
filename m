Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00653D9CF;
	Thu, 15 Oct 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077985; cv=none; b=SszpgaMDMzcV4gOcLJZ9rf7JuKDyReVgXYvIAz8vywWPFbGG4TdulqlQvU9TPD1YJJH9G6We1tqRiXNUuM3PENE33dkzK0ulaEOonSQHDKdIeE6Gl4musKA3NHXstOJHqyXS6jNNAuOmWzc1U/ph5oxQA5zi3lWO6kA6FG3/lEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077985; c=relaxed/simple;
	bh=lGFYszG+X9cD1RSaVXN6Cax+Ro7OIJYt6TuOEfxjm4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ixQ+NQRjO/y53WfOBlK13wWEkjQ+7iENiz2ozj5MSrJ1rxcwEuTfuLMKaDFA67NeNQpj/o6YhCjcF1EvvBMsHvHCH44i8DLLq8aESnn0y9URYT/qKjYCYh+/+QSlFZaWkHpfAU8p8ql5UVVeAw+T3E09xZ2dDBvJR2Epz1U4VPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnjfDq1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnjfDq1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F18D1F000C4;
	Thu, 15 Oct 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077980;
	bh=atS3/rapI2FLFaIlwNm0Wvc9CuXO4ChyPjJlfJz6lcA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=KnjfDq1vehw4BngSjPRpCcDX+AiEYUfHCML1u2RvRBw6Jhuzx3saJUw4Qgg75Vk+h
	 ZXBATOsCX5lz1wNF6jUf0DXDDhHxbcE47eFX/rJarjh8fjxxmcHZo6yZllCypG0tIr
	 /cqZhyh2suN1Ld/UILpDmsjhk+mwaY97j9BzVHi2avS2lZNt+BWmCaG7/ycGsUjGF4
	 OV34vlYLe69GW8nUGd+7295xBTVpv1R5ozVi4N0f8K4sOZ4ENVSMz7aV8oG2jEenjk
	 X27cuw7P+fu6nGx3r1YEKh82aebAljD6DdfUl88P9ph0Nv1DVyfUtaT4fkhwaKnNbC
	 bYUnYyLIlb7xw==
Message-ID: <aaf47447-d27f-4a08-98ce-72815f9401ea@kernel.org>
Date: Thu, 15 Oct 2026 17:26:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: disconnect: reset first subflow's
 local_id
Content-Language: fr
To: sashiko-reviews@lists.linux.dev, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
 <sashiko-outbox-172945@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <sashiko-outbox-172945@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2026 16:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] mptcp: NULL pointer dereference in mptcp_disconnect() on unconnected socket
> --
> 
> commit 79fba9c250462a2f6852b46cf0562a508bcae604
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> mptcp: disconnect: reset first subflow's local_id
> 
> This commit resets the local_id of the first subflow to 0 when disconnecting.
> This ensures the value is correctly initialized if the subflow is reused
> after a reconnect.
> 
> Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kernel.org
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3654,6 +3654,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
>>  	 */
>>  	mptcp_do_fastclose(sk);
>>  	mptcp_destroy_common(msk);
>> +	WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);
> 
> [Severity: Critical]
> Does this code cause a NULL pointer dereference in mptcp_disconnect() on an
> unconnected socket?
> 
> If a user creates an MPTCP socket via socket(AF_MPTCP, SOCK_STREAM, 0),

What? AF_MPTCP???

> msk->first is initially NULL. If the user then calls connect() with
> AF_UNSPEC before any connection is made, the networking core handles
> AF_UNSPEC by directly invoking the socket's disconnect handler,
> mptcp_disconnect().

Arf, I forgot about this weird path... I checked with shutdown() (which
is not allowed for unconnected sockets). I will add a check and add a
packetdrill test for this.

> At this point, msk->first is still NULL. Passing it to mptcp_subflow_ctx()
> yields an invalid pointer, leading to an immediate page fault when local_id
> is written.
> 
>>  
>>  	/* The first subflow is already in TCP_CLOSE status, the following
>>  	 * can't overlap with a fallback anymore
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

