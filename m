Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008352;
	b=wXpA2wGc5e90j/6x1v36Mp/JUjvoNoK+omxsNy+PeopW46cWHI88KDF7JSF9lnL+gcTb
	 z3yrw0I4HqHGHeYgg+naqWR3VpGH/xxkEWHRINEqA1DlzA/iO4kNCvqD7aEQIy5MIzLcw
	 NDDhtMdK54T2TOzv9ifxVUxvbXDnLRhbWokp9Un0Rv7rGTNiqfKg4MU7mmWY74lqt+nPC
	 MNPvOgZVKl/0JUtkGySBEYkfZDLgebJRqIYLNh0cMz0Ngp17evktB27co884O2FHP+bH+
	 lCKic6ZexnklUZ1tj2NrwHwBLbqz/IaP2CIEeIH8CtuRtFM5RQERz81I8sZwsCTzLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008352;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8aUg7Spj/bT9b2AuPRxZKBWCta6YUoBpZswY351x5aM=;
	b=Ql9g4J3whlUZJj/6M+OwhQqqhw6A8Xf8tRlIAvKjKpWiy3/OIp5dfnlfyPLdNVWxyGw+
	 kQPSkXdwIhFhd0eo0DCJ2oXHk83eHAEXdHpVLOPzmMRS29NGThXFBvL5g7wa7W9y+Acbg
	 TsVjcF0kyUzwZbvlphhVZWs7MuRV27+9opfyN7NLp3DzWr0W425UvOcMwpsbvNcHcsxiT
	 RboeiDXhk4MWcq8YoPa7I7S2/BDMEqAL2YticM5zrPsm087zdFSAA0hjDroCuykXfXeLn
	 eYwUfwCCp8VIptEmU1eWAifdMX2hODV5BrYqty/d2tQZARv63VviGzKVhRMI4VSKynw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAmdwV8J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE115606A339
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAmdwV8J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ACB1F01828;
	Mon, 26 Oct 2026 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008351;
	bh=8aUg7Spj/bT9b2AuPRxZKBWCta6YUoBpZswY351x5aM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PAmdwV8Jg5AgtMSblsJVfcO03SDMbQUoMjfM9geZCWyFqNIfWUZlyev3+G69we1+Z
	 SslTAe2EiPlB+xiiyeGkevd7V3WmZ9dssNxojft5x6qYXhAgZp9DX9cSKYXbxr+RUF
	 2PtVHnAvLjp0NNVnBSxC2juU3MSoVfmyjPjoWUlru24o94ATqlMvMdbWKl019sDkbk
	 AbP7ISSNbhfstOVXrwAENi/IAvxnaa2voMD0hN4a6APsoDPMnpQpCCdRdlE7y1h0XL
	 YP5e03HO5kdGHbEv0C8NE2ety0E2J8zeL5dG/Rn52dQynfv03OlAIO9OpWudAgATy9
	 SCXK9wVGmahqg==
Message-ID: <953a45ea-cab0-4539-8eb3-a797a0a209b3@kernel.org>
Date: Mon, 26 Oct 2026 10:52:28 +0100
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
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until EOF
 on partial reads
Content-Language: fr
To: quanyeyang <quanyeyang@proton.me>, netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
References: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
 <179289965578.3132.14505074087260563831@kernel.org>
 <1XrwbKHy7bqEAoICoQYwaNZzQ--JyQFbkUTMnIxpBYLCUAxob9CjFKXDAq_Sbl1OQ-MQPYb2LhNIU0Qr1h90ToNjyXrlJtqbP1wrPgzdeiU=@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1XrwbKHy7bqEAoICoQYwaNZzQ--JyQFbkUTMnIxpBYLCUAxob9CjFKXDAq_Sbl1OQ-MQPYb2LhNIU0Qr1h90ToNjyXrlJtqbP1wrPgzdeiU=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2026 13:50, quanyeyang wrote:
> Hi,
> 
> On Fri, 23 Oct 2026, sashiko-bot wrote:
>> [Medium] connect_one_server() passes chunk size to do_getsockopts()
>> ...
>> Should connect_one_server() pass total instead of ret to do_getsockopts()?
> 
> Yes. That is pre-existing in connect_one_server() and is not part of this
> change. It is tracked as issue 638 and already sent separately:
> 
>   https://lore.kernel.org/all/20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me/
> 
> This patch only updates process_one_client(), which already accumulates
> nread/nwritten.

This patch has already been applied. It looks like Sashiko and Clashiko
used the "base-commit" tag added to your patch as a base, and thus found
this other issue already applied in our tree.

Please next time base all your MPTCP patches on top of our "export"
branch, and use the last version, that's easier. If you have dependences
between patches, feel free to either send a series with multiple
patches, or use the Based-on tag (or wait for the dependences to be
applied first).

https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches#which-branch-to-use

>> [Low] process_one_client() passes size_t to PRIu64 in xerror()
> 
> Agreed on 32-bit. The existing sockopt checks already pass ssize_t the
> same way. I can add the uint64_t casts in a follow-up if wanted.

Maybe good to fix it while at it, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

