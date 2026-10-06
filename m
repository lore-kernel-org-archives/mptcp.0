Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDD231A23
	for <mptcp@lists.linux.dev>; Tue,  6 Oct 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308246; cv=none; b=hj2WJBSu+0p4DZYsVgkmaZcjf1vSC/5HGJkUW3RotnmKzz0jMk7HZd6UwqHQfr9EZhPmi4zh/dbCPfkGYuea97Ab8k5O8nyOLpaBiu8UPmfDW8d3Gq4CNR4x19A+poAvRbaRa8mJO34legTHE+hrRrorXm9foBbtlddLswZBFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308246; c=relaxed/simple;
	bh=JKFhz64XYR9LLLd0gsAEsx8EvgopXg0zoduRZkjK7L4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=ZXoiXDNwFgbuJvhqB21qnaYUuvqGwzhB5HV9w4FKndTHYTgRL/OJ4HxWxoU1SvEennfzeBhR/S3OehcxsjHJ7xTxhQkeqoaHHxVNZ/xAKIMsTH/pQWNAOyQAbD4DlidPi6mMBvLUmwYGG5I5ntbWxi7zUGdEZUyKEPd9revnCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWhQOcrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWhQOcrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E2B1F0089B;
	Tue,  6 Oct 2026 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791308244;
	bh=Prj0kmtpw/ldy5BUmgXobF2L2iq2+f2osu8em1BV9x0=;
	h=Date:Subject:From:To:References:Cc:In-Reply-To;
	b=AWhQOcrO9YMjsIa6POjpxp2byFrVbenwF2g3QWPjK00bSHZNI0NwoqhbM+6NqlYU8
	 SAZdznBSieJ1C4KQmDjms6CRwEXrwTbdeuDopfEYqBkyEuTH6tbGML3Pia2vY8mEZH
	 cgkDN1F2YHlEB6PbqE1pCKhfhCKRyuLuGSqCy7ZTof0deuhrP21AkW7aRWZ99hIJAc
	 nZJ3HO2cJZelnAl4bWCm2mqmN6NhDIaQBu6mxWYhUboqw1eu//c+bc8Pls2aUwet3H
	 tEtynKwrMVk4PDc+UxpUHjDozVC1qVEfgQXMg48DHyfMWFiSuufuIB8dyrvpoR3qVy
	 Ai5daQ2z1iE6Q==
Message-ID: <a091954a-5989-42b8-a4ba-1f636ba33571@kernel.org>
Date: Tue, 6 Oct 2026 19:37:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: reset msk state on early connect
 failure
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: quanyeyang@proton.me
References: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
 <20260911-mptcp-connect-undo-net-v2-1-54224cea2238@proton.me>
 <21b19217-8aff-4147-b240-dd04260b3450@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <21b19217-8aff-4147-b240-dd04260b3450@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2026 19:36, Matthieu Baerts wrote:
> Hi Quanye,
> 
> On 11/09/2026 17:42, Quanye Yang via B4 Relay wrote:
>> From: Quanye Yang <quanyeyang@proton.me>
>>
>> mptcp_connect() can fall back before the subflow SYN is sent, for
>> example when the netns is in an MPTCP blackhole, token allocation
>> fails, or MD5SIG is in use. If the subsequent subflow connect()
>> fails immediately (EAFNOSUPPORT, ENETUNREACH, ...),
>> __inet_stream_connect() returns while the socket is still
>> SS_UNCONNECTED and never calls ->disconnect().
>>
>> The error path only dropped the token and moved the msk back to
>> TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
>> request_mptcp were left as after early fallback, so a later
>> connect() on the same fd stayed TCP-only.
> 
> Thank you for the new version, and for your patience! This patch looks
> good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 070796c3cfb9: mptcp: reset msk state on early connect failure
- Results: 55d917c22cff..a89bac927400 (export-net)
- Results: 3f56793da91f..3ec672648191 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/fe786c67a826c2b32c8a2882858ab9ab45b7cfe0/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/bd2d51a45268c4bc02f5bdf66c5605ff6de59afd/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

