Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2153C6A2B
	for <mptcp@lists.linux.dev>; Thu, 18 Jun 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775065; cv=none; b=hQk+c8/Qo83qz9ViWC9Jx+A1WH8yZx2si24Rys6duzYfeiNnaHf19TEPguyBwLFq8gDP4Zdqw6y9MZORsNFFLpmZYH/l8v24JA7Htc6gVVDkyFqyseocj562m2RUINxOUxyGDXwcZP/4w628VXUVVSyX8B9dPSAVTZuSuDgnFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775065; c=relaxed/simple;
	bh=VN/iT4Vyt2zQ/Lt0lxydJdOBBLErLtP81sU2rzfVrIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbqqvHqais4qvGrSHIEIGXDdUzXRFs15zwTmKCnU2lF4uOttX9wqIIYlvS90/+mZgKG9CM4K+25gkP9lc0fgkUZe8yxjLyaZeYWzPKqe4dtZltlfxnGy45a5Z/NUvtdQy4wbCDhyVO5MDA9zTetB9aU6PubaS8bzeKZ4FS/b65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX4+lT74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX4+lT74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5501F00A3D;
	Thu, 18 Jun 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775064;
	bh=6ImceKI8pD0ThU+BaPovabLqemQc6VRC4eq3maq3iLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MX4+lT7422AfMFs4LYFR9gGv22IUJFGOzmgnYmo+FfTq2FAK0k6Hv+Pb4Wyy/6ZPz
	 lUXqxJroIrnplKgMVX2AY1S+d8reWqAFo+IMFUxqnXAgg1yQnQMd2URr8kM1uc6JrD
	 UjShHXsfgUy+UnMRUn00g7qjdA+1I8qOZoMQpgNXSWF8P02Lm5no9MUxZSL7aPqInv
	 S3qZAjOwaLsiZD5pSKMGTQxSwAAwVrpv4UgH1i+43ijTZTfvewHskubcB4Lk4eQ/4+
	 +EudhYnrJyPpvkui7YsgGKWlT3Fznzuv0vWKy6VUM7VAfqxP6pDJ+Z2US9SmdX2jkt
	 jDDx/QXmUAOgg==
Message-ID: <3b88b9f7-a08f-409b-9f89-ace7368f7124@kernel.org>
Date: Thu, 18 Jun 2026 11:31:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 8/9] selftests: mptcp: mptcp_join.sh skips
 v6 subtests when MPTCP IPv6 is missing
Content-Language: fr
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
 <acbcf0efa677685ac782dd6360d191a8d23c6dc2.1781707101.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <acbcf0efa677685ac782dd6360d191a8d23c6dc2.1781707101.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2026 16:46, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> mptcp_join.sh configures dedicated dead:beef:*::1/2 IPv6 addresses
> and IPv6 default routes inside init_partial(). A large number of
> subtest groups rely on IPv6 or IPv4-mapped IPv6 endpoints:
> ipv6_tests, v4mapped_tests, mixed_tests, add_addr_timeout_tests,
> laminar_endp_tests, plus one v4-mapped case in userspace_tests.
> 
> All these IPv6-related routines fail on kernels built with
> CONFIG_IPV6=m, which implicitly disables CONFIG_MPTCP_IPV6.
> 
> This patch adds a helper named 'skip_if' which doesn't call
> mptcp_lib_fail_if_expected_feature, and can be used for guarding
>  the v6 subtests in userspace_tests.
> 
> Assisted-by: GLM:5.1 Z.ai
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 102 +++++++++++++-----

I don't know if there is a shorter way, but that's a lot of
modification, and not something easy to maintain: each time a new test
is added, we will need to remember about skipping it if v6 is not available.

Instead, we could add IPv6 support only to the tests that require it: so
adding the v6 addresses to the different interfaces in a different
function, called after reset. This function can then check if it is
available.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

