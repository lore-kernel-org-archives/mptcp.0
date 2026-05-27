Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8E3F9A0D
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881709; cv=none; b=hLPPt6YFm1Sas9jMGsPM1eKGxQaE0pEHsWWXwCs+rq9rzEsNK1Yot5TzCxe4dpcR956XxO3ePFj3hVLwMFyV+uPUm1k/TF3zcNab1cL4kfaKvFHwMCy0LMipwKh6lxXORDjQjQQ8MlAusFh4YYDJtfgMy8eB27JLdDyUvaJbe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881709; c=relaxed/simple;
	bh=Cf/O7ai47T7xHejiidVipezGVoG6fw2a4OZEQf2vEJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeTQEdckZyK8CP9gJ5f+0UzOwdCwdd6E9URury7YXT3eLxPlVaxOZ6tufGHDunD7hWS6VQhgtBk7btnGo91gwyAnka4uZVbrnYYivAd8tjI4noAcevjiCEvzgQ5Uy2DECPzcm71GyFuYrD3Sjl0nopgiwMSXLkBocHUwd9NOEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSu4/jF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSu4/jF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAB31F000E9;
	Wed, 27 May 2026 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881702;
	bh=eT1Y7QGO2h6bprGPxgQ1iGicUv7k2od6DP0H4fW9gpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kSu4/jF+HAsVXCIT3Y2iv1Fa2Rgkwdkfla9kQ+vWvrbBH6r5skWGW2ncIun9FYQgi
	 drVnuWEiWAtDwVt3MVe0Az/5A3fW5T+nERdvV95fRW9JwV0kp88WMtWlQZXgVZ44D9
	 KaoIgj+KFeyKLRfUb2mUERzRFqxYYX8NrEAmHpsR70qH6qY27EN/gPV8c9EyYIn926
	 l09Qsw1feZzyb+RrulT8hXtCRdvY6MO5QkAWhLBRc6sLRPEYOiBcPcu64DnaT99zQv
	 9I8rasfNKZzVdGPLzB1AzgVxoJKFpPrkIO43Immnwl+ArdkfzfuPJvWLzJEa1BkNT0
	 ntWhqzFT94Y+A==
Message-ID: <f8034de8-4941-4b1a-a550-77d9a0937f65@kernel.org>
Date: Wed, 27 May 2026 21:34:58 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: pm: fix extra_subflows underflow
 for userspace PM
Content-Language: fr
To: Tao Cui <cuitao@kylinos.cn>, geliang@kernel.org
Cc: mptcp@lists.linux.dev
References: <20260522084658.1896374-1-cuitao@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260522084658.1896374-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao,

On 22/05/2026 18:46, Tao Cui wrote:
> This is v4 of the series that fixes extra_subflows u8 underflow bugs
> in the MPTCP userspace path manager.
> 
> extra_subflows is a u8 field in struct mptcp_pm_data. The userspace PM
> increments it after __mptcp_subflow_connect() succeeds, but
> __mptcp_subflow_connect() calls mptcp_pm_close_subflow() on failure to
> roll back the pre-increment done by the kernel PM. Because the userspace
> PM hasn't incremented yet at that point, this decrement is spurious and
> causes extra_subflows to underflow from 0 to 255.
> 
> Patch 1 fixes the underflow by aligning the userspace PM with the kernel
> PM: increment extra_subflows before calling __mptcp_subflow_connect(),
> so the existing error path in subflow.c correctly rolls it back on
> failure. This also eliminates the race window described in v3 patch 2
> where the worker could decrement before the user thread increments.
> 
> Patch 2 adds a selftest to validate that subflow creation failure with
> an unreachable address does not corrupt the extra_subflows counter.
Now in our tree:

New patches for t/upstream-net and t/upstream:
- 39532fa9ab3a: mptcp: pm: fix extra_subflows underflow on userspace PM
subflow creation
- f4c28694fcb2: selftests: mptcp: add test for extra_subflows underflow
on userspace PM
- Results: e4d7ed773e9a..a6fc1cc14ba0 (export-net)
- Results: e10477e57c2f..c40ac68d9bc2 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/a5802653c80bed89b89dfb2bcf7a1d27a9ccbb05/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c556587fb705370c99b07b8eae2f23e16e6bb145/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

