Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC53E3D95;
	Thu, 20 Aug 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223987; cv=none; b=ApwS2eIFN2HK6OS9uYaNqemnRKA6+p4bQaUrRrvWcKP3o+f1+Gaoly4RbQxNENobnV8mX5Te4HzkgcqoWjGr5ZuygFB3eAjT4OJGjNvT7abuIwb8qMMG9Xx790V+/UK+2cUhlZSOXIbiYXWHBlU6sgDNxwoAKobTuYO6jgGze3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223987; c=relaxed/simple;
	bh=f2FdYqKKiYNChib1cHpBpuIV9SFOoggSwnxewz4A31M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5QpBuq5Vt4NHYROtXFeQfHZFQBc9xySFn39723pA8ByHfK8L6c1vqIRpdzl4LgQVbKRctmdF5OeDbk5gZfxpHk4FW4XaBQa9cl4XUT3pVumUNBf2FHVw5w/bPxQ2OANmGNeniIPZ7LSNDdOU/9rEth9sO52cF0b4ecD5a+Isqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcwvmnG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcwvmnG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF521F00A3A;
	Thu, 20 Aug 2026 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787223985;
	bh=3+6mlSi2lY6fi+GLOAuc57eBU64IlSnWMGCsUDAH6/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WcwvmnG4ccL7UK1rc+3aSQlG+bmCg/OxsJDKA+3cmDrcwyy2pxDdWRblL40Ce6wFe
	 tdeYUqhlSlPLO3xarPjZzeS9tjHdegibV5+My3ySvOC+fWaMPkqUcGeNIl2pFaei2A
	 RVWt7/ZSQlbqm/Kwn2nWSJTg4n0sfh8J+YydxmKI9M0SUx836Mx/YjcjfdLMFjZ7im
	 bJngLHpTNHNJ3gcRcAQz3n2zrnXEXywgNYuwR2e7fY1q85p1wrYkjfnAPrPIaQft2T
	 elveuHJrEpJV1IawQC9WNcMz/NsaHJZ6MzLFky5dzkBIWgYqvyNufFm/f5es04L08V
	 C2tmB+u0k+nGA==
Message-ID: <1e62d538-721f-486b-bb91-64864b3c5c8d@kernel.org>
Date: Thu, 20 Aug 2026 13:06:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
Content-Language: fr
To: gang.yan@linux.dev, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260819125629.49823-1-gang.yan@linux.dev>
 <20260819125629.49823-6-gang.yan@linux.dev>
 <20260819131205.3A0201F000E9@smtp.kernel.org>
 <7b85c6e1e4e270bd368fb7dc6d24279c1c20c3b2@linux.dev>
 <f9fe2eb6-e9ef-42d0-8a24-8f5c550f0c78@kernel.org>
 <74e63e9935103e9fab16ea81e0ea7480f9c7d736@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <74e63e9935103e9fab16ea81e0ea7480f9c7d736@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/08/2026 12:16, gang.yan@linux.dev wrote:
> August 20, 2026 at 5:07 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
>> Can you first check if this can happen? I thought that
>> mptcp_destroy_common would first close all subflows, remove the token,
>> then release everything linked to the PM → so the PM will no longer be
>> called at that point for this msk, right? (I didn't check)
>>
> 
> Hi Matt,
> 
> Thans for looking at this and kindly remind.
> Yes, I just checked the order you described is right, but I thought it
> could happen in such order:
> 
> CPU A (softirq)                                 CPU B(disconnect)
> ->subflow_token_join_request          
> ->mptcp_token_get_sock()
>                                               ->mptcp_destroy_common()
>                                               ->pm_ops_release
> ->mptcp_pm_get_local_id():
>   msk->pm.ops->get_local_id()   <- NULL deref

Ah yes, indeed, subflow_token_join_request doesn't hold the msk lock.

> WDYT?  And, I think the window seems too narrow, we may not see it in practice,
> maybe a NULL check is enough? 

Would it be safe to have a NULL check? Could you have something like this?

CPU A                              CPU B
-> if (ops)
                                    -> mptcp_destroy_common()
                                    -> pm_ops_release()
->     msk->pm.ops->get_local_id()

The BPF module might have been unloaded.

(Again, I didn't check in details, only looking at your reply.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

