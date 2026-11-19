Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115607;
	b=EQxcymzY7Okp42guRoblJj5gjKjqqvBq/r2XI4Rkn9nAsfY7XcaVdH0W/bOItoGqaaYE
	 FYKycrgNVqh9YaPk0ORl6cQYNyP4GLmbczCUr0jUKNVJ6xJmjv0YzjLSOoGcnVb6kaSp2
	 x69XyShALmWPyhd7VkprM4rZBZVZAkefO5TyhkTA0TD7iMn8GG+BYoLOc+9BTjlxNvnaA
	 GdAMh1N1A8fk02fqHh4JC220D34WMkBjAMJbmZvSoT7Vs2aiDawB6goZTbFvF0naPjaj9
	 fSh1Db65sXsiU6m2O1AHocS2asO9YEIbeNxap8CwA6SvEyNLahonPwy5r5pXyUCaf6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115607;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MvW/Jus/Vy01lP2emx24/z5kIpS0Aon4QH2fAoEv36c=;
	b=qdFqhvWW7NwE1YEdJCdq5cBp6CTR7s6F6I3nLAsgVPZRtX1jZvtHCt86l5OX+LWCQt24
	 RJXv7hbiICf+h9WZenCtfaZacdrTvvd4murfajHJRy/5VjfmEp8EZ6oDwcYTJ67613S/B
	 tbCLZHwyXyHHC5hdahn2gcsf5zUzqopcU4G0kGDI0NfeNQb1E0YroCIOLWBchn/qecbIF
	 QycWRtRiaw9CZtg+wJVqF1bHwqjqewmCbfM7sEOJkVFn5/6sHzA/+hWWX3xZjXWruynTc
	 j5VVhh6jYE5DVgHj8tjsEPhVQdhY17XCuqxaVUx+ap1tuaNY1K1lK/hnKqUYkNH/NuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMHgwxll;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C457606A326;
	Thu, 19 Nov 2026 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMHgwxll
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F761F000C4;
	Thu, 19 Nov 2026 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115607;
	bh=MvW/Jus/Vy01lP2emx24/z5kIpS0Aon4QH2fAoEv36c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DMHgwxllkYhaRHRdCwNqXYuwf1Bw0e+myLQ26IS/qULLAoAqqNqvJNYFHqUcMk3PP
	 GbOt/KQCzxzNHJ8BVjlfWj8hYn/+95FKcxMM8NYP9Yk/ybga2kMXthTMPRpH7Apps3
	 11c1vNCBvrrU/+HNEmeToQ2z4m7Esg/COKoFAEoumPYm6lk+DE3vEZYH0MOO2tH3Fi
	 6b0BP5KMm0gtqmOGq9LMQwpihumPobgRnL5TsoPxQEv1+n0tF9s2ZAa0tayYm/Z+Je
	 1aQcswkGk4wgwZYbO4B0BzqrBwZPXJRiRnnXkUctjQBfj2sMMcAeCRmgxueiYrpgV0
	 mupAJbl20p/Pg==
Message-ID: <4e209707-bdc4-415a-923b-4ac1d2006ecf@kernel.org>
Date: Thu, 19 Nov 2026 20:13:23 +0100
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
Subject: Re: [PATCH mptcp-net v2] mptcp: fix use-after-free of the subflow
 context on the delegated list
Content-Language: fr
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 mptcp@lists.linux.dev, netdev@vger.kernel.org
References: <auqd0rAI95jDSMvu@v4bel>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <auqd0rAI95jDSMvu@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hyunwoo,

On 04/11/2026 03:52, Hyunwoo Kim wrote:
> mptcp_subflow_delegate() links the subflow context into a per-CPU napi
> list and takes a reference on the subflow socket. The context is a
> separate allocation, reached through icsk_ulp_data, and the list holds
> no reference to it.
> 
> inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
> outstanding references. That path ends in tcp_cleanup_ulp(), which calls
> subflow_ulp_release(). subflow_ulp_release() frees the context with
> kfree_rcu() but does not remove it from the list. Once the grace period
> elapses and the context is actually freed, the next mptcp_napi_poll()
> dequeues that entry and mptcp_subflow_delegated_next() writes to the
> freed context with list_del_init(). That is the use-after-free.

Thank you for this new version, it looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Sorry for the delay. Please next time either use 'mptcp-ne(x)t' prefix
and send the patch only to the MPTCP mailing list (without netdev), or
use the 'net(-next)' one with the netdev ML.

@Net maintainers: If it is not OK to apply this patch directly in -net
because it is too late or because netdev maintainers have not been CCed
(which I understand), I can send it later with other fixes, no problem.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

