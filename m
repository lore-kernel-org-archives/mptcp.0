Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A5198E63
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387738; cv=none; b=PUxI4BBVii4cc5waXgp3BjjES/G0kmhUs1mXQyH7ol9odTdzBd9r/DPW+Desbb8593wh5nABSvxAvibvY/6+9KMpC0Z2t7/Mj6H5I77hYkV/TLWd8f+WqorzBrHTwPKDCqwixlJrCj1/5DLVInk5kF9rblUpBXU1lublyNwIOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387738; c=relaxed/simple;
	bh=TaAnkgvwP/TvvrfdAl8NX9efJWboefZ0h+g5g0c+Eyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUnBLsJesSx41f9G9hc5iUEA9hNtQuCh2avtaJd/2TSO2CtJVE75a1PqL+T8lPXQ8PyYvHeuGf6dIKormAK3fUIx7hzZDEcXIGHzHTVDPojNOkW2s59nQL2Y9mGrsh+Nq3/NEldGF46PwPsKWze8pqKBIuiwJyuhURLJYve0Yi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFqEF6gC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFqEF6gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B33C4CED6;
	Mon, 24 Feb 2025 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740387737;
	bh=TaAnkgvwP/TvvrfdAl8NX9efJWboefZ0h+g5g0c+Eyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lFqEF6gCFcNFVBtl+46XkMmyfmptLiYHsTIeaCJwKsvEFm7yLsQB/IiHkJQqunS2q
	 1T/rRQFFKnWy9pkOTVG5xLCwmvDaArgrz9s8hYkr+59Pfl0ffzP2eJtvkHfD53AxZU
	 ilVm3C1oSyHlBrUvWhY5TuPOPfgeQ8oo/VUJC6qF+CLcxXMB489vBZ1/yenfQ4X9Yv
	 i65TFAizg+9vIzNqQVSM/j6Rgy65vyPebqtqa9qnHVBCCNXMGTPPklBRiaWh2Q7Kk5
	 H/nc2dbC/4GsfI6bPSBaYHALND5dwLr8dfIEh+2Su1jHKM924Ma19dHoqI7IllFiSq
	 8gyyuFG3/3i/g==
Message-ID: <fc1589c3-b56a-48e9-adfb-cf2e788ba6ca@kernel.org>
Date: Mon, 24 Feb 2025 10:02:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 3/5] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
 <f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn>
 <ba46f04b-e2bb-4d9a-964d-d9dc7ccdec74@kernel.org>
 <64115dfbaa4e31a997cdaa8c8195eeeae4fab247.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <64115dfbaa4e31a997cdaa8c8195eeeae4fab247.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2025 09:31, Geliang Tang wrote:
> Hi Mat,
> 
> Thanks for the review.
> 
> On Thu, 2025-02-20 at 19:25 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 17/02/2025 11:34, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Drop the NULL check for 'msk' as Martin suggested, add more checks
>>> for 'sk'.
>>>
>>> Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
>>> the
>>> argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
>>>
>>> v3:
>>>  - continue to use sock_owned_by_user_nocheck and spin_is_locked
>>> checks instead of using msk_owned_by_me().
>>
>> Why should we continue to do so?
>>
>> From what I understood, with the current version, this new
>> bpf_iter_mptcp_subflow_new kfunc can only be called from a cg sockopt
>> bpf prog, which means these checks are not needed for the moment, no?
> 
> Thanks for the clarification. I re-read Martin's comments and he also
> suggested removing these checks. So I removed it in v4.

Thanks!

>> So maybe we should only add these checks later, when extending its
>> usage
>> to struct_ops? In the meantime, msk_owned_by_me() could then be used
>> instead?
> 
> Do I need to add a patch into the "use bpf_iter in bpf schedulers" set
> that is under review to do these checks? Do you mean that using
> msk_owned_by_me() is enough for struct_ops, and there is no need to use
> sock_owned_by_user_nocheck() and spin_is_locked() checks?

My understanding is that if a kfunc is set to used in 'struct_ops', it
can be used with any 'struct_ops', and not a specific one. Is this correct?

- If yes, it means we don't really know in which context a kfunc will be
used, thus we need additional checks. But... this feels wrong: if
kfunc's cannot be restricted to specific 'struct_ops', probably this
should be reported to the BPF maintainers, and see if it could be
possible to have such restriction not to add unneeded checks at run time.

- If the MPTCP kfunc can be restricted to MPTCP 'struct_ops' where we
know the msk lock will be taken, then no need to add these checks if
they are useless.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

